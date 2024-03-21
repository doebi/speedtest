FROM debian:bullseye

RUN echo "*/15 * * * * /opt/monitor/speedtest.sh" >> /etc/cron.d/speedtest

RUN apt-get update && apt-get install -y curl wget iputils-ping jq

RUN wget -O speedtest-cli.tgz https://install.speedtest.net/app/cli/ookla-speedtest-1.1.1-linux-x86_64.tgz \
    && tar zxvf speedtest-cli.tgz \
    && rm speedtest-cli.tgz \
    && mv speedtest* /usr/bin/

CMD ["/opt/monitor/ping.sh"]
