#!/bin/sh
setxkbmap -query | awk '/layout/{print $2}'
