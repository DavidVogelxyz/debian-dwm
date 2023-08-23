#!/bin/sh

# change default font by editing st's config.h and then recompiling it

# arandr/xrandr and setbg
	# specifically on VMs, the screen size defaults to 1200x800
 	# the following alias will run a command to resize

 alias \
	 screen-resolution-fix="xrandr -s 1920x1080 && xrandr --dpi 96 && setbg"
 
# p10k configure
