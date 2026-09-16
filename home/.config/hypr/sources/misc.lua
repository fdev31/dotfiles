-- Misc, xwayland, render, cursor settings
hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms  = true,
        key_press_enables_dpms   = true,
        close_special_on_empty   = true,
        disable_autoreload       = true,
    },
    xwayland = {
        use_nearest_neighbor = false,
    },
    render = {
        direct_scanout = true,
    },
    cursor = {
        no_hardware_cursors = true,
    },
})
