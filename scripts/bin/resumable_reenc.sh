#!/usr/bin/env bash
# Chunked x265 HDR10 encoder with safe resume & concat
# Usage: ./chunk_encode.sh /path/to/media_dir

set -euo pipefail

# ====== KNOBS ======
SEG=60                # seconds per segment (1 minute)
CRF=20
PRESET=slow
POOLS=12              # x265 worker threads (use 10 of 12)
FRAME_THREADS=2
# ===================

MEDIA_DIR="${1:-}"
[[ -n "${MEDIA_DIR}" && -d "${MEDIA_DIR}" ]] || { echo "Usage: $0 /path/to/media_dir"; exit 1; }

TMP_DIR="${MEDIA_DIR%/}/.tmp"
OUT_DIR="${MEDIA_DIR%/}/encoded"
mkdir -p "$TMP_DIR" "$OUT_DIR"

have_cmd() { command -v "$1" >/dev/null 2>&1; }
have_cmd ffmpeg || { echo "ERROR: ffmpeg not found in PATH"; exit 1; }
have_cmd ffprobe || { echo "ERROR: ffprobe not found in PATH"; exit 1; }

# Sum durations (float seconds) fed on stdin; prints one float
sum_durations() { awk 'BEGIN{s=0} {s+= $1} END{printf "%.3f\n", s}'; }

# Calculate a sensible GOP from FPS; fallback to 24fps assumptions
calc_gop_params() {
  local in="$1"
  local fps_str fps_num keyint minkey
  fps_str=$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate \
            -of default=nk=1:nw=1 "$in" || echo "")
  # r_frame_rate like "24000/1001" or "25/1"
  if [[ -n "$fps_str" ]]; then
    fps_num=$(awk -v r="$fps_str" 'BEGIN{ split(r,a,"/"); if (a[2]==0||a[2]=="") print 0; else printf "%.3f", a[1]/a[2]; }')
  else
    fps_num=0
  fi
  if awk "BEGIN{exit !($fps_num>0)}"; then
    keyint=$(awk -v f="$fps_num" 'BEGIN{printf "%d", int(f*10 + 0.5)}')   # ~10s GOP
    minkey=$(awk -v f="$fps_num" 'BEGIN{printf "%d", int(f + 0.5)}')      # ~1s min
  else
    keyint=240  # fallback for ~23.976
    minkey=23
  fi
  echo "$keyint" "$minkey"
}

encode_one() {
  local in="$1"
  local base="$(basename "${in%.*}")"
  local work="${TMP_DIR}/${base}"
  local part_prefix="${work}/part"
  mkdir -p "$work"

  # Derive tailored GOP from FPS
  read -r KEYINT MINKEY <<<"$(calc_gop_params "$in")"

  # x265 options
  local X265_OPTS="hdr10=1:hdr10_opt=1:repeat-headers=1:colorprim=bt2020:transfer=smpte2084:colormatrix=bt2020nc:open-gop=0:scenecut=0:pools=${POOLS}:frame-threads=${FRAME_THREADS}:keyint=${KEYINT}:min-keyint=${MINKEY}"

  # Collect existing parts; filter out obviously bad ones
  mapfile -t parts_all < <(ls -1 "${part_prefix}_"*.mkv 2>/dev/null | sort || true)
  parts_good=()
  if (( ${#parts_all[@]} > 0 )); then
    local last="${parts_all[-1]}"
    for f in "${parts_all[@]}"; do
      # zero-size or unreadable? skip
      [[ -s "$f" ]] || continue
      dur="$(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "$f" || echo 0)"
      # keep segments >= 59s; allow short final segment (>1s)
      if [[ "$f" == "$last" ]]; then
        awk "BEGIN{exit !($dur>1)}" || continue
      else
        awk "BEGIN{exit !($dur>=59)}" || continue
      fi
      parts_good+=("$f")
    done
  fi

  local next_idx=${#parts_good[@]}
  local elapsed="0.000"
  if (( next_idx > 0 )); then
    elapsed="$(for f in "${parts_good[@]}"; do
      ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "$f"
    done | sum_durations)"
    local last_dur
    last_dur="$(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "${parts_good[-1]}")"
    printf "Resuming %-40s at t=%ss (good segments=%d, last=%ss)\n" "$base" "$elapsed" "$next_idx" "$last_dur"
  else
    printf "Starting  %-40s at t=0s\n" "$base"
  fi

  # Encode (place -ss AFTER -i for safer timestamps on resume)
  if awk "BEGIN{exit !($elapsed>0)}"; then
    ffmpeg -hide_banner -nostdin -i "$in" -ss "$elapsed" -map 0 -map -0:d \
      -c:v libx265 -pix_fmt yuv420p10le -preset "$PRESET" -crf "$CRF" \
      -x265-params "$X265_OPTS" \
      -c:a copy -c:s copy \
      -force_key_frames "expr:gte(t,n_forced*${SEG})" \
      -f segment -segment_time "$SEG" -reset_timestamps 1 \
      -segment_start_number "$next_idx" \
      -max_interleave_delta 0 -y \
      "${part_prefix}_%03d.mkv"
  else
    ffmpeg -hide_banner -nostdin -i "$in" -map 0 -map -0:d \
      -c:v libx265 -pix_fmt yuv420p10le -preset "$PRESET" -crf "$CRF" \
      -x265-params "$X265_OPTS" \
      -c:a copy -c:s copy \
      -force_key_frames "expr:gte(t,n_forced*${SEG})" \
      -f segment -segment_time "$SEG" -reset_timestamps 1 \
      -segment_start_number 0 \
      -max_interleave_delta 0 -y \
      "${part_prefix}_%03d.mkv"
  fi

  # Re-scan parts after encode (include the newly written ones)
  mapfile -t parts_all < <(ls -1 "${part_prefix}_"*.mkv | sort)
  parts_good=()
  local last="${parts_all[-1]}"
  for f in "${parts_all[@]}"; do
    [[ -s "$f" ]] || continue
    dur="$(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "$f" || echo 0)"
    if [[ "$f" == "$last" ]]; then
      awk "BEGIN{exit !($dur>1)}" || continue
    else
      awk "BEGIN{exit !($dur>=59)}" || continue
    fi
    parts_good+=("$f")
  done

  # Build concat list only from good parts
  local list="${work}/list.txt"
  : > "$list"
  for f in "${parts_good[@]}"; do printf "file '%s'\n" "$f" >> "$list"; done

  # Stitch losslessly to final MKV
  local final="${OUT_DIR}/${base}.mkv"
  ffmpeg -hide_banner -nostdin -f concat -safe 0 -i "$list" -c copy -map 0 -y "$final"

  echo "✅ Finished: $final"
}

export -f encode_one sum_durations calc_gop_params
export SEG CRF PRESET POOLS FRAME_THREADS TMP_DIR OUT_DIR

# Process each MKV in the directory (sorted, spaces-safe)
find "$MEDIA_DIR" -maxdepth 1 -type f -name '*.mkv' -print0 \
  | sort -z \
  | while IFS= read -r -d '' f; do
      encode_one "$f"
    done

