export TERMINAL='urxvt'
xrandr --dpi 192
# setxkbmap -option ctrl:swapcaps
setxkbmap -option caps:ctrl_modifier -option compose:lctrl
/usr/local/bin/bright -set 1000
xinput set-prop 11 319 0.4
xset -dpms s off
/home/ericshen/bin/fixm
exec i3
