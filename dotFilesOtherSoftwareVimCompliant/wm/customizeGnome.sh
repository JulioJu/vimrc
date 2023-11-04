#!/bin/bash
set -eux -o pipefail

# We could use dconf-editor too

# See also gnome-shell-extensions (package) and https://extensions.gnome.org/
# https://extensions.gnome.org/extension/1287/unite/

# https://askubuntu.com/questions/1388406/set-shortcut-to-move-between-windows-in-reverse
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>j']" && \
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Super>k']"
