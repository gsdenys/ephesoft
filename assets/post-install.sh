#!/bin/bash

echo "os_name=redhat" >> /etc/Ephesoft/ephesoft.conf
sed -i "s/sudo/\ /g" /etc/init.d/ephesoft

chkconfig mysql on
chkconfig ephesoft on