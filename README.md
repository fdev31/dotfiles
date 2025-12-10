# fab's desktop environment

Dotfiles for an hyprland based desktop.

![image](https://raw.githubusercontent.com/fdev31/dotfiles/refs/heads/main/screenshots/1.png)

Currently using:

- [ashell](https://github.com/MalpenZibo/ashell/)
- [pyprland](https://github.com/fdev31/pyprland)
- zsh
- kitty
- matugen
- hyprpaper
- hyprlock
- hypridle
- ...

See also, [my compatible nvim configuration](https://github.com/fdev31/kickstart.nvim/)

## Installing

The installer should be safe to run, and only copies files after backing them up.

run `install.sh`

To preview the changes without doing anything, run `install.sh --dry-run`

Works best using Gtk theme "adw".

## Usage

### Hyprland

- `Ctrl+w` to open a web browser
- `Ctrl+Enter` to open a shell
- `Ctrl+t` to open a file browser scratchpad
- `Ctrl+a` to open a shell scratchpad
- `Ctrl+v` to open a volume scratchpad

Change the wallpaper and update every colors (vim, kitty, hyprland, ...) using `Mod+Shift+,` - check [wallpapers.toml](https://github.com/fdev31/dotfiles/blob/main/home/.config/hypr/pyprland.d/wallpapers.toml) for the configuration.

For the complete list, refer to [keybindings.conf](https://github.com/fdev31/dotfiles/blob/main/home/.config/hypr/sources/keybindings.conf)

### Zsh

- End a command with '**' to complete every file below the path under cursor
- View anything directly in the shell with the `v` command

## Special thanks to

- [Axenide/Ax-shell](https://github.com/Axenide/Ax-Shell) for the matugen support and making me appreciate rounded corners
