FROM alpine:latest
ARG TARGETARCH

RUN apk add ffmpeg mutagen deno

RUN apk update --no-cache

RUN mkdir -p /app/output

#Running `yt-dlp --update-to master` does not work properly, do this instead.
RUN wget -O /bin/yt-dlp https://github.com/yt-dlp/yt-dlp-master-builds/releases/download/2026.02.07.231301/yt-dlp
#this binary is universal. Other binaries won't work on alpine due to being compiled with glibc, which alpine doesn't use. 

#make yt-dlp executable for all users
RUN chmod +x /bin/yt-dlp
RUN yt-dlp -U
#update yt-dlp if needed. Will update from whatever branch it's currently on, such as master, nightly, or stable.

# Create a non-privileged user that the app will run under.
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
