#!/bin/sh
DB_HOST="${DB_HOST:-http://localhost:8086}"
DB_NAME="${DB_NAME:-speedtest}"
DB_USERNAME="${DB_USERNAME:-admin}"
DB_PASSWORD="${DB_PASSWORD:-password}"

COUNT=1
TIMEOUT=20

probe(){
  DATE=$(date +%s)
  result=$(ping -c $COUNT -W $TIMEOUT $host)
  value=$(echo $result | sed 's/^.*\=\ \([0-9]*\.[0-9]*\).*$/\1/')
  curl -s -S -XPOST "$DB_HOST/write?db=$DB_NAME&precision=s&u=$DB_USERNAME&p=$DB_PASSWORD" --data-binary "ping,host=$1,public=$2 value=$value $DATE"
}

while :; do

  PUBLIC_IP=$(curl -s ifconfig.me)

  for host in 10.13.37.1 1.1.1.1 8.8.8.8 149.154.152.154 5.75.161.245; do
    probe $host $PUBLIC_IP &
  done

  sleep 0.5;

done
