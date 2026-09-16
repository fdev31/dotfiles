-- Keybindings configuration
local vars = require("sources.variables")

local commands = require("wmcommands")

local mainMod = "SUPER"

-- ================================================================
-- GESTURES
-- ================================================================
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "vertical", action = "fullscreen" })

-- ================================================================
-- APPLICATION SHORTCUTS
-- ================================================================
hl.bind("Print", hl.dsp.exec_cmd("pypr menu screenshot"), { description = "Take a screenshot" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm-app firefox"), { description = "Open Firefox browser" })
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(vars.term), { description = "Open terminal" })
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(vars.pypr .. " toggle filemanager"), { description = "Toggle file manager" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(commands.lock), { description = "Lock screen" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd(commands.logout), { description = "Log out" })
hl.bind(
	mainMod .. " + SHIFT + P",
	hl.dsp.exec_cmd(vars.pypr .. ' menu "Copy password"'),
	{ description = "Copy password menu" }
)

-- ================================================================
-- MULTIMEDIA CONTROLS
-- ================================================================
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set '+5%'"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set '5%-'"), { locked = true, repeating = true })

-- ================================================================
-- WINDOW GROUP MANAGEMENT
-- ================================================================
hl.bind(
	mainMod .. " + SHIFT + G",
	hl.dsp.window.move({ out_of_group = true }),
	{ description = "Move window out of group" }
)
hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window grouping" })
hl.bind(mainMod .. " + TAB", hl.dsp.group.next(), { description = "Switch to next window in group" })

-- ================================================================
-- BASIC WINDOW ACTIONS
-- ================================================================
hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close active window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprshutdown"), { description = "Exit Hyprland" })
-- Toggle floating + center (multi-dispatch via lambda)
hl.bind(mainMod .. " + S", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.center())
end, { description = "Toggle floating mode" })
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen_state({ action = "toggle", internal = 2, client = 2 }),
	{ description = "Toggle fake fullscreen" }
)
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen_state({ action = "toggle", internal = 0, client = 2 }),
	{ description = "Toggle real fullscreen" }
)
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.pseudo(), { description = "Toggle pseudo mode" })
hl.bind(mainMod .. " + P", hl.dsp.focus({ monitor = "+1" }), { description = "Focus next monitor" })
hl.bind(mainMod .. " + O", hl.dsp.window.move({ monitor = "+1" }), { description = "Move window to next monitor" })
hl.bind(mainMod .. " + backspace", hl.dsp.layout("togglesplit"), { description = "Toggle window split" })

-- PiP mode (multi-dispatch via lambda)
hl.bind(mainMod .. " + ALT + I", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.pin())
end, { description = "Toggle PiP mode" })

-- ================================================================
-- ADVANCED WINDOW ACTIONS
-- ================================================================
hl.bind(
	mainMod .. " + SHIFT + Z",
	hl.dsp.exec_cmd(vars.pypr .. " zoom ++0.75"),
	{ description = "Increase zoom level" }
)
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(vars.pypr .. " zoom"), { description = "Reset zoom level" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(vars.pypr .. " menu"), { description = "Open pypr menu" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(commands.launcher), { description = "Open launcher menu" })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(vars.dnd), { description = "Toggle do not disturb" })
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(vars.pypr .. " toggle_dpms"), { description = "Toggle display power" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.pin(), { description = "Pin window" })
hl.bind(
	mainMod .. " + SHIFT + return",
	hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }),
	{ description = "Toggle window opacity" }
)

-- ================================================================
-- LAYOUT AND NAVIGATION
-- ================================================================
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd(vars.pypr .. " layout_center toggle"),
	{ description = "Toggle center layout" }
)
hl.bind(
	mainMod .. " + left",
	hl.dsp.exec_cmd(vars.pypr .. " layout_center prev"),
	{ description = "Previous window in layout" }
)
hl.bind(
	mainMod .. " + right",
	hl.dsp.exec_cmd(vars.pypr .. " layout_center next"),
	{ description = "Next window in layout" }
)
hl.bind(
	mainMod .. " + up",
	hl.dsp.exec_cmd(vars.pypr .. " layout_center prev2"),
	{ description = "Previous secondary window" }
)
hl.bind(
	mainMod .. " + down",
	hl.dsp.exec_cmd(vars.pypr .. " layout_center next2"),
	{ description = "Next secondary window" }
)

-- ================================================================
-- WINDOW MOVEMENT AND RESIZING
-- ================================================================

-- Swap windows
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }), { description = "Swap window left" })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { description = "Swap window right" })
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window up" })
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }), { description = "Swap window down" })

-- Move windows
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })

-- Resize windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- ================================================================
-- WORKSPACE NAVIGATION (French AZERTY Layout)
-- ================================================================
local azerty_keys = {
	"ampersand",
	"eacute",
	"quotedbl",
	"apostrophe",
	"parenleft",
	"minus",
	"egrave",
	"underscore",
	"ccedilla",
	"agrave",
}

for i, key in ipairs(azerty_keys) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i, follow = true }),
		{ description = "Move to workspace " .. i }
	)
end

-- ================================================================
-- WORKSPACE NAVIGATION ALTERNATIVES
-- ================================================================
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })
hl.bind(
	mainMod .. " + SHIFT + O",
	hl.dsp.exec_cmd(vars.pypr .. " shift_monitors +1"),
	{ description = "Shift monitors" }
)
hl.bind(mainMod .. " + U", hl.dsp.focus({ urgent_or_last = true }), { description = "Focus urgent or last window" })

hl.bind(mainMod .. " + Escape", hl.dsp.focus({ workspace = "previous" }), { description = "Previous workspace" })
hl.bind(
	mainMod .. " + K",
	hl.dsp.exec_cmd(vars.pypr .. " change_workspace +1"),
	{ description = "Next workspace via pypr" }
)
hl.bind(
	mainMod .. " + J",
	hl.dsp.exec_cmd(vars.pypr .. " change_workspace -1"),
	{ description = "Previous workspace via pypr" }
)
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace on monitor" })
hl.bind(
	mainMod .. " + SHIFT + J",
	hl.dsp.focus({ workspace = "m-1" }),
	{ description = "Previous workspace on monitor" }
)
hl.bind(
	mainMod .. " + ALT + K",
	hl.dsp.window.move({ workspace = "+1", follow = true }),
	{ description = "Move window to next workspace" }
)
hl.bind(
	mainMod .. " + ALT + J",
	hl.dsp.window.move({ workspace = "-1", follow = true }),
	{ description = "Move window to previous workspace" }
)

-- ================================================================
-- MOUSE BINDS
-- ================================================================
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ================================================================
-- SCRATCHPAD TERMINALS AND UTILITIES
-- ================================================================
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(vars.pypr .. " toggle btop"), { description = "Toggle btop system monitor" })
hl.bind(
	mainMod .. " + I",
	hl.dsp.exec_cmd(vars.pypr .. " toggle_special stash"),
	{ description = "Toggle stash scratchpad" }
)
hl.bind(
	mainMod .. " + N",
	hl.dsp.exec_cmd(vars.pypr .. " toggle_special minimized"),
	{ description = "Toggle minimized windows" }
)
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.workspace.toggle_special("stash"), { description = "Show stash workspace" })
hl.bind(
	mainMod .. " + SHIFT + N",
	hl.dsp.workspace.toggle_special("minimized"),
	{ description = "Show minimized workspace" }
)
hl.bind(
	mainMod .. " + SHIFT + M",
	hl.dsp.exec_cmd(vars.pypr .. " toggle stb stblogs"),
	{ description = "Toggle status bar logs" }
)
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(vars.pypr .. " toggle term"), { description = "Toggle terminal scratchpad" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(vars.pypr .. " toggle volume"), { description = "Toggle volume control" })
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(vars.pypr .. " attach"), { description = "Attach window to group" })

-- ================================================================
-- SYSTEM CONTROLS
-- ================================================================
-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(vars.pypr .. " bar toggle"), { description = "Restart Waybar" })
hl.bind(mainMod .. " + SHIFT + COMMA", hl.dsp.exec_cmd(commands.next_wallpaper))

hl.bind("ALT + TAB", hl.dsp.exec_cmd(commands.switch_window))
