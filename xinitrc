export TERMINAL='urxvt'
xrandr --dpi 192
# setxkbmap -option ctrl:swapcaps
# setxkbmap -option caps:ctrl_modifier -option compose:lctrl
setxkbmap -option compose:caps
/usr/local/bin/bright -set 400
xinput set-prop 11 319 0.4
xinput set-prop 11 309 0
xset -dpms s off
/home/ericshen/bin/fixm
exec i3
