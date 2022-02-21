# Plug-and-play internet monitoring in docker

This project is a plug and play solution for monitoring your internet connection.

### Highlights
* ookla speedtest every 10minutes (download, upload, ping, jitter, packetloss)
* avg ping times of specified hosts and current gateway every minute
* just 6MB docker image

![Screenshot from 2022-02-22 00-11-22](https://user-images.githubusercontent.com/1591457/155036751-33616f54-678d-4c42-b021-fafc42653d51.png)

### Setup

#### install docker + docker-compose

#### clone repo
```
git clone git@github.com:doebi/speedtest.git
```

#### run containers using docker-compose
```
docker-compose up -d
```
