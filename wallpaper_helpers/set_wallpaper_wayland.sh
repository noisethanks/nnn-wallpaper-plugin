#!/usr/bin/bash

source $HOME/.config/nnn/plugins/wallpaper_helpers/helpers.sh

if [ -n "$1" ]; then
    if type swww >/dev/null 2>&1; then
        swww img "$1"
    elif type hyprctl >/dev/null 2>&1; then
        ~/.config/nnn/plugins/wallpaper_helpers/set_wallpaper_hyprland.sh "$1"
    else
        notify "Cannot find swww or hyprctl"
    fi
fi
