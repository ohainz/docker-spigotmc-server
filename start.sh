#!/bin/sh

if [ ! -f /server/spigot-server.jar ]
then
    echo "Copy spigot-server.jar..."
    cp /start/spigot-server.jar /server/spigot-server.jar
    echo "spigot-server.jar copied"
fi

eulavalue='eula=false'
if $EULA 
then
    eulavalue='eula=true'
    if [ -f /server/eula.txt ] 
    then
        rm /server/eula.txt
    fi
fi

if [ ! -f /server/eula.txt ]
then
    echo "Create eula.txt - $eulavalue"
    echo "# Generated by docker build" | tee /server/eula.txt
    echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA)." | tee -a /server/eula.txt
    echo $eulavalue | tee -a /server/eula.txt
    echo "eula created"
fi

cd /server
echo "Start Mincraft Spigot Server - Memory $MEMORY"
startcommand="java -Xmx${MEMORY}M -Xms${MEMORY}M -jar spigot-server.jar"
echo $startcommand
bash -c "$startcommand"
