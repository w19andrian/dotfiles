#!/usr/bin/env bash

BASE_CONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH="" # Initialize OS_ARCH; Will be populated by get_arch()

get_arch() {
	if [[ "${OS_NAME}" == "darwin" ]]; then
		OS_ARCH=$(uname -m | tr '[:upper:]' '[:lower:]')
	elif [[ "${OS_NAME}" == "linux" ]]; then
		OS_ARCH=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
	else
		echo "Error: unsupported OS: ${OS_NAME}"
		exit 1
	fi
}

generate_conf() {
	local app_name="${1}"
	local tpl_dir="${BASE_CONF_DIR}/templates/${app_name}"
	local _sed_cmd_opts

	if [[ "${OS_NAME}" == "darwin" ]]; then
		_sed_cmd_opts="-i ''"
	else
		_sed_cmd_group="--in-place"
	fi

	if [ ! -d "${tpl_dir}" ]; then
		return
	fi

	for f in "${tpl_dir}"/*.tpl; do
		tmpfile=$(mktemp)
		trap 'rm -f "${tmpfile}"' EXIT INT TERM HUP

		dst_filename=$(basename "${f}" | sed "s/\.tpl//")
		dst_fullpath="${BASE_CONF_DIR}/${app_name}/${dst_filename}"

		cp "${f}" "${tmpfile}"

		sed "${_sed_cmd_opts}" "s/#OS_NAME/${OS_NAME}/g" "${tmpfile}"
		sed "${_sed_cmd_opts}" "s/#OS_ARCH/${OS_ARCH}/g" "${tmpfile}"

		cp "${tmpfile}" "${dst_fullpath}"

		rm -f "${tmpfile}"
	done
}

APPS=("alacritty")

for f in "${APPS[@]}"; do
	generate_conf "${f}"
done
