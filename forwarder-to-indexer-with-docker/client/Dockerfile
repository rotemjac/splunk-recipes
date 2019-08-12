#FROM debian:stretch AS Cron

FROM ubuntu:latest AS Cron

## Setup ##
RUN apt-get update -qq && apt-get install -y wget gnupg2

RUN wget -qO - https://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/Debian_9.0/Release.key | apt-key add -
RUN echo 'deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/Debian_9.0 ./' | tee --append /etc/apt/sources.list.d/syslog-ng-obs.list


## Cron ##
RUN apt-get install -y cron

ADD cron/crontab /etc/cron.d/cloudbuy-cron

ADD cron/cron_script.sh /script.sh
RUN chmod +x /script.sh

RUN chmod 0644 /etc/cron.d/cloudbuy-cron


RUN touch /var/log/cron.log


## Syslog ##
FROM Cron AS Syslog-Client-cron

RUN apt-get update -qq && apt-get install -y syslog-ng

ADD syslog/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

RUN find /usr/lib/ -name 'libjvm.so*' | xargs dirname | tee --append /etc/ld.so.conf.d/openjdk-libjvm.conf
RUN ldconfig

EXPOSE 514/udp
EXPOSE 601/tcp
EXPOSE 6514/tcp

ADD wrapper.sh /wrapper.sh
RUN chmod +x /wrapper.sh

CMD ./wrapper.sh

#Because Only the last ENTRYPOINT instruction in the Dockerfile will have an effect - We combine:
#CMD ["cron", "-f"]
#ENTRYPOINT ["/usr/sbin/syslog-ng", "-F", "--no-caps"]


