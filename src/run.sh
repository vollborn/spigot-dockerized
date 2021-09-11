#!/usr/bin/env bash

if [ "${EULA}" != "true" ]; then
	echo "Please accept the eula first."
	exit
fi

serverJar="spigot-${VERSION}.jar"
serverPath="/opt/minecraft-server"
serverJarPath="${serverPath}/${serverJar}"

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

	if [ -d work ]; then
		rm -r work
	fi

	if [ -f "${serverJarPath}" ]; then
		java -jar BuildTools.jar --rev ${VERSION} --compile-if-changed
	else
		java -jar BuildTools.jar --rev ${VERSION}
	fi
	echo ""


	# Move builded file

	if [ -f "./${serverJar}" ]; then
		mv "./${serverJar}" "${serverJarPath}"
	fi

	cd "${serverPath}"

else

	cd "${serverPath}"

	# Download server.jar

	if [ ! -f "./server.jar" ]; then
		echo "Downloading server.jar..."
		curl -o "${serverJar}"  https://cdn.getbukkit.org/spigot/spigot-${VERSION}.jar &> /dev/null

		if [ ! -f "./${serverJar}" ]; then
			echo "${serverJar} could not be downloaded. Aborting..."
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
java -jar -Xms${MEMORY_MIN} -Xmx${MEMORY_MAX} ${serverJar}


# Server stop

echo ""
echo ""
echo "Server stopped."
exit
