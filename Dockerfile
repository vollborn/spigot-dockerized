ARG JAVA_VERSION=16

FROM openjdk:${JAVA_VERSION}

LABEL maintainer="vollborn <oliver.vollborn@gmail.com>"
LABEL version="1.0"
LABEL description="a simple spigot server container"

ENV VERSION 1.17
ENV RAM_MAX 2048M
ENV RAM_MIN 512M

EXPOSE 25565

COPY ./src/run.sh /opt
RUN chmod +x /opt/run.sh

CMD /opt/run.sh ${VERSION} ${RAM_MIN} ${RAM_MAX}
