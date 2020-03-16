FROM rednoah/filebot

MAINTAINER Best IT Guys

ARG DOCKER_IMAGE_VERSION=unknown

RUN cp /bin/bash /bin/sh

COPY filebot-watcher /usr/bin/filebot-watcher

WORKDIR /tmp

# Set environment variables.
ENV SETTLE_DOWN_TIME=10 \
    WATCH_DIR_NAME="watch" \
    OUTPUT_DIR_NAME="output" \
    MEDIA_DIR=/volume1
    
# Metadata.
LABEL \
      org.label-schema.name="filebotmod" \
      org.label-schema.description="Docker container for FileBot" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/borisb13/filebot-docker" \
      org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/filebot-watcher /volume1/${WATCH_DIR_NAME} --output /volume1/${OUTPUT_DIR_NAME}"]
