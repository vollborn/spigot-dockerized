#!/bin/bash

version=${1}


# Parameter check

if [ -z ${version} ]; then
	echo "Please specify a java version."
	echo ""
	echo " -> ./build.sh {version}"
	echo ""
	echo "All minecraft servers below 1.17 will run with Java 8."
	echo "1.17 and above will need Java 16."
	echo ""
	exit
fi


# Root check

if [ "${EUID}" -ne 0 ]; then
	echo "Please run the build task as root."
	exit
fi


# docker build 

docker build . --build-arg JAVA_VERSION=${version} -t spigot-dockerized
