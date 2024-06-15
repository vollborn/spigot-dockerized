ARG JAVA_VERSION=16

FROM openjdk:${JAVA_VERSION}-buster

LABEL maintainer="vollborn <oliver.vollborn@gmail.com>"
LABEL version="1.0"
LABEL description="a simple spigot server container"

ENV VERSION 1.21
ENV MEMORY_MAX 2048M
ENV MEMORY_MIN 512M
ENV BUILD_ON_START false
ENV EULA false

EXPOSE 25565

COPY ./run.sh /opt
RUN chmod +x /opt/run.sh

CMD /opt/run.sh
