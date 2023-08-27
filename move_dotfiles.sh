#!/bin/bash

# List of dotfiles you want to move and symlink
declare -a dotfiles=(".bashrc" ".vimrc" ".gitconfig" ".zshrc" ... )  # Add other files as needed

# Loop through the dotfiles
for file in "${dotfiles[@]}"; do
    # Check if the file exists in the home directory
    if [ -f ~/$file ]; then
        # If the corresponding directory in ~/.config doesn't exist, create it
        target_dir=~/.config/${file:1}  # Remove the dot from the file name for the target directory
        mkdir -p $target_dir
        
        # Move the file to ~/.config
        mv ~/$file $target_dir/

        # Create a symbolic link back to the home directory
        ln -s $target_dir/$file ~/$file

        echo "$file moved and symlinked."
    else
        echo "$file doesn't exist in the home directory. Skipping..."
    fi
done

