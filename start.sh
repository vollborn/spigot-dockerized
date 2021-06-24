#!/bin/bash


# set to static values to start without parameters

version="1.17"
ramMax=3072M
ramMin=512M
storage=/opt/minecraft-servers


# parameter check

if [ -z ${version} ] || [ -z ${ramMax} ] || [ -z ${ramMin} ]; then
	echo "Please specify a minecraft version."
	echo " -> ./start.sh {version}"
	exit
fi


# root check

if [ "${EUID}" -ne 0 ]; then
	echo "Please run the start script as root."
	exit
fi


# start docker

docker run \
	-it \
	-v ${storage}:/opt/servers \
	-p 25565:25565 \
	--env VERSION=${version} \
	--env RAM_MAX=${ramMax} \
	--env RAM_MIN=${ramMin} \
	spigot-dockerized:latest
