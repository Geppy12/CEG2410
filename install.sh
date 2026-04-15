#!/bin/bash

echo "Installing bash aliases..."

# Backup existing aliases
if [ -f ~/.bash_aliases ]; then
    echo "Backing up existing ~/.bash_aliases"
    mv ~/.bash_aliases ~/.bash_aliases_backup
fi

# Create symbolic link
ln -s ~/dotfiles/homefiles/.bash_aliases ~/.bash_aliases

echo "Aliases installed."

# Ensure bashrc loads aliases
if ! grep -q ".bash_aliases" ~/.bashrc; then
    echo "Adding source line to ~/.bashrc"
    echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
    echo "    . ~/.bash_aliases" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi

echo "Please reload your shell:"
echo "Run: source ~/.bashrc"
