export GTK_THEME=adw-gtk3-dark
export GTK_ICON_THEME=Papirus-Dark

if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec sway --unsupported-gpu
fi
