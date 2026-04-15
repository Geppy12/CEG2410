# Bash Environment Customization (Dotfiles)

This folder contains bash configuration files used to customize a user's shell environment.  
The goal is to store shell customizations inside a dotfiles repository so they can be reused, version controlled, and easily deployed on new systems.

## Files

### .bash_aliases
This file contains useful bash aliases that improve productivity and safety when working in the Linux terminal.

Examples included:

- `ll` → long directory listing
- `la` → show hidden files
- `l` → compact directory listing
- `..` → move up one directory
- `update` → update and upgrade system packages

These aliases help speed up common commands and reduce typing.

### install.sh
This script installs the bash customizations.

The script performs the following tasks:

1. Backs up any existing `.bash_aliases` file
2. Creates a **symbolic link** from the repository version to the user's home directory
3. Ensures `.bashrc` loads the aliases file
4. Prompts the user to reload their environment

Using symbolic links allows updates in the repository to automatically apply to the user's environment.

## Installation

Navigate to the `homefiles` folder and run:

```bash
bash install.sh