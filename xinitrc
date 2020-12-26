# locale
export LANG=zh_CN.UTF-8

# x terminal
export TERMINAL='urxvt'

# decrease trackpoint acceleration
# more settings in /etc/udev/rules.d/10-trackpoint.rules
# xinput set-prop 13 "libinput Accel Speed" -0.40

# caps = compose
# (alr used udev to swap caps / ctrl)
setxkbmap -option compose:caps

# brightness
/usr/local/bin/bright -set 8000

# do not auto suspend
xset -dpms s off

# connect to monitor if exists
/home/ericshen/bin/fixm

# start i3wm
exec i3
