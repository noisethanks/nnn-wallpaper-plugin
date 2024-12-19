This is a modified version of the nnn wallpaper plugin that supports hyprland via hyprpaper. It provides a CLI menu of detected displays, and upon selecting one, it immediately applies the wallpaper and also modifies hyprpaper.conf to persist the changes.
Existing functionality has been moved to it's own files, for ease of maintenance.
## USAGE
Simply delete the old wallpaper plugin, and clone the contents of this repo into place.

Also, the hyprland/hyprpaper script should work standalone.

```
./set_wallpaper_hyprland.sh ~/path/to/wallpaper
```

