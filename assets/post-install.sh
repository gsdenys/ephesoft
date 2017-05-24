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

#Create simbolic link for java
ln -s /opt/Ephesoft/Dependencies/jdk1.7.0_71/bin/java /usr/bin/java



#set H2 as a default database
sed -i "/dataSource.url=/ s|=.*|=jdbc:h2:~\/test|" $DB_PROPERTIES_FILE
sed -i "/dataSource.username=/ s|=.*|=test|" $DB_PROPERTIES_FILE
sed -i "/dataSource.password=/ s|=.*|=|" $DB_PROPERTIES_FILE
sed -i "/dataSource.dialect=/ s|=.*|=org.hibernate.dialect.H2Dialect|" $DB_PROPERTIES_FILE
sed -i "/dataSource.driverClassName=/ s|=.*|=org.h2.Driver|" $DB_PROPERTIES_FILE



# Add shared loader driver libary - use this folder to mount the host directory that contains
# all drivers and extra jars that you wanna load during the tomcat startup.
#
# You also can use volume to pass to the container the jars that you wanna load.
# 
mkdir /driver
sed -i "/shared.loader=/ s|=.*|=/driver/*.jar|" /opt/Ephesoft/JavaAppServer/conf/catalina.properties



#Add the fatal log for com.ephesoft.dcma.da.common.ExecuteUpdatePatch 
#LOG4J_FILE=/opt/Ephesoft/Application/log4j.xml
#sed -i '/<\/log4j:configuration>/ s|</log4j:configuration>|\t<logger name="com.ephesoft.dcma.da.common.ExecuteUpdatePatch">\n\t\t<level value="FATAL" />\n\t</logger>\n</log4j:configuration>|' $LOG4J_FILE



#remove garbadge
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