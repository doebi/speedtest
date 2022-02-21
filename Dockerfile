FROM alpine:3.12

RUN echo "*/10 * * * * /opt/monitor/speedtest.sh" >> /etc/crontabs/root

RUN echo "* * * * * /opt/monitor/ping.sh" >> /etc/crontabs/root

RUN apk add --no-cache jq wget curl

RUN wget -O speedtest-cli.tgz https://install.speedtest.net/app/cli/ookla-speedtest-1.1.1-linux-x86_64.tgz \
    && tar zxvf speedtest-cli.tgz \
    && rm speedtest-cli.tgz \
    && mv speedtest* /usr/bin/

CMD crond -f -l 8
