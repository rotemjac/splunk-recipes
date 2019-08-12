#!/usr/bin/env bash
cron -f &
./usr/sbin/syslog-ng -F --no-caps