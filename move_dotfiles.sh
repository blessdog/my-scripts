#!/bin/bash

# Change to home directory
cd ~

# List of files you don't want to symlink
declare -a exclude=(".DS_Store" ".Trash" ... ) # Add other files or directories to exclude

# Loop through dotfiles in the home directory
for file in .*; do
    # Check if the file is in the exclude list
    if [[ ! " ${exclude[@]} " =~ " ${file} " ]] && [ -f "$file" ]; then
        # Check if the file exists in ~/.config
        if [ -f ~/.config/$file ]; then
            # Check if a symlink or the file already exists in the home directory
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
    fi
done

