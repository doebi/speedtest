#!/bin/sh
DB_HOST="${DB_HOST:-http://influxdb:8086}"
DB_NAME="${DB_NAME:-speedtest}"
DB_USERNAME="${DB_USERNAME:-admin}"
DB_PASSWORD="${DB_PASSWORD:-password}"

DATE=$(date +%s)
GW=$(ip -4 route | awk '/^default/ { print $3 }')
PUBLIC_IP=$(curl ifconfig.me)
COUNT=20
TIMEOUT=1

for host in $GW 1.1.1.1 8.8.8.8; do

  result=$(ping -c $COUNT -W $TIMEOUT $host)
  #min=$(echo $result | awk -F"[,/]" '/round/{print $5}')
  avg=$(echo $result | awk -F"[,/]" '/round/{print $6}')
  #max=$(echo $result | awk -F"[,/]" '/round/{print $7}')
  loss=$(echo $result | grep -o "[0-9]\+%" | cut -f1 -d% )

  curl -s -S -XPOST "$DB_HOST/write?db=$DB_NAME&precision=s&u=$DB_USERNAME&p=$DB_PASSWORD" \
    --data-binary "ping,host=$host,public=$PUBLIC_IP avg=$avg,loss=$loss $DATE"

done
