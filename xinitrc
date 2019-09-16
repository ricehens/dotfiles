export TERMINAL='urxvt'
xrandr --dpi 192
# setxkbmap -option ctrl:swapcaps
setxkbmap -option caps:ctrl_modifier -option compose:lctrl
/usr/local/bin/bright -set 1400
xinput set-prop 11 319 0.4
/home/ericshen/bin/fixm
exec i3
