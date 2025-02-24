#!/bin/bash

# Create main dotfiles directory
if [ -d "$HOME/mydotfiles" ]; then
    echo "Directory mydotfiles already exists"
else
    mkdir -p "$HOME/mydotfiles"
    echo "Created mydotfiles directory"
fi

# Array of directories to check and create if needed
directories=("tmux" "wezterm" "zsh" "git" "nvim" "oh-my-zsh")

# Create subdirectories for different configurations
for dir in "${directories[@]}"; do
    if [ -d "$HOME/mydotfiles/$dir" ]; then
        echo "Directory $dir already exists"
    else
        mkdir -p "$HOME/mydotfiles/$dir"
        echo "Created $dir directory"
    fi
done

# Copy directories with their content
cp -r "$HOME/.config/nvim/"* "$HOME/mydotfiles/nvim/"
cp -r "$HOME/.oh-my-zsh/"* "$HOME/mydotfiles/.oh-my-zsh/"

# Copy files to their respective directories
cp "$HOME/.tmux.conf" "$HOME/mydotfiles/tmux/"
cp "$HOME/.wezterm.lua" "$HOME/mydotfiles/wezterm/"
cp "$HOME/.zshrc" "$HOME/mydotfiles/zsh/"
cp "$HOME/.zsh_history" "$HOME/mydotfiles/zsh/"
cp "$HOME/.zshenv" "$HOME/mydotfiles/zsh/"
cp "$HOME/.p10k.zsh" "$HOME/mydotfiles/zsh/"
cp "$HOME/.gitconfig" "$HOME/mydotfiles/git/"
cp "$HOME/.fzf.zsh" "$HOME/mydotfiles/zsh/"

echo "Files and directories have been moved to $HOME/mydotfiles/"
echo "Please verify that all files were moved correctly."

# Git commands
cd "$HOME/mydotfiles"

# Check if git is already initialized
if [ -d ".git" ]; then
    echo "Skipping git init: Git repository already initialized"
else
    git init
    echo "Git repository initialized"
fi

# Check and set remote origin
if git remote | grep -q 'origin'; then
    echo "Remote origin already exists"
else
    git remote add origin git@github.com:wallydevgg/mydotfiles.git
    echo "Remote origin added"
fi

# Check if branch main exists and create it if it doesn't
if ! git rev-parse --verify main >/dev/null 2>&1; then
    echo "Creating and switching to main branch..."
    git checkout -b main
else
    echo "Switching to main branch..."
    git checkout main
fi


# Add all files
git add .
echo "Files staged for commit"

# Get current date and time
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

# Commit changes with automatic message
git commit -m "automatic push update $DATETIME"
echo "Changes committed with timestamp: $DATETIME"

# Push to main branch
echo "Pushing to remote repository..."
git push origin main

echo "Git operations completed"
