#!/bin/sh
weston --width 2000 --height 4000 &
sleep 3
waydroid session stop
konsole -e waydroid show-full-ui
