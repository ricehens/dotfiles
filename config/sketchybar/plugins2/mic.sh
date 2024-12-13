#!/bin/bash

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
  ICON=󰢳
elif [[ $MIC_VOLUME -gt 0 ]]; then
  ICON=󰍬
fi 
  
sketchybar -m --set mic icon="$ICON" label="$MIC_VOLUME%"
