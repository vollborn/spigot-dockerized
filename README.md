# Spigot Dockerized

This is spigot! In a docker container. Who would have thought?

<br />

## Prerequesites

There are some things you will need beforehand.

- root privileges
- Docker & Docker Compose
- a working internet connection

<br />

## Configuration

1. Copy the *.env.example* file to *.env* and edit its entries, if needed.
```shell
# Linux & Mac
cp .env.example .env

# Windows
copy .env.example .env
```

2. Select your desired minecraft version.
```
VERSION=1.17
```

3. Depending on your Minecraft version, you will need a different Java version.
```
JAVA_VERSION=16
```

| Minecraft Version | Java Version |
|-------------------|--------------|
| 1.17              | 16           |
| 1.12 - 1.16       | 11           |
| 1.8 - 1.11        | 8            |

4. Specify your maximal and minimal memory that can be used. Use **M** as unit for megabytes and **G** for gigabytes.
```
MEMORY_MAX=2048M
MEMORY_MIN=512M
```

5. Select your local folder where the server files should be stored.
```
SERVER_DIRECTORY=/opt/spigot-dockerized/server
```

6. If you want to rebuild and update your Spigot version on every restart, you need to set **BUILD_ON_START** to true and define a persistent build tools directory.
```
BUILD_ON_START=true
BUILD_TOOLS_DIRECTORY=/opt/spigot-dockerized/build-tools
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
