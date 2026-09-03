#!/usr/bin/env bash
# GNOME Terminal keeps its settings in dconf, not a plain config file, so it
# can't be symlinked like the rest of this repo. This applies font + the same
# Catppuccin Mocha palette used in tmux/alacritty to the default profile.
set -euo pipefail

command -v gsettings >/dev/null 2>&1 || exit 0

UUID="$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")"
[ -n "$UUID" ] || exit 0

PROFILE="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$UUID/"

gsettings set "$PROFILE" use-system-font false
gsettings set "$PROFILE" font "JetBrainsMono Nerd Font Mono 12"
gsettings set "$PROFILE" use-theme-colors false
gsettings set "$PROFILE" background-color "#1E1E2E"
gsettings set "$PROFILE" foreground-color "#CDD6F4"
gsettings set "$PROFILE" bold-color-same-as-fg true
gsettings set "$PROFILE" cursor-colors-set true
gsettings set "$PROFILE" cursor-background-color "#F5E0DC"
gsettings set "$PROFILE" cursor-foreground-color "#1E1E2E"
gsettings set "$PROFILE" palette "['#45475A', '#F38BA8', '#A6E3A1', '#F9E2AF', '#89B4FA', '#F5C2E7', '#94E2D5', '#BAC2DE', '#585B70', '#F38BA8', '#A6E3A1', '#F9E2AF', '#89B4FA', '#F5C2E7', '#94E2D5', '#A6ADC8']"

echo "Applied Catppuccin Mocha + JetBrainsMono Nerd Font Mono to GNOME Terminal profile $UUID"
