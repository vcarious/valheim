sudo apt-get update -y
sudo apt-get upgrade -y
sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt-get install lib32gcc1 steamcmd -y

steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 +quit -y

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
cd /home/steam/valheim/
echo "starting server PRESS CTRL-C to exit"
./valheim_server.x86_64 -name "BucBucGo" -port 2456 -world "bbg1" -password "thecan123"
export LD_LIBRARY_PATH=$templdpath
