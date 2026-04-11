#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:?Usage: $0 <directory>}"

find "$TARGET" -mindepth 2 -type f | while IFS= read -r file; do
	filename="${file##*/}"
	dest="$TARGET/$filename"

	if [[ -e "$dest" ]]; then
		base="${filename%.*}"
		ext="${filename##*.}"
		[[ "$base" == "$ext" ]] && ext="" # no extension
		i=1
		while [[ -e "$dest" ]]; do
			dest="$TARGET/${base}_${i}${ext:+.$ext}"
			((i++))
		done
	fi

	mv "$file" "$dest"
done

find "$TARGET" -mindepth 1 -type d -empty -delete
