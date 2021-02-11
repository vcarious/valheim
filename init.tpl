#!/bin/bash
sudo useradd -m steam
cd /home/steam

sudo apt update && sudo apt upgrade -y
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install lib32gcc1 steamcmd -y

su steam
steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 +quit -y

./valheim/start_server.sh




