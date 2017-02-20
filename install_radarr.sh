#!/bin/bash
userid=$(id -u)
user="`whoami`"
host="`hostname -f`"
userid=$(id -u)
port=$((11000+(($userid - 1000) * 50)))
webui_port=$(($port+19))
echo "Downloading Radarr..."
wget https://github.com/Radarr/Radarr/releases/download/v0.2.0.99/Radarr.develop.0.2.0.99.linux.tar.gz &>/dev/null
tar zxf Radarr.develop.0.2.0.99.linux.tar.gz
echo "Download complete.Executing Radarr for first time."
screen -dmS Radarr mono Radarr/Radarr.exe
sleep 15 ; echo -en "\n\n" ;
PID=`ps -eaf | grep Radarr| grep -v grep | awk '{print $2}'`
if [[ "" !=  "$PID" ]]; then
  kill -9 $PID
fi
echo "Updating config file."
sed -i "s/7878/$webui_port/g" $HOME/.config/Radarr/config.xml
echo "Starting radarr in screen mode."
echo "Radar URL : http://$user.$host:$webui_port"
screen -dmS radarr mono Radarr/Radarr.exe
