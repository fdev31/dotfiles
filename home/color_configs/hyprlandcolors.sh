#!/bin/sh

COLOR='{angle=130, colors={"rgb({{colors.primary.default.hex_stripped}})" , "rgb({{colors.secondary.default.hex_stripped}})"}}'
hyprctl eval "hl.config({general={col={active_border=$COLOR, nogroup_border_active=$COLOR}}})"
hyprctl eval 'hl.config({decoration={shadow={color="rgba({{colors.on_primary.default.hex_stripped | set_lightness: -12 }}A0)"}}})'
