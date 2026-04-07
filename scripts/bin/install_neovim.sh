#!/usr/bin/env bash

NVIM_VERSION="v0.12.1"
TREESITTER_VERSION="v0.26.8"
ARCH=""
_tmp_dir="$(mktemp --directory)"

get_arch() {
	if [[ "$(uname)" != "Linux" ]]; then
		echo "Unsupported OS. Exitting with error"
		exit 1
	fi

	ARCH="$(uname --machine)"
}

if ! [ "$(id --user)" = 0 ]; then
	echo "this script requires sudo. Exitting"
	exit 1
fi

get_arch

NVIM_NAME="nvim-linux-${ARCH}"

curl \
	--location \
	--remote-name \
	--output-dir "$_tmp_dir" \
	"https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_NAME}.tar.gz"

TS_NAME="tree-sitter-linux-x64"
curl \
    --location \
    --remote-name \
    --output-dir "$_tmp_dir" \
    "https://github.com/tree-sitter/tree-sitter/releases/download/${TREESITTER_VERSION}/${TS_NAME}.gz"

test ! -d /usr/local/pandora && mkdir -p /usr/local/pandora

tar --extract --verbose --gzip --file "$_tmp_dir/$NVIM_NAME.tar.gz" --directory="/usr/local/pandora"

gzip --decompress "$_tmp_dir/$TS_NAME.gz"
test ! -d "$_tmp_dir/$TS_NAME" && mkdir /usr/local/pandora/tree-sitter
mv "$_tmp_dir/$TS_NAME"  /usr/local/pandora/tree-sitter/tree-sitter
chmod +x /usr/local/pandora/tree-sitter/tree-sitter

rm -rf "$_tmp_dir"
