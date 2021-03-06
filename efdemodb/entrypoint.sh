#!/bin/bash

if [ ! -f /tmp/mysql_ready ]; then
  echo "Initializing $DATADIR..."
  mysql_install_db
  touch /tmp/mysql_ready
fi

echo "Checking integrity of data from $DATADIR..."
/usr/sbin/mysqld &
TMPPID=$!
sleep 30


mysql --user=root --password=root "SHOW databases; USE mysql;"

mysqladmin -u root password 'password'

mysql --user=root --password=password  <<EOF
drop database if exists univers;
create database univers;
grant all privileges on *.* to 'root'@'%' identified by 'password'; 
flush privileges;
use univers;
EOF

kill -TERM $TMPPID && wait
STATUS=$?

if [ "$STATUS" = "0" ]; then
        echo "Using data from $DATADIR..."
        echo "Starting mysql services.."
        /etc/init.d/mysql start && /etc/init.d/commanderAgent start && tail -F /opt/electriccloud/electriccommander/logs/agent/agent.log
else
        echo "Cannot load data from $DATADIR."
fi
