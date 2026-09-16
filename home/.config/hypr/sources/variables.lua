-- Program variables and environment
local launch = "/usr/bin/uwsm-app -- "  -- faster but can't work on startup
local start  = "/usr/bin/uwsm app -- "  -- a bit slower but reliable

local vars = {
    launch      = launch,
    start       = start,
    term        = launch .. "kitty",
    filemanager = launch .. "nemo",
    pyprd       = launch .. "pypr",
    pypr        = launch .. "pypr-client",
    logouter    = launch .. "~/scripts/wmLogout.sh",
    switcher    = launch .. "~/scripts/winSwitcher.sh",
    dnd         = launch .. "~/scripts/doNotDisturb",
}

-- Environment variables
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_STYLE_OVERRIDE", "adwaita")

return vars
