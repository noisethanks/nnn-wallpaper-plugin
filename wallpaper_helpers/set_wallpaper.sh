#!/usr/bin/bash 

source $HOME/.config/nnn/plugins/wallpaper_helpers/helpers.sh

if [ -n "$1" ]; then
    # Ensure the selected file is an image
    if [ "$(file --mime-type "$1" | awk '{print $NF}' | awk -F '/' '{print $1}')" = "image" ]; then
        if [ "$XDG_SESSION_TYPE" = "x11" ]; then
            ~/.config/nnn/plugins/wallpaper_helpers/set_wallpaper_x11.sh "$1"
        elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
            ~/.config/nnn/plugins/wallpaper_helpers/set_wallpaper_wayland.sh "$1"
        else
            notify "Unsupported session type: $XDG_SESSION_TYPE\n" 
        fi
    else
        notify  "Selected file is not an image.\n" 
    fi
else
    notify "No image file provided. \n"
fi
