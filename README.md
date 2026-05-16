# Dotfiles

Quick setup for managing these dotfiles using [GNU Stow](https://www.gnu.org/software/stow/).

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
    sudo pacman -S stow

    # Debian/Ubuntu
    sudo apt install stow

    # macOS (Homebrew)
    brew install stow
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
    ```

5.  **Push changes to remote**
    When you make changes to your configurations, commit and push them to your remote repository:
    ```bash
    git add .
    git commit -m "update configs"
    git push
    ```
