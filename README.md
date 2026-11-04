# Dotfiles

My personal **Fedora + Arch / Wayland** setup, built around a clean, minimal, and keyboard-driven workflow.

**Niri · Noctalia · Neovim · Fish · Ghostty · Yazi**

> ⚠️ **These are personal dotfiles.** The install scripts make system-level changes (packages, shell, display manager, GRUB/Plymouth theme). Read a script before piping it into `bash`.

---

## ✨ Highlights

- 🪟 **Niri** — main compositor (Hyprland, Sway & Mango configs also included)
- 🎨 **Noctalia** — desktop shell & theming
- 💻 **Kitty · Ghostty · Alacritty** — terminal emulators
- 🐚 **Fish · Zsh · Bash** — shells (Fish set as default)
- 📝 **Neovim · Helix** — editors
- 📁 **Yazi** — terminal file manager, with plugins
- ⌨️ **keyd · kanata** — keyboard remapping
- 🔊 **EasyEffects** — audio
- 🖥️ Custom **Windows 11-inspired SDDM** theme
- 🥾 Custom **GRUB / Plymouth** theme

## 📦 Supported Systems

| OS                                     | Script            | Notes                                             |
| --------------------------------------- | ----------------- | -------------------------------------------------- |
| Fedora Workstation (GNOME)              | `install.sh`       | Removes GNOME extras (`gnome-keyring`, etc.) and switches to the Niri/SDDM setup |
| Fedora Minimal / Server / Everything netinstall | `install.sh` | Installs everything from scratch — just make sure `git`, `curl` and `sudo` are available first |
| Arch Linux (fresh install)              | `install-arch.sh`  | Installs `yay`, official + AUR packages           |

Both scripts are **idempotent** — safe to re-run, they skip anything already installed.

---

## 🚀 Installation

### Fedora — Quick Install (GNOME spin or minimal/netinstall)

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/myselfanandvp/Dotfiles/main/install.sh)"
```

> On a **minimal/netinstall** Fedora, make sure the basics are present first:
> ```bash
> sudo dnf install -y git curl
> ```
> then run the command above.

### Fedora — Manual Install

```bash
git clone https://github.com/myselfanandvp/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
./install.sh
```

### Arch Linux — Quick Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/myselfanandvp/Dotfiles/main/install-arch.sh)"
```

### Arch Linux — Manual Install

```bash
git clone https://github.com/myselfanandvp/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
./install-arch.sh
```

Both installers will:

1. Clone the repo to `~/Dotfiles` (if not already present)
2. Update the system and install all packages from `packages.txt` / `arch-packages.txt` + `arch-aur-packages.txt`
3. Install fonts (`fonts.txt` / `arch-fonts.txt`)
4. Set up Flatpak + Flathub and install Flatpak apps
5. Back up any existing configs (fish, niri, hypr, `.bashrc`, `.zshrc`, `.tmux.conf`, etc.) to `~/dotfiles-backup-<timestamp>`
6. Symlink configs into place with **GNU Stow** (`stow config`, `stow local`)
7. Set up `keyd` keyboard remapping, Yazi plugins, cursor themes, and the SDDM/GRUB themes
8. Remove conflicting packages (waybar, wofi, dunst, swaylock, etc.)
9. Change your default shell to **Fish**
10. Reboot

---

## 📂 Structure

```text
Dotfiles/
├── config/                  # Stowed app configs (~/.config)
│   └── .config/
│       ├── niri/            # Compositor
│       ├── hypr/            # Alternate compositor
│       ├── sway/            # Alternate compositor
│       ├── mango/           # Alternate compositor
│       ├── fish/            # Shell
│       ├── kitty/ ghostty/ alacritty/
│       ├── nvim/ helix/
│       ├── yazi/
│       ├── kanata/
│       └── systemd/user/
├── local/                   # Stowed local state (~/.local)
├── var/                     # Stowed app data (~/.var), e.g. EasyEffects
├── keyd/                    # Keyboard remap daemon config
├── icons/                   # Cursor themes
├── win11sddm/                # Windows 11-inspired SDDM login theme
├── grub2-themes/             # GRUB/Plymouth boot theme
├── packages.txt               # Fedora packages
├── fonts.txt                  # Fedora fonts
├── arch-packages.txt          # Arch official packages
├── arch-aur-packages.txt      # Arch AUR packages
├── arch-fonts.txt             # Arch fonts
├── install.sh                 # Fedora installer
└── install-arch.sh            # Arch installer
```

## 🧩 Main Components

| Component     | Choice                           |
| ------------- | --------------------------------- |
| Compositor    | Niri (Hyprland / Sway / Mango configs available) |
| Desktop Shell | Noctalia                          |
| Display Manager | SDDM (custom Windows 11 theme) |
| Terminal      | Kitty / Ghostty / Alacritty       |
| Shell         | Fish                              |
| Editor        | Neovim / Helix                    |
| File Manager  | Yazi                              |
| Prompt        | Starship                          |
| Keyboard      | keyd / kanata                     |
| Audio         | EasyEffects                       |
| Boot theme    | Plymouth + GRUB (custom)          |

---

## ⚠️ Notes

These are **personal dotfiles**, so some things are hardware-specific. After installing, you'll likely want to adjust:

- Monitor configuration (`niri`/`hypr` outputs)
- Keyboard mappings (`keyd`/`kanata`)
- Audio settings (EasyEffects)
- Keybindings

Existing configs the installer touches are backed up automatically to `~/dotfiles-backup-<timestamp>` before anything is overwritten — nothing is deleted outright.

Take what you need and make it your own.

---

**Fedora · Arch · Wayland · Niri · Noctalia**
