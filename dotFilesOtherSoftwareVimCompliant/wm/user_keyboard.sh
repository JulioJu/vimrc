#!/bin/bash
# -*- coding: UTF8 -*-

USERID=julioprayer
export DISPLAY=":0"
export XAUTHORITY="/home/$USERID/.Xauthority"
xinput float "AT Translated Set 2 keyboard"
xkbcomp -w9 /opt/lafayette_linux_v0.6.xkb $DISPLAY
# « Shuffle » key on TypeMatrix
xmodmap -e "keycode 102 = Shift_L"
# « Dsktp » key on TypeMatrix
xmodmap -e "keycode 100 = Shift_L"
# Doesn't work:
# xmodmap -e "keycode 100 = Shift_R" &
