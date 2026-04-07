#!/usr/bin/env bash

# TODO: make this less messy

_tmp_dir="$(mktemp --directory)"

if [[ "$(uname)" != "Linux" ]]; then
	echo "Unsupported OS. Exitting with error"
	exit 1
fi

if ! [ "$(id --user)" = 0 ]; then
	echo "this script requires sudo. Exitting"
	exit 1
fi

ARCH="$(uname --machine)"

test ! -d /usr/local/pandora && mkdir -p /usr/local/pandora

FD_NAME="fd"
FD_VERSION="v10.4.2"
FD_FULLNAME="${FD_NAME}-${FD_VERSION}-${ARCH}-unknown-linux-musl"

curl \
	--location \
	--remote-name \
	--output-dir "$_tmp_dir" \
	"https://github.com/sharkdp/fd/releases/download/${FD_VERSION}/${FD_FULLNAME}.tar.gz"

tar --extract --gzip --verbose --file "${_tmp_dir}/${FD_FULLNAME}.tar.gz" --directory="${_tmp_dir}"

test -d "/usr/local/pandora/${FD_NAME}" && rm -rf "/usr/local/pandora/${FD_NAME}"

mv "${_tmp_dir}/${FD_FULLNAME}" "/usr/local/pandora/${FD_NAME}"

RG_NAME="ripgrep"
RG_VERSION="15.1.0"
RG_FULLNAME="${RG_NAME}-${RG_VERSION}-${ARCH}-unknown-linux-musl"
curl \
	--location \
	--remote-name \
	--output-dir "$_tmp_dir" \
	"https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${RG_FULLNAME}.tar.gz"

tar --extract --gzip --verbose --file "${_tmp_dir}/${RG_FULLNAME}.tar.gz" --directory="${_tmp_dir}"

test -d "/usr/local/pandora/${RG_NAME}" && rm -rf "/usr/local/pandora/${RG_NAME}"

mv "${_tmp_dir}/${RG_FULLNAME}" "/usr/local/pandora/${RG_NAME}"

TS_NAME="tree-sitter-linux-x64"
TS_VERSION="v0.26.8"
curl \
	--location \
	--remote-name \
	--output-dir "$_tmp_dir" \
	"https://github.com/tree-sitter/tree-sitter/releases/download/${TS_VERSION}/${TS_NAME}.gz"

gzip --decompress "$_tmp_dir/$TS_NAME.gz"

test ! -d "$_tmp_dir/$TS_NAME" && mkdir /usr/local/pandora/tree-sitter

mv "$_tmp_dir/$TS_NAME" /usr/local/pandora/tree-sitter/tree-sitter
chmod +x /usr/local/pandora/tree-sitter/tree-sitter

NVIM_NAME="nvim-linux-${ARCH}"
NVIM_VERSION="v0.12.1"
curl \
	--location \
	--remote-name \
	--output-dir "$_tmp_dir" \
	"https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_NAME}.tar.gz"

tar --extract --verbose --gzip --file "$_tmp_dir/$NVIM_NAME.tar.gz" --directory="/usr/local/pandora"

rm -rf "$_tmp_dir"
