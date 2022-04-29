#!/bin/sh
DB_HOST="${DB_HOST:-http://influxdb:8086}"
DB_NAME="${DB_NAME:-speedtest}"
DB_USERNAME="${DB_USERNAME:-admin}"
DB_PASSWORD="${DB_PASSWORD:-password}"
DATE=$(date +%s)

echo "running speedtest"
JSON=$(speedtest --accept-license --accept-gdpr -f json)

SERVER="$(echo $JSON | jq -r '.server.host')"
ISP="$(echo $JSON | jq -r '.isp')"
PUBLIC_IP=$(curl ifconfig.me)

DOWNLOAD="$(echo $JSON | jq -r '.download.bandwidth')"
UPLOAD="$(echo $JSON | jq -r '.upload.bandwidth')"
curl -s -S -XPOST "$DB_HOST/write?db=$DB_NAME&precision=s&u=$DB_USERNAME&p=$DB_PASSWORD" \
    --data-binary "bandwidth,server=$SERVER,public=$PUBLIC_IP down=$DOWNLOAD,up=$UPLOAD $DATE"

#PING="$(echo $JSON | jq -r '.ping.latency')"
#JITTER="$(echo $JSON | jq -r '.ping.jitter')"
#LOSS="$(echo $JSON | jq -r '.packetLoss')"
#if [[ $LOSS == NULL ]] ;
#then
#  LOSS=0
#fi
#curl -s -S -XPOST "$DB_HOST/write?db=$DB_NAME&precision=s&u=$DB_USERNAME&p=$DB_PASSWORD" \
#    --data-binary "latency,server=$SERVER ping=$PING,jitter=$JITTER,loss=$LOSS $DATE"
