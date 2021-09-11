#!/usr/bin/env bash

if [ "${EULA}" != "true" ]; then
	echo "Please accept the eula first."
	exit
fi

serverPath="/opt/minecraft-server"
buildToolsPath="/opt/build-tools"
buildToolsJarPath="${buildToolsPath}/BuildTools.jar"

if [ ! -d "${serverPath}" ]; then
	echo "Please pass the ${serverPath} directory for persistent storage!"
	exit
fi

echo ""
echo "  ░██████╗██████╗░██╗░██████╗░░█████╗░████████╗"
echo "  ██╔════╝██╔══██╗██║██╔════╝░██╔══██╗╚══██╔══╝"
echo "  ╚█████╗░██████╔╝██║██║░░██╗░██║░░██║░░░██║░░░"
echo "  ░╚═══██╗██╔═══╝░██║██║░░╚██╗██║░░██║░░░██║░░░"
echo "  ██████╔╝██║░░░░░██║╚██████╔╝╚█████╔╝░░░██║░░░"
echo "  ╚═════╝░╚═╝░░░░░╚═╝░╚═════╝░░╚════╝░░░░╚═╝░░░"
echo ""
echo "                   DOCKERIZED "
echo ""
echo ""
echo "Version      →   ${VERSION}"
echo "Memory Min   →   ${MEMORY_MIN}"
echo "Memory Max   →   ${MEMORY_MAX}"
echo ""


if [ "${BUILD_ON_START}" == "true" ]; then

	# Download BuildTools

	if [ ! -d "${buildToolsPath}" ]; then
		mkdir "${buildToolsPath}"
	fi

	if [ ! -f "${buildToolsJarPath}" ]; then
		echo "Downloading BuildTools..."
		curl -o "${buildToolsJarPath}" https://hub.spigotmc.org/jenkins/job/BuildTools/lastStableBuild/artifact/target/BuildTools.jar &> /dev/null
	fi

	if [ ! -f "${buildToolsJarPath}" ]; then
		echo "Downloading BuildTools failed."
		echo "Exiting..."
		exit
	fi


	# Build spigot.jar

	cd "${buildToolsPath}"

	echo "Building..."
	echo "This may take a while."
	echo ""
	if [ -f "${serverPath}/server.jar" ]; then
		java -jar BuildTools.jar --rev ${VERSION} --compile-if-changed
	else
		java -jar BuildTools.jar --rev ${VERSION}
	fi
	echo ""


	# Move builded file

	if [ -f "./spigot-${VERSION}.jar" ]; then
		mv "./spigot-${VERSION}.jar" "${serverPath}/server.jar"
	fi

	cd "${serverPath}"

else

	cd "${serverPath}"

	# Download server.jar

	if [ ! -f "./server.jar" ]; then
		echo "Downloading server.jar..."
		curl -o server.jar  https://cdn.getbukkit.org/spigot/spigot-${VERSION}.jar &> /dev/null

		if [ ! -f "./server.jar" ]; then
			echo "Server.jar could not be downloaded. Aborting..."
			exit
		fi
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
java -jar -Xms${MEMORY_MIN} -Xmx${MEMORY_MAX} server.jar


# Server stop

echo ""
echo ""
echo "Server stopped."
exit
