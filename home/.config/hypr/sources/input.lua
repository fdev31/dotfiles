-- Input configuration
hl.config({
    input = {
        numlock_by_default = true,
        kb_layout  = "fr,us",
        kb_model   = "pc105",
        kb_options = "grp:shifts_toggle,compose:rctrl",
        repeat_rate  = 70,
        sensitivity  = 0,
        follow_mouse = 1,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Per-device config
hl.device({
    name      = "wacom-intuos-pt-m-pen",
    output    = "DP-1",
    transform = 0,
})
