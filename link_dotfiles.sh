#!/bin/bash

# An array of dotfiles to link
declare -a dotfiles=("vimrc" "bashrc" "tmux.conf" "zshrc" "gitconfig")

# Loop through the dotfiles and create symbolic links in the home directory
for file in "${dotfiles[@]}"; do
    # Check if the actual dotfile exists in the ~/.config folder
    if [ -f ~/.config/$file ]; then
        # Check if a symbolic link or the file already exists in the home directory
        if [ -e ~/$file ] || [ -L ~/$file ]; then
            echo "~/$file already exists. Skipping..."
        else
            # Create a symbolic link
            ln -s ~/.config/$file ~/$file
            echo "Symbolic link created for $file"
        fi
    else
        echo "~/.config/$file does not exist. Skipping..."
    fi
done

