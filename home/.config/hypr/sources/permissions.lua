local rules = {
	screencopy = {
		"hyprpicker",
		"hyprlock",
		"xdg-desktop-portal-hyprland",
		"grim",
		"satty",
		"noctalia",
		"sunshine",
	},
	plugin = {
		"hyprpm",
	},
}

for permission, apps in pairs(rules) do
	for _, app in ipairs(apps) do
		hl.permission("/usr/bin/" .. app, permission, "allow")
	end
end
