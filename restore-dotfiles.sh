#!/bin/bash

echo "Starting dotfiles restoration process..."

# Verify we are in the right directory
if [ ! -d "$PWD/nvim" ] || [ ! -d "$PWD/oh-my-zsh" ]; then
    echo "Error: Please run this script from the mydotfiles directory"
    exit 1
fi

# Backup existing files if they exist
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup directory: $backup_dir"
mkdir -p "$backup_dir"

# Function to backup existing file/directory
backup_if_exists() {
    local path="$1"
    if [ -e "$path" ]; then
        echo "Backing up existing $path"
        mv "$path" "$backup_dir/"
    fi
}

# Backup existing files and directories
backup_if_exists "$HOME/.config/nvim"
backup_if_exists "$HOME/.oh-my-zsh"
backup_if_exists "$HOME/.tmux.conf"
backup_if_exists "$HOME/.wezterm.lua"
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.zsh_history"
backup_if_exists "$HOME/.zshenv"
backup_if_exists "$HOME/.p10k.zsh"
backup_if_exists "$HOME/.gitconfig"
backup_if_exists "$HOME/.fzf.zsh"

# Create necessary directories
mkdir -p "$HOME/.config"

# Restore directories
echo "Restoring nvim configuration..."
cp -r "$PWD/nvim" "$HOME/.config/"

echo "Restoring oh-my-zsh configuration..."
cp -r "$PWD/.oh-my-zsh" "$HOME/"

# Restore individual files
echo "Restoring individual configuration files..."
cp "$PWD/tmux/.tmux.conf" "$HOME/"
cp "$PWD/wezterm/.wezterm.lua" "$HOME/"
cp "$PWD/zsh/.zshrc" "$HOME/"
cp "$PWD/zsh/.zsh_history" "$HOME/"
cp "$PWD/zsh/.zshenv" "$HOME/"
cp "$PWD/zsh/.p10k.zsh" "$HOME/"
cp "$PWD/git/.gitconfig" "$HOME/"
cp "$PWD/zsh/.fzf.zsh" "$HOME/"

# Set proper permissions
chmod 644 "$HOME/.zshrc" "$HOME/.gitconfig"

echo "Restoration completed!"
echo "Your original files have been backed up to: $backup_dir"
echo "Please restart your terminal for changes to take effect."
