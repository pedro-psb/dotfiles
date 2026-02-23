#!/bin/bash
set -eu

DCONF_USER_SETTINGS="$HOME/.config/dconf/settings.ini"
dconf load / < "$DCONF_USER_SETTINGS"
