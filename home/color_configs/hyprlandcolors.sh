#!/bin/sh

hyprctl keyword general:col.active_border "rgb({{colors.primary.default.hex_stripped}}) rgb({{colors.tertiary.default.hex_stripped}}) 30deg"
hyprctl keyword decoration:shadow:color "rgb({{colors.primary.default.hex_stripped}})"
