#!/bin/bash

# valheim server config
# $server_name
# $world_name
# $password

source ./server.config


sudo apt-get update -y
sudo apt-get upgrade -y
sudo dpkg --add-architecture i386
sudo apt-get update -y
#TODO: automate steamcmd install headless
sudo apt-get install -y lib32gcc1 steamcmd

steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 +quit -y

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
cd /home/steam/valheim/
echo "starting server PRESS CTRL-C to exit"
#TODO: bind pw
./valheim_server.x86_64 -name $server_name -port 2456 -world $world_name -password $password
export LD_LIBRARY_PATH=$templdpath
