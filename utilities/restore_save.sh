#!/bin/bash
# assuming save files (*.fwl and *.db) have been copied to 
# ubuntu home directory, create the world directory prior to 
# the full install and copy the saves there when server is started
# for the first time, it will notice the saves and not create a new world loading those instead

# TODO: optimize.  this is sloppy...
sudo su root
mkdir ~/.config/unity3d/unity3d/IronGate/Valheim/worlds

cp /home/ubuntu/bbg1.fwl /root/.config/unity3d/IronGate/Valheim/worlds/
cp /home/ubuntu/bbg1.db /root/.config/unity3d/IronGate/Valheim/worlds/

