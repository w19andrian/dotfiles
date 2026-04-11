#!/usr/bin/env bash
set -euo pipefail

FILE="${1:?Usage: $0 <urls.txt>}"

while IFS= read -r url || [[ -n "$url" ]]; do
    [[ -z "$url" ]] && continue
    yt-dlp -N 4 "$url"
done < "$FILE"
