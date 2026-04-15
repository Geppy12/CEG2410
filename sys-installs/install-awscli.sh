#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run with sudo or root."
  exit 1
fi

# Check if apt exists
if ! command -v apt >/dev/null 2>&1; then
  echo "apt package manager not found. This script requires apt."
  exit 1
fi

echo "This script will install the AWS Command Line Interface (awscli)."
read -p "Do you want to continue? (y/n): " answer

if [ "$answer" != "y" ]; then
  echo "Installation cancelled."
  exit 0
fi

# Check if aws command already exists
if command -v aws >/dev/null 2>&1; then
  echo "Error: a command named 'aws' already exists."
  echo "Stopping install to avoid a name conflict."
  exit 1
fi

# Install silently
apt update -y >/dev/null 2>&1
apt install -y awscli >/dev/null 2>&1

echo "Installation complete!"
echo "Run this command to test:"
echo "aws --version"
