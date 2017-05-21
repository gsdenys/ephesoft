#!/bin/bash

echo "starting mysql server"
/etc/init.d/mysql start

echo "starting ephesoft server"
/etc/init.d/ephesoft start

echo "Ephesoft logs"
tail -f /opt/Ephesoft/JavaAppServer/logs/catalina.out
