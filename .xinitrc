#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Load British Keymap and set Caps to Escape.
setxkbmap gb
xcape -e 'Shift_R=Return'

# Load xclickroot
xclickroot -r ~/src/xmenu/xmenu.sh &

# Load Compositor
picom &

# Set Root Window Name
slstatus &

thinkalert 5 100000 &

# Set a pretty wallpaper
feh --bg-fill ~/img/wall.jpg

# Launch Window Manager
exec dwm
