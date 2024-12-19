#!/usr/bin/bash

source $HOME/.config/nnn/plugins/wallpaper_helpers/helpers.sh

resp=

if [ -n "$1" ]; then
    if type nitrogen >/dev/null 2>&1; then
        printf "Set to full desktop or a specific monitors? [0, 1, etc. Defaults to full.]"
        read -r resp
        if [ "$resp" != "" ]; then
            nitrogen --set-zoom-fill --save "$1" --head="$resp"
        else
            nitrogen --set-zoom-fill --save "$1"
        fi
    elif type wal >/dev/null 2>&1; then
        wal -i "$1"
    else
        printf "nitrogen or pywal missing"
    fi
fi
