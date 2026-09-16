#!/bin/sh
cd ~/dev/std/blelight
uv run blelight color "{{colors.source.default.hex}}"
echo "{{colors.source.default.hex}}" > /tmp/foo

