#!/usr/bin/env bash

i3-msg "workspace number 1; rename workspace 1 to 1: 🌏 www; exec --no-startup-id zen-browser; exec --no-startup-id 1password; exec --no-startup-id nordvpn-gui"
sleep 1
i3-msg "workspace number 2; rename workspace 2 to 2: 👾 term; exec --no-startup-id alacritty"
sleep 0.5
i3-msg "workspace number 3; rename workspace 3 to 3: 🎧 sptfy; exec --no-startup-id spotify-launcher"
sleep 0.5
i3-msg "workspace number 1"
