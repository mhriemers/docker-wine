FROM ubuntu:latest

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        ca-certificates \
        wget && \
    rm -rf /var/lib/apt/lists/*

ARG WINE_BRANCH=staging
RUN wget -nc -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    . /etc/os-release && \
    wget -nc -P /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$VERSION_CODENAME/winehq-$VERSION_CODENAME.sources && \
    sed -i s+/usr/share/keyrings/+/etc/apt/keyrings/+ /etc/apt/sources.list.d/winehq-$VERSION_CODENAME.sources && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --install-recommends winehq-$WINE_BRANCH && \
    rm -rf /var/lib/apt/lists/*