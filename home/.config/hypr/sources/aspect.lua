-- Aspect: appearance, animations, layouts, groups
-- local colors = require("sources.colors")
local colors = require("noctalia").colors

-- Cursor
-- hl.exec_once("hyprctl setcursor Bibata-Modern-Amber 32")

-- Layer rules
hl.layer_rule({
	name = "layerrule-logout",
	match = { namespace = "logout_dialog" },
	blur = true,
})

hl.layer_rule({
	name = "layerrule-rofi-blur",
	match = { namespace = "rofi" },
	blur = true,
})

hl.layer_rule({
	name = "layerrule-rofi-anim",
	match = { namespace = "rofi" },
	animation = "popin",
})

hl.layer_rule({
	name = "layerrule-swaync",
	match = { namespace = "swaync-notification-window" },
	animation = "slide",
})

hl.layer_rule({
	name = "layerrule-ashell",
	match = { namespace = "ashell-main-layer" },
	animation = "slide",
})

-- Config: general, opengl, decoration, layouts
--
--
local active_color = { colors.primary, colors.secondary }
local inactive_color = "rgba(77777780)"

local function apply_style()
	hl.config({
		opengl = {
			nvidia_anti_flicker = false,
		},
		general = {
			border_size = 2,
			col = {
				nogroup_border = inactive_color,
				nogroup_border_active = { colors = active_color, angle = 130 },
				inactive_border = inactive_color,
				active_border = {
					colors = active_color,
					angle = 130,
				},
			},
			gaps_in = 15,
			gaps_out = 7,
			border_size = 2,
			col = {
				nogroup_border = inactive_color,
				nogroup_border_active = { colors = active_color, angle = 130 },
				inactive_border = inactive_color,
				active_border = {
					colors = active_color,
					angle = 130,
				},
			},
			layout = "dwindle",
		},
		decoration = {
			dim_special = 0.7,
			rounding = 13,
			inactive_opacity = 0.8,
			active_opacity = 1.0,
			fullscreen_opacity = 1.0,
			blur = {
				size = 3,
				noise = 0.1,
				ignore_opacity = true,
				passes = 4,
				new_optimizations = true,
				popups = true,
				special = true,
			},
			shadow = {
				range = 52,
				render_power = 2,
				color = "rgba(00000099)",
				color_inactive = "rgba(00000000)",
			},
		},
		animations = {
			enabled = true,
		},
		dwindle = {
			smart_split = false,
			preserve_split = true,
		},
		master = {
			new_status = "master",
		},
		group = {
			groupbar = {
				height = 8,
				col = {
					active = "rgba(FFADF455)",
					inactive = "rgba(00000000)",
				},
				indicator_height = 0,
				font_weight_active = "bold",
				text_color_inactive = "rgba(FFFFFFAF)",
			},
		},
	})
end

apply_style()

-- Bezier curves
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("easeInOut", { type = "bezier", points = { { 0.65, 0 }, { 0.35, 1 } } })
hl.curve("bounceOut", { type = "bezier", points = { { 0.57, 1.4 }, { 0.24, 0.95 } } })
hl.curve("easeOut", { type = "bezier", points = { { 0.25, 0.46 }, { 0.45, 0.94 } } })

-- Animations
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeInOut" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "bounceOut", style = "popin 50%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "bounceOut", style = "popin 10%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "easeInOut", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "bounceOut", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3, bezier = "easeOut" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "easeInOut", style = "fade" })

-- Special workspaces
hl.workspace_rule({
	workspace = "name:special:stash",
	gaps_out = 60,
	gaps_in = 30,
	border_size = 3,
})
hl.workspace_rule({
	workspace = "name:special:minimized",
	gaps_out = 60,
	gaps_in = 30,
	border_size = 3,
})
hl.workspace_rule({
	workspace = "name:special:exposed",
	gaps_out = 60,
	gaps_in = 30,
	border_size = 3,
})

return { reapply_borders = apply_style }
