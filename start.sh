#!/bin/bash


envFile=spigot.env


# read env file

if [ -f ${envFile} ]; then
	export $(cat ${envFile} | sed 's/#.*//g' | xargs)
fi


# parameter check

if [ -z ${VERSION} ] \
    || [ -z ${MEMORY_MAX} ] \
    || [ -z ${MEMORY_MIN} ] \
	|| [ -z ${SERVER_DIRECTORY} ]
then
	echo "Your ${envFile} file seems to miss some values."
	echo "Please check the documentation!"
	exit
fi


# root check

if [ "${EUID}" -ne 0 ]; then
	echo "Please run the start script as root."
	exit
fi


# create server directory

if [ ! -d "${SERVER_DIRECTORY}" ]; then
	mkdir -p "${SERVER_DIRECTORY}"
fi


# start in detached mode

attachParam="-it"
if [[ "${1}" == "-d" ]]; then
	attachParam="-dt"
fi

# start docker

docker run \
	${attachParam} \
	-v ${SERVER_DIRECTORY}:/opt/server \
	-p 25565:25565 \
	--env-file ${envFile} \
	spigot-dockerized:latest
