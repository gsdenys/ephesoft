#!/bin/bash

#set Operational sistem as RedHat
echo "os_name=redhat" >> /etc/Ephesoft/ephesoft.conf

#Remove all sudo command from ephesoft startup script
sed -i "s/sudo/\ /g" /etc/init.d/ephesoft

#Set openoffice autostart as false
sed -i "/openoffice.autoStart=/ s/=true/=false/" /opt/Ephesoft/Application/WEB-INF/classes/META-INF/dcma-open-office/open-office.properties

chkconfig mysql on
chkconfig ephesoft on

rm -rf /tmp/*
rm -rf /opt/sources/*

cd /opt/Ephesoft/Dependencies/
rm -rf checkinstall.tar.gz \
	   ghostscript.tar.gz \
	   imagemagick.tar.gz \
	   leptonica.tar.gz \
	   LibreOffice.tar.gz \
	   mariadb.tar.gz \
	   MariaDBSetup \
	   tesseract.tar.gz