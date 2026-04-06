#!/usr/bin/env bash

VERSION="1.19.6b"
ARCH="$(uname --machine)"
FILENAME="zen.linux-${ARCH}.tar.xz"
_tmp_dir="$(mktemp --directory)"

# download archive file and store in /tmp
curl --location --remote-name --output-dir "$_tmp_dir" "https://github.com/zen-browser/desktop/releases/download/${VERSION}/${FILENAME}"

# remove existing/old zen installation
test [[ -d /usr/local/src/zen ]] && rm -rf /usr/local/src/zen

# extract zen browser archive
tar --extract --verbose --file "$_tmp_dir/${FILENAME}" --directory /usr/local/src
chown root:root /usr/local/src/zen

cat <<EOF >"$_tmp_dir/zen-browser.desktop"
[Desktop Entry]
Name=Zen Browser
Exec=/usr/local/src/zen/zen-bin
Icon=/usr/local/src/zen/browser/chrome/icons/default/default128.png
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;application/x-xpinstall;application/pdf;application/json;
StartupWMClass=zen-alpha
Categories=Network;WebBrowser;
StartupNotify=true
Terminal=false
X-MultipleArgs=false
Keywords=Internet;WWW;Browser;Web;Explorer;
Actions=new-window;new-private-window;profilemanager;

[Desktop Action new-window]
Name=Open a New Window
Exec=/usr/local/src/zen/zen-bin

[Desktop Action new-private-window]
Name=Open a New Private Window
Exec=/usr/local/src/zen/zen-bin --private-window

[Desktop Action profilemanager]
Name=Open the Profile Manager
Exec=/usr/local/src/zen/zen-bin --ProfileManager
EOF

mv "$_tmp_dir/zen-browser.desktop" /usr/share/applications/zen-browser.desktop
chown root:root /usr/share/applications/zen-browser.desktop

ln --symbolic /usr/local/src/zen/zen-bin /usr/local/bin/zen-bin
