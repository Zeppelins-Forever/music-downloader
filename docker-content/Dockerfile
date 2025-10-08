# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

################################################################################
# Pick a base image to serve as the foundation for the other build stages in
# this file.
#
# For illustrative purposes, the following FROM command
# is using the alpine image (see https://hub.docker.com/_/alpine).
# By specifying the "latest" tag, it will also use whatever happens to be the
# most recent version of that image when you build your Dockerfile.
# If reproducibility is important, consider using a versioned tag
# (e.g., alpine:3.17.2) or SHA (e.g., alpine@sha256:c41ab5c992deb4fe7e5da09f67a8804a46bd0592bfdf0b1847dde0e0889d2bff).

FROM alpine:latest
ARG TARGETARCH
################################################################################
# Create a stage for building/compiling the application.
#
# The following commands will leverage the "base" stage above to generate
# a "hello world" script and make it executable, but for a real application, you
# would issue a RUN command for your application's build process to generate the
# executable. For language-specific examples, take a look at the Dockerfiles in
# the Awesome Compose repository: https://github.com/docker/awesome-compose
#FROM base as build
#RUN echo -e '#!/bin/sh\n\
#echo Hello world from $(whoami)! In order to get your application running in a container, #take a look at the comments in the Dockerfile to get started.'\
#> /bin/hello.sh
#RUN chmod +x /bin/hello.sh

###### MY CODE ######
RUN apk update && apk add ffmpeg mutagen && mkdir -p /app/output
#COPY yt-dlp /bin/

#update this link to the newest "yt-dlp" build from the master branch: https://github.com/yt-dlp/yt-dlp-master-builds/releases 
RUN wget -O /bin/yt-dlp https://github.com/yt-dlp/yt-dlp-master-builds/releases/download/2025.10.01.065439/yt-dlp 
#this binary is universal. Other binaries won't work on alpine due to being compiled with glibc, which alpine doesn't use. 

#Below is an example of platform-specific packages for different builds (though these won't work because Alpine has no glibc support, so apps need to either come from Alpine repo or be compatible without being compiled via glibc).
# RUN if [ "$TARGETARCH" = "arm64" ]; then \
#        echo "\n\n$TARGETARCH - Building for ARM64, installing ARM-specific packages...\n\n" ; \
#        wget -O /bin/yt-dlp https://github.com/yt-dlp/yt-dlp-master-builds/releases/download/2025.10.01.065439/yt-dlp_linux_aarch64 ; \
#    elif [ "$TARGETARCH" = "amd64" ]; then \
#        echo "\n\n$TARGETARCH - Building for AMD64, installing x86-64-specific packages...\n\n" ; \
#        wget -O /bin/yt-dlp https://github.com/yt-dlp/yt-dlp-master-builds/releases/download/2025.10.01.065439/yt-dlp_linux ; \
#    else \
#        echo "\n\nUNSUPPORTED ARCHITECTURE: $TARGETARCH\n\n" ; \
#        exit 1 ; \
#    fi

#make yt-dlp executable for all users
RUN chmod +x /bin/yt-dlp
#update yt-dlp if needed. Will update from whatever branch it's currently on, such as master, nightly, or stable.
RUN yt-dlp -U

##################### this can be changed to "--update-to stable/nightly/master" as needed.

################################################################################
# Create a final stage for running your application.
#
# The following commands copy the output from the "build" stage above and tell
# the container runtime to execute it when the image is run. Ideally this stage
# contains the minimal runtime dependencies for the application as to produce
# the smallest image possible. This often means using a different and smaller
# image than the one used for building the application, but for illustrative
# purposes the "base" image is used here.
#FROM base AS final

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser

# Copy the executable from the "build" stage.
#COPY --from=build /bin/hello.sh /bin/

COPY --chown=appuser download.sh /app/
RUN chmod +x /app/download.sh
WORKDIR /app

# What the container should run when it is started.
ENTRYPOINT [ "/app/download.sh" ]
