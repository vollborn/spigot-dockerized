#!/bin/bash


envFile=spigot.env


# read env file

if [ -f ${envFile} ]; then
	export $(cat ${envFile} | sed 's/#.*//g' | xargs)
fi


# Parameter check

if [ -z ${JAVA_VERSION} ]; then
	echo "Please specify a java version in your ${envFile} file."
	echo "All versions except 1.17 will run on Java 8. 1.17 requires Java 16."
	echo ""
	echo "Example entry: JAVA_VERSION=16"
	exit
fi


# Root check

if [ "${EUID}" -ne 0 ]; then
	echo "Please run the build task as root."
	exit
fi


# docker build 

docker build . --build-arg JAVA_VERSION=${JAVA_VERSION} -t spigot-dockerized
