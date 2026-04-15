# sys-installs

This folder contains scripts used to automate software installation on Ubuntu systems.

## install-awscli.sh

This script installs the AWS Command Line Interface (AWS CLI).

The script:
- Checks if the script is run as root
- Verifies the apt package manager exists
- Prompts the user before installing
- Checks if the aws command already exists to avoid conflicts
- Installs AWS CLI silently using apt
- Displays a command to test the installation

### Run the script

sudo ./install-awscli.sh

### Verify installation

aws --version

Prompt used:

"Create a bash script for Ubuntu that installs AWS CLI, checks for root privileges, verifies apt exists, checks if the aws command already exists, prompts the user before installing, installs silently, and prints a command to verify installation."
