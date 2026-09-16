local use_pypr = false

if use_pypr then
	return {
		next_wallpaper = "pypr wall next",
		launcher = "rofi -modes combi -combi-modes drun,window -show combi",
		lock = "hyprlock --grace 1",
		switch_window = "",
		logout = "~/scripts/wmLogout.sh",
	}
end

-- defaults to noctalia
return {
	next_wallpaper = "noctalia msg wallpaper-next; sleep 2; hyprctl reload",
	launcher = "noctalia msg panel-open launcher",
	switch_window = "noctalia msg window-switcher",
	lock = "noctalia msg session lock",
	logout = "noctalia msg session logout",
}
