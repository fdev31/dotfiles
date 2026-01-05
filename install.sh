#!/bin/bash

# chdir into this scripts' directory
REQUIRED_APPS=(
    "Hyprland"
    "ashell"
    "fabric-cli"
    "fastfetch"
    "git"
    "hypridle"
    "hyprlock"
    "hyprpaper"
    "kitty"
    "matugen"
    "nemo"
    "pamixer"
    "pavucontrol"
    "pypr"
    "rofi"
    "starship"
    "uwsm"
    "wl-copy"
    # "nwg-look"
    # "playerctl"
    # "brightnessctl"
)
for package in "${REQUIRED_APPS[@]}"; do
    if ! command -v "$package" &>/dev/null; then
        echo "Error: Required command '$package' is not installed."
        exit 1
    fi
done

# --- Configuration ---
pushd $(dirname $0)
DOTFILES_DIR="$(pwd)"
popd
DOTFILES_DIR="$DOTFILES_DIR/home"
BACKUP_DIR="$HOME/dotfiles_$(date +%Y%m%d_%H%M%S).bkp"
DRY_RUN=false

# Parse command line arguments
if [[ "$1" == "--dry-run" ]] || [[ "$1" == "-n" ]]; then
    DRY_RUN=true
fi

cd ~/.config

# --- Functions ---

# Function to print messages
msg() {
    echo -e "[INFO] $1"
}

# Function to execute command or print in dry run mode
execute() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] $1"
    else
        eval "$1"
    fi
}

# --- Main Script ---

if [ "$DRY_RUN" = true ]; then
    msg "Running in DRY RUN mode - no changes will be made"
fi

msg "Starting dotfiles installation."
msg "Your existing files will be backed up to: $BACKUP_DIR"

# Create backup directory
execute "mkdir -p \"$BACKUP_DIR\""
msg "Backup directory created."

# Find all files in the dotfiles home directory
while IFS= read -r -d '' source_file; do
    # Calculate relative path from DOTFILES_DIR
    rel_path="${source_file#$DOTFILES_DIR/}"
    dest_file="$HOME/$rel_path"

    # Backup existing file if it exists
    if [ -e "$dest_file" ] || [ -L "$dest_file" ]; then
        backup_file="$BACKUP_DIR/$rel_path"
        msg "Backing up $rel_path"
        execute "mkdir -p \"$(dirname "$backup_file")\""
        execute "cp -P \"$dest_file\" \"$backup_file\""
    fi

    # Install new file
    msg "Installing $rel_path"
    execute "mkdir -p \"$(dirname "$dest_file")\""
    execute "cp -frP \"$source_file\" \"$dest_file\""
done < <(find "$DOTFILES_DIR" -type f -print0)

echo "DOTFILES_DIR=$DOTFILES_DIR"

# Enable every service in .local/share/systemd/user
mkdir -p ~/.local/share/systemd/user/
for service_file in "$DOTFILES_DIR/.local/share/systemd/user/"*.service; do
    cp ${service_file} ~/.local/share/systemd/user/
    service_name=$(basename "$service_file")
    msg "Enabling systemd user service: $service_name"
    execute "systemctl --user enable \"$service_name\""
done

# replace the keyboard layout with the user one
echo -n "Keyboard layouts to use (eg: fr,es,us)"
read -r KEYBOARD_LAYOUTS
sed -i "s/fr,us/$KEYBOARD_LAYOUTS/g" ~/.config/hypr/sources/input.conf

msg "Installation complete!"
msg "To undo, you can restore your files from $BACKUP_DIR"

cd ~/.config
