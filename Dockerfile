FROM rednoah/filebot

MAINTAINER Best IT Guys

ARG DOCKER_IMAGE_VERSION=unknown

RUN cp /bin/bash /bin/sh

COPY filebot-watcher /usr/bin/filebot-watcher

WORKDIR /tmp

# Set environment variables.
ENV WATCH_DIR_NAME="watch" \
    OUTPUT_DIR_NAME="output" \
    SETTLE_DOWN_TIME=10 \
    AMC_ACTION="move" \
    AMC_CONFLICT="auto" \
    AMC_MATCH_MODE="opportunistic" \
    AMC_MUSIC_FORMAT="{plex}" \
    AMC_MOVIE_FORMAT="{plex}" \
    AMC_SERIES_FORMAT="{plex}" \
    AMC_ANIME_FORMAT="{plex}" \
    AMC_PROCESS_MUSIC="n" \
    AMC_CUSTOM_OPTIONS=
    
# Metadata.
LABEL \
      org.label-schema.name="filebotmod" \
      org.label-schema.description="Docker container for FileBot" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/borisb13/filebot-docker" \
      org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/filebot-watcher"]
