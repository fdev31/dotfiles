-- Hide xwaylandvideobridge
hl.window_rule({
    name  = "windowrule-xwaylandvb",
    match = { class = "xwaylandvideobridge" },
    opacity          = "0.0 override",
    no_anim          = true,
    no_initial_focus = true,
    max_size         = "1 1",
    no_blur          = true,
})
