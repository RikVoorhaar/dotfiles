# Dotfiles

Quick setup for managing these dotfiles using [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

To ensure everything looks and works correctly, install the following:

### 1. Fonts (Required for Waybar Icons)
- **Font Awesome** (general icons)
- **Nerd Fonts** (system icons)

```bash
# Arch Linux
yay -S otf-font-awesome ttf-jetbrains-mono-nerd
```

### 2. Bluetooth Manager
To use the click-to-open feature for Bluetooth in Waybar:
```bash
# Arch Linux
yay -S blueman
sudo systemctl enable --now bluetooth.service
```

## Quick Setup

1.  **Clone the repository**
    ```bash
    git clone <repo_url> ~/.dotfiles
    cd ~/.dotfiles
    ```

2.  **Install Stow**
    Make sure `stow` is installed on your system.
    ```bash
    # Arch Linux
    yay -S stow
    ```

3.  **Backup existing configs**
    Before stowing, ensure you have a backup of any existing configuration files in your home directory or `~/.config` that might be overwritten.

4.  **Stow a package**
    Run `stow` followed by the directory name to symlink the configurations into your home directory.
    ```bash
    stow <package>
    ```
    *Example:*
    ```bash
    stow hypr
    stow waybar
    ```

5.  **Push changes to remote**
    When you make changes to your configurations, commit and push them to your remote repository:
    ```bash
    git add .
    git commit -m "update configs"
    git push
    ```
