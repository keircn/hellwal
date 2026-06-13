#!/usr/bin/env sh

# Set up wallpaper folder
wallpaper_path=$HOME/pics/wallpapers

# Run roxgen to generate templates and get color palette
./roxgen --image $wallpaper_path --random -f ./templates/

# Optionally you can load theme
#./roxgen -r -k ./themes/

# Obtain variables (color values, wallpaper path)
source ~/.cache/roxgen/variables.sh

# Run wallpaper daemon
swww img $wallpaper \
  --transition-type="grow" \
  --transition-duration 2 \
  --transition-fps 165 \
  --resize="crop" \
  --invert-y

# Update discord colors
themecord -p ~/.cache/roxgen/discord-colors.css

# Relaunch waybar to apply colors
    #wbar-reload

# Update firefox css
    #pywalfox update
