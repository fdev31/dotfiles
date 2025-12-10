#!/bin/sh
FN="/tmp/shot.png"

sleep 0.2

grimshot save area $FN

exec satty --filename "${FN}" --output-filename "/tmp/annotated.png"

# exec swappy -f $FN
# export SDL_VIDEODRIVER=x11
export ANNOTATED="/tmp/annotated.png"
exec ynot3 $FN
