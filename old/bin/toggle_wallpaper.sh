#!/bin/bash
export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/

ice="$HOME/Pictures/ice.jpg"
black="$HOME/Pictures/black.jpg"

curr_pic=$(gsettings get org.gnome.desktop.background picture-uri)

gsettings set org.gnome.desktop.background picture-options 'stretched'
if [ "$curr_pic" = "'file://$ice'" ]
    then
    gsettings set org.gnome.desktop.background picture-uri "file://$black"
else
    gsettings set org.gnome.desktop.background picture-uri "file://$ice"
fi