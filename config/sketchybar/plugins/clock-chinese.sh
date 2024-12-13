#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set "$NAME" label="$(LC_TIME=zh_CN.utf-8 date '+%-m月%-d日 周%a %H:%M:%S')"

