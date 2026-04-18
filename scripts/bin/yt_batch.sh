#!/usr/bin/env bash
set -euo pipefail

FILE="${1:?Usage: $0 <urls.txt> [parallelism]}"
PARALLELISM="${2:-5}"

if command -v parallel &>/dev/null; then
    grep -v '^[[:space:]]*$' "$FILE" | parallel --progress -j "$PARALLELISM" yt-dlp -N 4
else
    run_job() { yt-dlp -N 4 "$1"; }
    export -f run_job
    grep -v '^[[:space:]]*$' "$FILE" | xargs -P "$PARALLELISM" -I{} bash -c 'run_job "$@"' _ {}
fi
