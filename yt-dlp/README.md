# Download videos using YT-DLP

Use Docker to spin up a container with [YT-DLP](https://github.com/yt-dlp/yt-dlp) installed and download videos from a variety of video platforms. 

## Build image
```
docker build -t superflav/yt-dlp .
```

## Run container w/mounted dir
```
docker run -it -v $(pwd)/mount:/data/mount superflav/yt-dlp
```

## Download video into mounted dir
```
yt-dlp -o '/data/mount/%(title)s-%(id)s.%(ext)s' https://youtu.be/DX3MpELQF9U
```
