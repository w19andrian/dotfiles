#!/usr/bin/env bash

_project_home="${HOME}/Projekt/bol.com"
_project_ws=("W" "E" "R" "A" "S" "D" "F" "Z" "X" "C" "V")

proj_dir=$(find "$_project_home" -type d -mindepth 1 -maxdepth 1 | sort -r | fzf)
name=$(basename "$proj_dir")

empty_ws=()
while IFS= read -r ws; do
	empty_ws+=("$ws")
done < <(aerospace list-workspaces --monitor all --empty --json | jq -r '.[].workspace')

use_ws=""
for ws in "${_project_ws[@]}"; do
	if printf "%s\n" "${empty_ws[@]}"| grep -qx -- "$ws"; then
		use_ws="$ws"
        break
	fi
done

if [[ -z "$use_ws" ]]; then
	echo "🙅‍♂️  no empty workspace available"
    exit 1
fi

aerospace workspace --fail-if-noop "$use_ws"
alacritty --title "$name" -e tmux new-session -As "$name" -c "$proj_dir" & disown
echo "🚀 Finished setting up workspace $use_ws for project $name"
exit 0
