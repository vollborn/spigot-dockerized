# Spigot Dockerized

This is spigot! In a docker container. Who would have thought?

<br />

## Prerequesites

There are some things you will need beforehand.

- a server running Linux
- root privileges
- Docker installed

<br />

## Setup

First of all you need to change the entries in the *spigot.env* file if needed.

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

Make the build script executeable
```
chmod +x ./build.sh
```

Run the build script

```
sudo ./build.sh
```

<br />

## Start the server

Make the start script executeable
```
chmod +x ./start.sh
```

Run the start script with root privileges
```
sudo ./start.sh
```

You can start the docker detached too
```
sudo ./start.sh -d
```
