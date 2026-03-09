# this file is auto generated.
# make the changes in 'templates/alacritty/alacritty.toml.tpl'
# then execute scripts/bin/generate_config.sh from root project directory

[general]
import = [
	"themes/themes/vesper.toml",
	"alacritty.d/keybindings.#OS_TYPE.toml",
]

[window]
startup_mode = "Maximized"

[font]
normal = { family = "JetBrainsMono Nerd Font Mono", style = "Regular" }
size = 12.00

[env]
TERM = "xterm-256color"

