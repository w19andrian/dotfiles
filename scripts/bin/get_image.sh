#!/usr/bin/env bash
set -euo pipefail

registries=("")

# Select registry
if [[ ${#registries[@]} -gt 1 ]]; then
	reg=$(printf "%s\n" "${registries[@]}" | fzf)
else
	reg="${registries[0]}"
fi

# One-time fetch of all image metadata
repo_json=$(gcloud artifacts docker images list "$reg" --include-tags --format=json)

# Extract and let user select an image (package name)
img_name=$(echo "$repo_json" | jq -r '.[].package' | sort -u | fzf)
[[ -z "$img_name" ]] && {
	echo "No image selected"
	exit 1
}

# Extract tags for selected image
img_tag=$(echo "$repo_json" |
	jq -r --arg pkg "$img_name" '.[] | select(.package == $pkg) | .tags[]?' |
	sort -u | fzf)
[[ -z "$img_tag" ]] && {
	echo "No tag selected"
	exit 1
}

# Find the digest for the selected image+tag
digest=$(echo "$repo_json" |
	jq -r --arg pkg "$img_name" --arg tag "$img_tag" \
		'.[] | select(.package == $pkg and (.tags[]? == $tag)) | .version' |
	head -n1)
[[ -z "$digest" ]] && {
	echo "No digest found for $img_name:$img_tag"
	exit 1
}

# Final output
img_output="${img_name}:${img_tag}@${digest}"

if [[ $(crane validate --remote "$img_output") ]]; then
	echo "====================================="
	echo "Fully qualified image name"
	echo "====================================="
	printf "$img_output" | pbcopy
	echo "$img_output"
else
	echo "====================================="
	echo "Invalid image"
	echo "====================================="
fi
