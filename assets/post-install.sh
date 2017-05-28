#!/bin/bash

META_INF_DIR=/opt/Ephesoft/Application/WEB-INF/classes/META-INF
DB_PROPERTIES_FILE=$META_INF_DIR/dcma-data-access/dcma-db.properties 
OPEN_OFFICE_CONFIG=$META_INF_DIR/dcma-open-office/open-office.properties

#set Operational sistem as RedHat
echo "os_name=redhat" >> /etc/Ephesoft/ephesoft.conf

#Remove all sudo command from ephesoft startup script
sed -i "s/sudo/\ /g" /etc/init.d/ephesoft

#Set openoffice autostart as false
sed -i "/openoffice.autoStart=/ s/=true/=false/" $OPEN_OFFICE_CONFIG


#set MariaDB as a default database
sed -i "/dataSource.url=/ s|=.*|=jdbc:mysql:\/\/localhost:3306\/ephesoft|" $DB_PROPERTIES_FILE
sed -i "/dataSource.username=/ s|=.*|=ephesoft|" $DB_PROPERTIES_FILE
sed -i "/dataSource.password=/ s|=.*|=ephesoft|" $DB_PROPERTIES_FILE
#sed -i "/dataSource.dialect=/ s|=.*|=org.hibernate.dialect.MySQL5InnoDBDialect|" $DB_PROPERTIES_FILE
#sed -i "/dataSource.driverClassName=/ s|=.*|=org.h2.Driver|" $DB_PROPERTIES_FILE


#create mount poiint to shared folder
mkdir /shared


# Add shared loader driver libary - use this folder to mount the host directory that contains
# all drivers and extra jars that you wanna load during the tomcat startup.
#
# You also can use volume to pass to the container the jars that you wanna load.
# 
#mkdir /driver
#sed -i "/shared.loader=/ s|=.*|=/driver/*.jar|" /opt/Ephesoft/JavaAppServer/conf/catalina.properties


#remove garbadge
yum clean packages
yum clean headers
yum clean metadata
yum clean dbcache

rm -rf /tmp/*
rm -rf /opt/sources/*

cd /opt/Ephesoft/Dependencies/

rm -rf *.tar.gz \
	   dependencies_redhat \
	   dependencies_ubuntu \
	   svutil.cpp \
	   UpgradeEphesoft.jar \
	   MariaDBSetup \
	   luke