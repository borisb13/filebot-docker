FROM rednoah/filebot

MAINTAINER Best IT Guys

ARG DOCKER_IMAGE_VERSION=unknown

RUN cp /bin/bash /bin/sh

COPY filebot-watcher /usr/bin/filebot-watcher

WORKDIR /tmp

# Set environment variables.
ENV SETTLE_DOWN_TIME=10 \
    WATCH_FOLDER_NAME="watch" \
    OUTPUT_FOLDER_NAME="output" \
    MEDIA_FOLDER="/volume1" \
    WATCH_FOLDER=${MEDIA_FOLDER}/${WATCH_FOLDER_NAME} \
    OUTPUT_FOLDER=${MEDIA_FOLDER}/${OUTPUT_FOLDER_NAME}
    
# Metadata.
LABEL \
      org.label-schema.name="filebotmod" \
      org.label-schema.description="Docker container for FileBot" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/borisb13/filebot-docker" \
      org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/filebot-watcher"]
