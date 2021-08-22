# Spigot Dockerized

This is spigot! In a docker container. Who would have thought?

<br />

## Prerequesites

There are some things you will need beforehand.

- root privileges
- Docker & Docker Compose
- a working internet connection

<br />

## Setup

First you need to copy the *.env.example* file to *.env* and edit its entries, if needed.
```shell
# Linux & Mac
cp .env.example .env

# Windows
copy .env.example .env
```

Select your desired minecraft version.
```
VERSION=1.17
```

Specify the java version you want to use.
<br />**Important**: Minecraft 1.17 will only work with Java 16. All other versions will run with Java 8.
```
JAVA_VERSION=16
```

Specify your maximal and minimal memory that can be used.
<br />Use **M** as unit for megabytes and **G** for gigabytes.
```
MEMORY_MAX=2048M
MEMORY_MIN=512M
```

Select your local folder where the server files should be stored.
```
SERVER_DIRECTORY=/opt/minecraft-server
```

<br />

## Build the docker

You need to build the docker locally before you can start the server.

```shell
sudo docker-compose build
```

<br />

## Start the server

```shell
sudo docker-compose up
```

... or in detached mode
```shell
sudo docker-compose up -d
```
