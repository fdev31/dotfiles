local autostart_apps = {
	"wl-paste --type text --watch cliphist store",
	"wl-paste --type image --watch cliphist store",
	"wl-paste -pw wl-copy",
}
hl.on("hyprland.start", function()
	for i, cmd in pairs(autostart_apps) do
		hl.exec_cmd("uwsm app " .. cmd)
	end
end)
