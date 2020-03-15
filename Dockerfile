FROM ubuntu:18.04

MAINTAINER Best IT Guys

ARG DOCKER_IMAGE_VERSION=unknown
ARG FILEBOT_VERSION=4.8.5
ARG FILEBOT_URL=https://github.com/barry-allen07/FB-Mod/releases/download/${FILEBOT_VERSION}/FileBot_${FILEBOT_VERSION}_amd64.deb

RUN cp /bin/bash /bin/sh
WORKDIR /tmp

RUN apt-get update \
 && apt-get install -y default-jre-headless libjna-java mediainfo libchromaprint-tools unrar p7zip-full p7zip-rar mkvtoolnix mp4v2-utils gnupg curl file inotify-tools \
 && rm -rvf /var/lib/apt/lists/*
 
RUN curl -# -L ${FILEBOT_URL} --output /tmp/filebot.deb && \
    apt-key adv --fetch-keys https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub  && \
    echo "deb [arch=all] https://get.filebot.net/deb/ universal main" > /etc/apt/sources.list.d/filebot.list && \
    apt-get update && \
    apt install -y --no-install-recommends --allow-downgrades /tmp/filebot.deb && \
    rm -rvf /var/lib/apt/lists/*

COPY filebot-watcher /usr/bin/filebot-watcher

VOLUME /data
VOLUME /watch
VOLUME /output

ENV HOME /data
ENV LANG C.UTF-8
ENV FILEBOT_OPTS "-Dapplication.deployment=docker -Duser.home=$HOME"

# Set environment variables.
ENV APP_NAME="FileBot" \
    AMC_INTERVAL="300" \
    AMC_INPUT_STABLE_TIME="10" \
    AMC_ACTION="move" \
    AMC_CONFLICT="auto" \
    AMC_MATCH_MODE="opportunistic" \
    AMC_ARTWORK="n" \
    AMC_MUSIC_FORMAT="{plex}" \
    AMC_MOVIE_FORMAT="{plex}" \
    AMC_SERIES_FORMAT="{plex}" \
    AMC_ANIME_FORMAT="{plex}" \
    AMC_PROCESS_MUSIC="n" \
    AMC_SUBTITLE_LANG= \
    AMC_CUSTOM_OPTIONS= \
    AMC_INPUT_FOLDER=/watch \
    SETTLE_DOWN_TIME=60 \
    AMC_OUTPUT_FOLDER=/output
    
# Metadata.
LABEL \
      org.label-schema.name="filebotmod" \
      org.label-schema.description="Docker container for FileBot" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/borisb13/filebot-docke" \
      org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/filebot-watcher"]
#ENTRYPOINT ["filebot"]
