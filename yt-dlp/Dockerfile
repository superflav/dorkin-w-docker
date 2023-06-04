FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y curl python-is-python3 ffmpeg

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp

ENTRYPOINT [ "/bin/bash" ]