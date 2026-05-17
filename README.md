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

## Adding a New Config

Each application lives in its own top-level directory (called a *stow package*). The directory structure inside it must mirror your home directory exactly — stow will create symlinks that replicate the same layout under `~`.

**1. Create the package directory tree**

For apps that store their config under `~/.config/<app>/`:
```bash
mkdir -p ~/.dotfiles/<app>/.config/<app>
```

For apps that store their config directly in `~/` (e.g. `~/.zshrc`):
```bash
mkdir -p ~/.dotfiles/<app>
```

**2. Move the existing config into the repo**
```bash
# Example for an app that uses ~/.config/<app>/
mv ~/.config/<app>/ ~/.dotfiles/<app>/.config/<app>/
```

**3. Stow the new package**

From `~/.dotfiles`, run:
```bash
stow <app>
```
This creates a symlink at `~/.config/<app>` pointing back into the repo, so the app keeps working as before.

**4. Commit the new package**
```bash
git add <app>
git commit -m "add <app> config"
git push
```

> **Tip:** If stow reports a conflict, the original file or directory still exists at the target path. Remove or back it up first, then re-run `stow`.
