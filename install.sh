#!/bin/bash
echo "Please install the adw gtk-theme and set it using nwg-look"
echo "Press ENTER to proceed with the installation."
echo "Every file will be backed up."
read
REQUIRED_APPS=(
    "Hyprland"
    "nwg-look"
    "ashell"
    "git"
    "hypridle"
    "hyprlock"
    "hyprpaper"
    "kitty"
    "nemo"
    "pamixer"
    "pavucontrol"
    "pypr"
    "rofi"
    "starship"
    "uwsm"
    "wl-copy"
    "adw-bluetooth"
)
for package in "${REQUIRED_APPS[@]}"; do
    if ! command -v "$package" &>/dev/null; then
        echo "Error: Required command '$package' is not installed."
        exit 1
    fi
done
pushd "$(dirname "$0")"
DOTFILES_DIR="$(pwd)"
popd
DOTFILES_DIR="$DOTFILES_DIR/home"
BACKUP_DIR="$HOME/dotfiles_$(date +%Y%m%d_%H%M%S).bkp"
RESTORE_SCRIPT="$BACKUP_DIR/restore.sh"
DELETE_LIST="$BACKUP_DIR/_added_files"
DRY_RUN=false
if [[ "$1" == "--dry-run" ]] || [[ "$1" == "-n" ]]; then
    DRY_RUN=true
fi
cd ~/.config
msg() {
    echo -e "[INFO] $1"
}
execute() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] $1"
    else
        eval "$1"
    fi
}
if [ "$DRY_RUN" = true ]; then
    msg "Running in DRY RUN mode - no changes will be made"
fi
msg "Starting dotfiles installation."
msg "Your existing files will be backed up to: $BACKUP_DIR"
execute "mkdir -p \"$BACKUP_DIR\""
msg "Backup directory created."
if [ "$DRY_RUN" = true ]; then
    msg "DRY RUN: restore script would be created at $RESTORE_SCRIPT"
else
    cat <<'EOF' >"$RESTORE_SCRIPT"
#!/bin/sh
set -e

BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"
DELETE_LIST="$BACKUP_DIR/_added_files"

if [ -f "$DELETE_LIST" ]; then
    while IFS= read -r rel_path; do
        [ -z "$rel_path" ] && continue
        target="$HOME/$rel_path"
        if [ -e "$target" ] || [ -L "$target" ]; then
            rm -rf "$target"
        fi
        current_dir="$(dirname "$target")"
        while [ "$current_dir" != "$HOME" ] && [ "$current_dir" != "/" ]; do
            rmdir "$current_dir" 2>/dev/null || break
            current_dir="$(dirname "$current_dir")"
        done
    done <"$DELETE_LIST"
fi

cd "$BACKUP_DIR"

for entry in .* *; do
    case "$entry" in
        .|..|_added_files|restore.sh) continue ;;
    esac
    cp -a "$entry" "$HOME/"
done
EOF
    chmod +x "$RESTORE_SCRIPT"
fi
while IFS= read -r -d '' source_file; do
    rel_path="${source_file#$DOTFILES_DIR/}"
    dest_file="$HOME/$rel_path"
    if [ -e "$dest_file" ] || [ -L "$dest_file" ]; then
        backup_file="$BACKUP_DIR/$rel_path"
        msg "Backing up $rel_path"
        execute "mkdir -p \"$(dirname "$backup_file")\""
        execute "cp -P \"$dest_file\" \"$backup_file\""
    else
        msg "Recording new file for removal: $rel_path"
        if [ "$DRY_RUN" = true ]; then
            echo "[DRY RUN] Would record $rel_path for removal"
        else
            printf '%s\n' "$rel_path" >>"$DELETE_LIST"
        fi
    fi
    msg "Installing $rel_path"
    execute "mkdir -p \"$(dirname "$dest_file")\""
    execute "cp -frP \"$source_file\" \"$dest_file\""
done < <(find "$DOTFILES_DIR" -type f -print0)
echo "DOTFILES_DIR=$DOTFILES_DIR"
mkdir -p ~/.local/share/systemd/user/
for service_file in "$DOTFILES_DIR/.local/share/systemd/user/"*.service; do
    cp "${service_file}" ~/.local/share/systemd/user/
    service_name=$(basename "$service_file")
    msg "Enabling systemd user service: $service_name"
    execute "systemctl --user enable \"$service_name\""
done
echo -n "Keyboard layouts to use (eg: fr,es,us)"
read -r KEYBOARD_LAYOUTS
sed -i "s/fr,us/$KEYBOARD_LAYOUTS/g" ~/.config/hypr/sources/input.conf
msg "Installation complete!"
msg "To undo, you can restore your files from $BACKUP_DIR"
cd ~/.config
