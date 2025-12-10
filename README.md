# fab's desktop environment

Now using Hyprland, I'm a former (or very occasional) user of:

- qtile
- awesome
- gnome/kde
- cinnamon/mate
- enlightenment (e16/e17)
- xfce
- ROX desktop
- pekwm/openbox/fluxbox/windowmaker/fvwm
- ratpoison and other fun stuff for some moments ;)

I built my requirements over time as a software engineer,
trying to maintain some usable modern desktop environment configuration based on the best light (not lightest!) options I can find for my own usage.

This is an "export" of the main files I'm using, with some small automated adaptations to make them more generic.

Report any bug so I can improve those and share it again.

![image](https://raw.githubusercontent.com/fdev31/dotfiles/refs/heads/main/screenshots/1.png)

Currently using:

- Hyprland (looking at Niri - good but less flexible)
- [ashell](https://github.com/MalpenZibo/ashell/) (the smallest footprint for the features)
- [pyprland](https://github.com/fdev31/pyprland) (the glue, helps with configuration and adds fine UX features)
- zsh (replacing it seems futile)
- kitty (the best terminal emulator so far)
- matugen
- hyprpaper (bug-free when it comes to screen transformation - unlike swww and even swaybg)
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

- `Mod+Shift+q` to stop Hyprland
- `Ctrl+Mod+L` to shutdown, shutdown or reboot
- `Ctrl+L` to lock the session
- `Mod+w` to open a web browser
- `Mod+Enter` to open a shell
- `Mod+t` to open a file browser scratchpad
- `Mod+a` to open a shell scratchpad
- `Mod+v` to open a volume scratchpad
- `Mod+c` to close a window
- `Mod+e` to start or focus some program
- `Mod+r` to run commands from the [custom menu](https://github.com/fdev31/dotfiles/blob/main/home/.config/hypr/pyprland.d/shortcuts.toml)
- `Mod+Arrows` with optional modifiers to operate on the focused window
- `Mod+k` and `Mod+j` with common modifiers to manipulate workspaces (carrying focused window with `SHIFT`)
- `Mod+Shift+,` change the wallpaper and update every colors (vim, kitty, hyprland, ...).
    Check [wallpapers.toml](https://github.com/fdev31/dotfiles/blob/main/home/.config/hypr/pyprland.d/wallpapers.toml) for the configuration.

For the complete list, refer to [keybindings.conf](https://github.com/fdev31/dotfiles/blob/main/home/.config/hypr/sources/keybindings.conf)

Using AZERTY layout, you may want to change the `q a m , w z` keys bindings and some others to make it more comfortable.

### Zsh

- End a command with '**' to complete every file below the path under cursor
- View anything directly in the shell with the `v` command

## Notes

You can force a specific color for the theme using a command such as `matugen color hex '#AA5533' ` (replace with the RGB code of your choice) or `matugen image /path/to/an/image`

## Special thanks to

- [Axenide/Ax-shell](https://github.com/Axenide/Ax-Shell) for the matugen support and making me appreciate rounded corners
