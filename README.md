# Pedro's Dotfiles

My personal dotfiles using stow and ansbile.

## Usage

### Install

Install dotfiles from specific package in the host machine.
A "package" is any dir under the `stow/` directory.

```bash
stow -d stow -t "$HOME" <package> [package ...]
```

### Track new settings

To track configuration files for a given package do:

1. Copy the exact tree to `stow/{package-name}` (e.g, bash, vim, ...)
2. Override original setting files with symlinks from this repository

```bash
# Copy settings preserving the tree and relative to $HOME
rasync -avR $HOME/./.config/program/setting.toml

# Override original settings with symlinks to the stow package
stow -d stow -t "$HOME" --adopt program
```

## Package specific notes

### Gnome

Gnome settings are managed with dconf (not text-based configuration system).
As a workaround, the script `scripts/update-gnome.sh` loads the config from
the `settings.ini` configuration tracked by this repository.
