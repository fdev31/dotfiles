#!/bin/sh
# exec caelestia shell drawers toggle launcher
exec rofi -modes combi -combi-modes drun,window -show combi
exec fabric-cli exec ax-shell 'notch.open_notch("launcher")'
exec walker
exec rofi -show combi -combi-modi window,drun,run -modi combi -theme ~/.config/rofi/launchers/colorful/custom

## WOFI VERSION
TMP=$(mktemp)
hyprctl clients -j | jq '.[]|.address,.class,.title' | sed -e '$!{s/$/ /;N;s/\n/ /; s/"//g;N;s/\n/  /}' >$TMP
idx=$(sed -E 's/^[a-f0-9x]+ //' $TMP | wofi --show dmenu,drun,run --insensitive)

if [ "$?" == 0 ]; then
    addr=$(grep "$idx" "$TMP" | cut -d ' ' -f1)
    hyprctl dispatch focuswindow address:$addr
fi
rm $TMP
