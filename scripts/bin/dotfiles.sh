#!/usr/bin/env bash

backup_dir="${HOME}/config.bak"
backup_id="$(date +"%Y%m%d%H%M%3N")"
os_type=$(uname)

for df in * ; do
  if [[ "$df" == "scripts" ]]; then
    continue
  fi
  
  src="${PWD}/$df"
  conf="${HOME}/.config/$df"
  if [ -d "$conf" ] && ! [ -L "$conf" ]; then
    rsync -az "$conf" "$backup_id.$backup_dir"
    rm "$conf"
  fi

  if [[ "$df" == "zsh" ]]; then
    ln -sf "$src/.zshrc" "${HOME}/.zshrc"
  else
    rm -r "$conf"
    ln -s "$src" "$conf"
  fi

done
