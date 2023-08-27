#!/bin/bash

# Change to home directory
cd ~

# List of dotfiles you don't want to move or symlink
declare -a exclude=(
    ".DS_Store" ".Trash" ".CFUserTextEncoding" ".local" ".matplotlib" ".mongodb" 
    ".mysqlsh" ".node_repl_history" ".npm" ".npmrc" ".p10k-8color.zsh.zwc" 
    ".p10k.zsh.zwc" ".pgadmin" ".psql_history" ".python_history" ".quokka" 
    ".rest-client" ".vscode" ".vscode-cli" ".wallaby" ".yarnrc" ".zcompdump-icemac pro-5.8" ".zprofile.bak"
) # Add other dotfiles or directories to exclude

# Loop through dotfiles in the home directory
for file in .*; do
    # Check if the file is in the exclude list
    if [[ ! " ${exclude[@]} " =~ " ${file} " ]] && [ -f "$file" ]; then
        
        # Move the file to ~/.config if it's not already there
        if [ ! -f ~/.config/$file ]; then
            mv ~/$file ~/.config/
            echo "Moved $file to ~/.config/"
        fi

        # Check if a symlink or the file already exists in the home directory
        if [ -e ~/$file ] || [ -L ~/$file ]; then
            echo "~/$file already exists. Skipping..."
        else
            # Create a symbolic link
            ln -s ~/.config/$file ~/$file
            echo "Symbolic link created for $file"
        fi
    fi
done

