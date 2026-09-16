-- Hyprland Lua Configuration
-- Main entry point

-- Load all modules
require("sources.variables") -- program paths, env vars
require("sources.custom") -- monitor config
require("sources.video_bridge") -- xwaylandvideobridge hide rule
require("sources.input") -- keyboard, touchpad, devices
require("sources.window_rules") -- window rules
require("sources.keybindings") -- all keybindings
require("sources.misc") -- misc settings
local aspect = require("sources.aspect") -- appearance, animations, layouts
require("sources.permissions") -- permissions for apps
require("sources.autostart") -- autostart apps

-- ================================================================
-- WINDOW RULES (from main config)
-- ================================================================

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- ================================================================
-- Misc config
-- ================================================================
hl.config({
	ecosystem = {
		enforce_permissions = true,
		no_donation_nag = true,
	},
	debug = {
		disable_logs = true,
	},
	binds = {
		allow_pin_fullscreen = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	aspect.reapply_borders()
end)

-- Noctalia Settings
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- For Noctalia Color templates
require("noctalia").apply_theme()
aspect.reapply_borders()
