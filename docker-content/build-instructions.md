Make sure you're able to do cross-platform builds:
https://docs.docker.com/build/building/multi-platform/#install-qemu-manually

Run the following command, changing "versionNum" to the latest version.
`docker buildx build --push \
--platform linux/arm64/v8,linux/amd64 \
--tag zeppelinsforever/music-downloader:versionNum \
--tag zeppelinsforever/music-downloader:latest .`
