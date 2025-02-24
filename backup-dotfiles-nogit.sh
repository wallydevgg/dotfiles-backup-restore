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