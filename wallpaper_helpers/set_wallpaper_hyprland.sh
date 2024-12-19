#!/usr/bin/bash
# Uses hyprpaper
source $HOME/.config/nnn/plugins/wallpaper_helpers/helpers.sh

if [ -n "$1" ]; then
    # Ensure the selected file is an image
    if [ "$(file --mime-type "$1" | awk '{print $NF}' | awk -F '/' '{print $1}')" = "image" ]; then
        if type hyprctl >/dev/null 2>&1 && type hyprpaper >/dev/null 2>&1; then
            # Fetch the current wallpaper and monitor details
            printf "Available monitors:\n"
            hyprctl monitors | grep -oP 'Monitor\s+\K.*' | nl
            printf "Select a monitor [number]: "
            read -r monitor_index
            # Get the monitor name based on the user's selection
            monitor_name=$(hyprctl monitors | grep -oP 'Monitor\s+\K.*' | sed -n "${monitor_index}p" | cut -d ' ' -f1)
            if [ -n "$monitor_name" ]; then
                # Get the current wallpaper path from the hyprpaper.conf file
                wallpapers_conf="$HOME/.config/hypr/hyprpaper.conf"
                current_wallpaper=$(grep "$monitor_name" $wallpapers_conf | cut -d '=' -f2 |cut -d "," -f2)
                # Reload a new wallpaper using the absolute path
                absolute_path=$(realpath "$1")
                relative_path=$(echo "$absolute_path" | sed "s|^$HOME|\~|")
                current_wallpaper=$(echo "$current_wallpaper" | sed "s|~\/|\\~\/|")
                printf "Reloading and setting wallpaper on monitor '%s'.\n" "$monitor_name"
                hyprctl hyprpaper reload "$monitor_name, $relative_path"
                if [ -f "$wallpapers_conf" ]; then
                    if grep -q "^\s*wallpaper\s*=\s*$monitor_name,$current_wallpaper" "$wallpapers_conf"; then
                       sed -i "/^\s*wallpaper\s*=\s*$monitor_name,/s|,\s*.*|,$relative_path|" "$wallpapers_conf"
                        if grep -q "^\s*preload\s*=\s*$current_wallpaper" "$wallpapers_conf"; then
                            sed -i "/^\s*preload\s*=\s*$(printf '%s' "$current_wallpaper" | sed 's/[&/|]/\\&/g')/s|=.*|=$(printf '%s' "$relative_path" | sed 's/[&/|]/\\&/g')|" "$wallpapers_conf"
                        else
                            notify "Error finding preload = command in wallpaper config file."
                        fi
                    else
                        notify "Error finding wallpaper = line in wallpaper config file."
                    fi
                else
                    notify "wallpapers.conf file not found. Skipping persistence."
                fi
            else
                notify "Invalid monitor selection. Exiting."
            fi
        else
            notify "hyprctl or hyprpaper missing"
        fi
    else
        notify "Selected file is not an image.\n"
    fi
else
    notify "No image file provided.\n"
fi
