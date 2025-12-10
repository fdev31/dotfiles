#!/bin/sh
# Full monitor:
#mon=$(hyprctl monitors -j | jq '.[] | select (.focused) | "\(.x),\(.y) \(.width)x\(.height)" ' | sed 's/"//g')
wf-recorder -g "$(slurp)"
