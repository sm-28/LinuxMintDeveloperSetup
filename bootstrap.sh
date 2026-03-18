#!/usr/bin/env bash

echo "Starting Linux Developer machine setup..."

INSTALL_DIR="$HOME/.linux_mint_developer_setup"

if [ ! -d "$INSTALL_DIR" ]; then
    git clone https://github.com/sm-28/LinuxMintDeveloperSetup.git "$INSTALL_DIR"
else
    echo "Updating existing setup..."
    cd "$INSTALL_DIR"
    git pull
fi

cd "$INSTALL_DIR"

chmod +x setup.sh

./setup.sh "$@"