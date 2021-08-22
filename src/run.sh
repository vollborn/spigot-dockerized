#!/bin/bash

if [ "${4}" != "true" ]; then
	echo "Please accept the eula first."
	exit
fi

serverPath="/opt/minecraft-server"

if [ ! -d "${serverPath}" ]; then
	echo "Please pass the ${serverPath} directory for persistent storage!"
	exit
fi

version=${1}
ramMin=${2}
ramMax=${3}

echo ""
echo "  ░██████╗██████╗░██╗░██████╗░░█████╗░████████╗"
echo "  ██╔════╝██╔══██╗██║██╔════╝░██╔══██╗╚══██╔══╝"
echo "  ╚█████╗░██████╔╝██║██║░░██╗░██║░░██║░░░██║░░░"
echo "  ░╚═══██╗██╔═══╝░██║██║░░╚██╗██║░░██║░░░██║░░░"
echo "  ██████╔╝██║░░░░░██║╚██████╔╝╚█████╔╝░░░██║░░░"
echo "  ╚═════╝░╚═╝░░░░░╚═╝░╚═════╝░░╚════╝░░░░╚═╝░░░"
echo ""
echo "                    DOCKERIZED "
echo ""
echo ""
echo "Version      →   ${version}"
echo "Memory Min   →   ${ramMin}"
echo "Memory Max   →   ${ramMax}"
echo ""


cd ${serverPath}


# Download server.jar

if [ ! -f "./server.jar" ]; then
	echo "Downloading server.jar..."
	curl -o server.jar  https://cdn.getbukkit.org/spigot/spigot-${version}.jar &> /dev/null

	if [ ! -f "./server.jar" ]; then
		echo "Server.jar could not be downloaded. Aborting..."
		exit
	fi
fi


# Accept eula

if [ ! -f "./eula.txt" ]; then
	echo "Accepting eula..."
	echo "eula=true" > eula.txt
fi


# Start server

echo "Starting server..."
echo ""
java -jar -Xms${ramMin} -Xmx${ramMax} server.jar


# Server stop

echo ""
echo ""
echo "Server stopped."
exit
