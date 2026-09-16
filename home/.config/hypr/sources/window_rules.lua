-- Window rules

hl.window_rule({
    name  = "windowrule-mpv",
    match = { class = "mpv" },
    pseudo           = true,
    float            = true,
    keep_aspect_ratio = true,
})

hl.window_rule({
    name  = "windowrule-goodvibes",
    match = { class = "goodvibes" },
    pseudo = true,
})

hl.window_rule({
    name  = "windowrule-pulseUI",
    match = { class = "pulseUI" },
    pseudo = true,
})

hl.window_rule({
    name  = "windowrule-termlog",
    match = { class = "TermLog" },
    workspace = "9 silent",
})

hl.window_rule({
    name  = "windowrule-python3",
    match = { class = "python3" },
    float   = true,
    no_blur = true,
})

hl.window_rule({
    name  = "windowrule-neovide",
    match = { class = "neovide" },
    tile = true,
})

hl.window_rule({
    name  = "windowrule-wlogout",
    match = { class = "wlogout" },
    no_anim    = true,
    no_shadow  = true,
    float      = true,
    fullscreen = true,
})

hl.window_rule({
    name  = "windowrule-safeeyes",
    match = { class = "safeeyes" },
    no_anim    = true,
    no_shadow  = true,
    float      = true,
    fullscreen = true,
})

hl.window_rule({
    name  = "windowrule-gromit",
    match = { class = "Gromit-mpx" },
    no_blur = true,
})
