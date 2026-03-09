#!/usr/bin/env bash

BASE_CONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

OS_TYPE=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(uname --machine | tr '[:upper:]' '[:lower:]')

function generate_conf() {
	local app_name="${1}"
	local tpl_dir="${BASE_CONF_DIR}/templates/${app_name}"

	if [ ! -d "${tpl_dir}" ]; then
		return
	fi

	for f in "${tpl_dir}"/*.tpl; do
		tmpfile=$(mktemp)
		trap 'rm -f "${tmpfile}"' EXIT INT TERM HUP

		dst_filename=$(basename "${f}" | sed "s/\.tpl//")
		dst_fullpath="${BASE_CONF_DIR}/${app_name}/${dst_filename}"

		cp "${f}" "${tmpfile}"

		sed --in-place "s/#OS_TYPE/${OS_TYPE}/g" "${tmpfile}"
		sed --in-place "s/#OS_ARCH/${OS_ARCH}/g" "${tmpfile}"

		cp "${tmpfile}" "${dst_fullpath}"

		rm -f "${tmpfile}"
	done
}

APPS=("alacritty")

for f in "${APPS[@]}"; do
	generate_conf "${f}"
done
