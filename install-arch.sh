#!/usr/bin/env bash

set -Eeuo pipefail

DOTFILES="$HOME/dotfile"
BACKUP="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
AUR_PACKAGES="$DOTFILES/arch-aur-packages.txt"
ARCH_PACKAGES="$DOTFILES/arch-packages.txt"
ARCH_FONTS="$DOTFILES/arch-fonts.txt"

# --------------------------------------------------
# Error handling
# --------------------------------------------------

trap 'echo "❌ Setup failed at line $LINENO. Command: $BASH_COMMAND"' ERR

# --------------------------------------------------
# Helpers
# --------------------------------------------------

info() {
  printf '\n\033[1;34m==> %s\033[0m\n' "$1"
}

success() {
  printf '\033[1;32m✓ %s\033[0m\n' "$1"
}

warning() {
  printf '\033[1;33m⚠ %s\033[0m\n' "$1"
}

error() {
  printf '\033[1;31m✗ %s\033[0m\n' "$1"
}

# --------------------------------------------------
# Validate / Clone Dotfiles
# --------------------------------------------------

if [[ ! -d "$DOTFILES" ]]; then
  info "Dotfiles directory not found. Cloning repository..."

  git clone https://github.com/myselfanandvp/dotfile.git"$DOTFILES"
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

  success "Dotfiles cloned successfully"
else
  info "Dotfiles directory already exists"
fi

# --------------------------------------------------
# Authenticate sudo upfront
# --------------------------------------------------

info "Requesting administrator privileges..."

sudo -v

# Keep sudo alive
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# --------------------------------------------------
# Pacman Configuaration
# --------------------------------------------------

info "Installing pacman configuration"

sudo install -Dm644 \
  "$DOTFILES/pacman.conf" \
  /etc/pacman.conf

success "Pacman configuration success"

# --------------------------------------------------
# Progress bar
# --------------------------------------------------

TOTAL_STEPS=11
CURRENT_STEP=0

progress() {
  CURRENT_STEP=$((CURRENT_STEP + 1))

  local percent=$((CURRENT_STEP * 100 / TOTAL_STEPS))
  local filled=$((percent / 2))
  local empty=$((50 - filled))

  printf "\r\033[1;36mProgress: ["
  printf "%${filled}s" | tr ' ' '#'
  printf "%${empty}s" | tr ' ' '-'
  printf "] %3d%%\033[0m" "$percent"

  if [[ "$CURRENT_STEP" -eq "$TOTAL_STEPS" ]]; then
    echo
  fi
}

# --------------------------------------------------
# Validate environment
# --------------------------------------------------

if [[ ! -d "$DOTFILES" ]]; then
  error "Dotfiles directory not found: $DOTFILES"
  exit 1
fi

if [[ ! -f "$AUR_PACKAGES" ]]; then
  error "Missing $AUR_PACKAGES"
  exit 1
fi

if [[ ! -f "$ARCH_PACKAGES" ]]; then
  error "Missing $ARCH_PACKAGES"
  exit 1
fi

if [[ ! -f "$ARCH_FONTS" ]]; then
  error "Missing $ARCH_FONTS"
  exit 1
fi

# --------------------------------------------------
# Update system
# --------------------------------------------------

info "Updating Arch Linux"

sudo pacman -Syu --noconfirm

success "System updated"

progress

# --------------------------------------------------
# Install official packages
# --------------------------------------------------

info "Installing packages"

mapfile -t PACKAGES <"$ARCH_PACKAGES"

TOTAL_STATUS=${#PACKAGES[@]}
CURRENT_STATUS=0

application_progress() {
  CURRENT_STATUS=$((CURRENT_STATUS + 1))

  local percent=$((CURRENT_STATUS * 100 / TOTAL_STATUS))
  local filled=$((percent / 2))
  local empty=$((50 - filled))

  printf "\r\033[1;36mProgress: ["
  printf "%${filled}s" | tr ' ' '#'
  printf "%${empty}s" | tr ' ' '-'
  printf "] %3d%%\033[0m" "$percent"

  if [[ "$CURRENT_STATUS" -eq "$TOTAL_STATUS" ]]; then
    echo
  fi
}

for package in "${PACKAGES[@]}"; do
  [[ -z "$package" || "$package" == \#* ]] && continue

  if pacman -Q "$package" &>/dev/null; then
    application_progress
  else
    printf "\n"

    if sudo pacman -S --needed --noconfirm "$package"; then
      application_progress
    else
      error "Failed to install package: $package"
      exit 1
    fi
  fi
done

success "Packages installed"

progress

# --------------------------------------------------
# Install AUR helper
# --------------------------------------------------

info "Checking for yay"

if command -v yay &>/dev/null; then
  success "yay is already installed"
else
  info "Installing yay"

  TEMP_DIR="$(mktemp -d)"

  if git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"; then
    (
      cd "$TEMP_DIR/yay" || exit 1
      makepkg -si --noconfirm
    )
  else
    error "Failed to clone yay from AUR"
    rm -rf "$TEMP_DIR"
    exit 1
  fi

  rm -rf "$TEMP_DIR"

  if command -v yay &>/dev/null; then
    success "yay installed"
  else
    error "yay installation failed"
    exit 1
  fi
fi

# --------------------------------------------------
# AUR packages
# --------------------------------------------------

if [[ -f "$AUR_PACKAGES" ]]; then
  info "Installing AUR packages"

  mapfile -t AUR_LIST <"$AUR_PACKAGES"

  for package in "${AUR_LIST[@]}"; do
    [[ -z "$package" || "$package" == \#* ]] && continue

    if pacman -Q "$package" &>/dev/null; then
      success "$package already installed"
    else
      yay -S --needed --noconfirm "$package"
    fi
  done

  success "AUR packages installed"
fi

# --------------------------------------------------
# Flatpak
# --------------------------------------------------

info "Setting up Flatpak"

sudo pacman -S --needed --noconfirm flatpak

sudo flatpak remote-add \
  --if-not-exists \
  flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo

success "Flathub configured"

info "Installing Flatpak applications"

FLATPAK_APPS=(
  "app.zen_browser.zen"
)

for app in "${FLATPAK_APPS[@]}"; do
  if flatpak info "$app" &>/dev/null; then
    success "$app already installed"
  else
    flatpak install -y flathub "$app"
  fi
done

success "Flatpak applications installed"

progress

# --------------------------------------------------
# Hyprpm
# --------------------------------------------------

info "Setting up Hyprpm"

if command -v hyprpm &>/dev/null; then
  success "hyprpm is installed"
else
  sudo pacman -S --needed --noconfirm hyprpm
  success "hyprpm installed"
fi

if command -v hyprpm &>/dev/null; then
  info "Updating Hyprpm plugins"

  # Add the official Hyprland plugins repository only if it doesn't exist
  if hyprpm list 2>/dev/null | grep -q "hyprland-plugins"; then
    info "Hyprland plugins repository already added"
  else
    info "Adding Hyprland plugins repository"
    hyprpm add https://github.com/hyprwm/hyprland-plugins
  fi

  # Update existing plugins and reload them
  hyprpm update
  hyprpm reload

  success "Hyprpm plugins updated and reloaded"
fi

progress

# --------------------------------------------------
# Fonts
# --------------------------------------------------

info "Installing fonts"

mapfile -t FONTS <"$ARCH_FONTS"

for font in "${FONTS[@]}"; do
  [[ -z "$font" || "$font" == \#* ]] && continue

  if pacman -Q "$font" &>/dev/null; then
    success "$font already installed"
  else
    sudo pacman -S --needed --noconfirm "$font"
  fi
done

success "Fonts installed"

# GTK font
gsettings set org.gnome.desktop.interface font-name "JetBrains Mono 12"

# Qt font
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 12"

progress

# --------------------------------------------------
# Create directories
# --------------------------------------------------

DIRECTORIES=(
  Pictures/Wallpapers
  Videos
  Music
  Documents
  Others
  Projects
)

info "Creating directories"

for directory in "${DIRECTORIES[@]}"; do
  mkdir -p "$HOME/$directory"
done

success "Directories created"

# --------------------------------------------------
# Backup existing configuration
# --------------------------------------------------

info "Backing up existing configuration"

BACKUP_CREATED=false

backup_if_exists() {
  local source="$1"
  local destination="$2"

  if [[ -e "$source" ]]; then
    mkdir -p "$BACKUP"

    mv "$source" "$BACKUP/$destination"

    BACKUP_CREATED=true

    success "Backed up: $source"
  fi
}

backup_if_exists "$HOME/.config/fish" "fish"
backup_if_exists "$HOME/.config/hypr" "hypr"
backup_if_exists "$HOME/.local/state/noctalia/setttings.toml" "noctalia_settings"
backup_if_exists "$HOME/.bashrc" "bashrc"
backup_if_exists "$HOME/.zshrc" "zshrc"
backup_if_exists "$HOME/.tmux.conf" "tmux.conf"

if [[ "$BACKUP_CREATED" == true ]]; then
  success "Backups stored in: $BACKUP"
else
  success "No existing configuration required backup"
fi

progress

# --------------------------------------------------
# Stow configuration
# --------------------------------------------------

info "Applying dotfiles"

cd "$DOTFILES"

stow config

success "Configuration linked"

progress

# --------------------------------------------------
# Yazi plugins
# --------------------------------------------------

info "Installing Yazi plugins"

YAZI_PLUGINS=(
  "yazi-rs/plugins:mount"
  "yazi-rs/plugins:zoom"
  "yazi-rs/plugins:full-border"
  "yazi-rs/plugins:toggle-pane"
  "yazi-rs/plugins:git"
  "uhs-robert/recycle-bin"
)

for package in "${YAZI_PLUGINS[@]}"; do
  if ya pkg add "$package"; then
    success "Yazi plugin processed: $package"
  else
    warning "Failed to process Yazi plugin: $package"
  fi
done

success "Yazi plugins processed"

progress

# --------------------------------------------------
# Keyd
# --------------------------------------------------

info "Installing keyd configuration"

sudo install -Dm644 \
  "$DOTFILES/keyd/default.conf" \
  /etc/keyd/default.conf

# --------------------------------------------------
# Local configuration
# --------------------------------------------------

info "Applying local configuration"

cd "$DOTFILES"

progress

# --------------------------------------------------
# Cursor themes
# --------------------------------------------------

info "Installing cursor themes"

if [[ -d "$DOTFILES/icons/.icons" ]]; then

  sudo install -d /usr/share/icons

  sudo cp -a \
    "$DOTFILES/icons/.icons/." \
    /usr/share/icons/

  success "Cursor themes installed"

else
  warning "Cursor theme directory not found"
fi

# --------------------------------------------------
# SDDM
# --------------------------------------------------

info "Installing SDDM themes"

if [[ -d "$DOTFILES/win11sddm" ]]; then

  sudo install -d /usr/share/sddm/themes
  sudo install -d /etc/sddm.conf.d

  sudo cp -a \
    "$DOTFILES/win11sddm" \
    /usr/share/sddm/themes/

  if [[ -f "$DOTFILES/theme.conf" ]]; then
    sudo cp -a \
      "$DOTFILES/theme.conf" \
      /etc/sddm.conf.d/
  fi

  success "SDDM theme installed"

else
  warning "SDDM theme directory not found"
fi

progress

# --------------------------------------------------
# Remove unwanted packages
# --------------------------------------------------

info "Removing unwanted packages"

UNWANTED_PACKAGES=(
  waybar
  swaybg
  wofi
  fuzzel
  dunst
  swaylock
  gnome-keyring
)

for package in "${UNWANTED_PACKAGES[@]}"; do

  if pacman -Q "$package" &>/dev/null; then
    info "Removing: $package"
    sudo pacman -Rns --noconfirm "$package"
  fi

done

success "Unwanted packages removed"

# --------------------------------------------------
# Fish shell
# --------------------------------------------------

info "Changing shell to fish"

FISH_PATH="/usr/bin/fish"

if [[ ! -x "$FISH_PATH" ]]; then
  error "Fish shell not found at $FISH_PATH"
  exit 1
fi

CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

if [[ "$CURRENT_SHELL" == "$FISH_PATH" ]]; then
  success "Fish is already the default shell"
else
  sudo usermod --shell "$FISH_PATH" "$USER"
  success "Default shell changed to fish"
fi

# --------------------------------------------------
# Firmware
# --------------------------------------------------

info "Updating firmware"

if command -v fwupdmgr &>/dev/null; then
  sudo fwupdmgr refresh --force
  sudo fwupdmgr update
else
  warning "fwupdmgr not installed; skipping firmware update"
fi

# --------------------------------------------------
# Plymouth & Btrfs / Snapper Configuration
# --------------------------------------------------

info "Configuring Plymouth and Snapshots"

if command -v plymouth-set-default-theme &>/dev/null; then
  # Check if the current theme is already 'spinner'
  CURRENT_PLYMOUTH_THEME="$(plymouth-set-default-theme)"
  if [[ "$CURRENT_PLYMOUTH_THEME" != "spinner" ]]; then
    sudo plymouth-set-default-theme spinner -R
    success "Plymouth theme set to spinner"
  else
    success "Plymouth theme is already spinner"
  fi
fi

# Helper function to check if a systemd service/timer is enabled
is_enabled() {
  systemctl is-enabled --quiet "$1" 2>/dev/null
}

# Snapper
if findmnt -n -o FSTYPE / | grep -qx "btrfs"; then

  if ! command -v snapper &>/dev/null; then
    info "Installing Snapper"
    sudo pacman -S --needed --noconfirm snapper
  fi

  if sudo snapper list-configs | awk 'NR > 1 {print $1}' | grep -qx "root"; then
    success "Snapper root configuration already exists"
  else
    info "Creating Snapper root configuration"
    sudo snapper -c root create-config /
    if sudo snapper -c root list >/dev/null 2>&1; then
      success "Snapper root configuration created"
    else
      error "Snapper root configuration failed"
      exit 1
    fi
  fi

  sudo systemctl enable --now snapper-timeline.timer
  sudo systemctl enable --now snapper-cleanup.timer

  success "Snapper timers enabled"

else
  warning "Root filesystem is not Btrfs; skipping Snapper"
fi

if is_enabled docker.service; then
  success "docker service is already enabled"
else
  sudo systemctl enable --now docker.service
  success "docker service enabled and started"
fi

if is_enabled keyd; then
  success "keyd service is already enabled"
else
  sudo systemctl enable --now keyd
  success "keyd service enabled and started"
fi

progress

# --------------------------------------------------
# Complete
# --------------------------------------------------

echo

printf '\033[1;32m╭────────────────────────────────────────╮\033[0m\n'
printf '\033[1;32m│      Setup completed successfully      │\033[0m\n'
printf '\033[1;32m│     System will reboot in 5 seconds    │\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────╯\033[0m\n'

sleep 5

sudo reboot
