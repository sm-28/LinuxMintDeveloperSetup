#!/usr/bin/env bash

mkdir -p ~/workspace/projects
mkdir -p ~/workspace/experiments
mkdir -p ~/workspace/datasets
mkdir -p ~/workspace/scripts

echo "alias start_postgres='sudo systemctl start postgresql'" >> ~/.zshrc
echo "alias stop_postgres='sudo systemctl stop postgresql'" >> ~/.zshrc
echo "alias restart_postgres='sudo systemctl restart postgresql'" >> ~/.zshrc