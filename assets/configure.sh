#!/usr/bin/env sh

#uncompress ephesoft installer .zip 
unzip /tmp/ephesoft.zip -d /tmp/installer

#set the configuration propertis filepath
CONFIG_PROPERTIES_FILE=/tmp/installer/Response-Files/config.properties 

#
# Alter the intaller config properties. Set:
#	NO (n) to a new database instance, 
# 	YES (y) to a change server name, and;
#	LOCALHOST (localhost) to a server name
# 
sed -i "/input_new_database_instance=/ s/=y/=n/" $CONFIG_PROPERTIES_FILE
sed -i "/input_change_server_name=/ s/=n/=y/" $CONFIG_PROPERTIES_FILE
sed -i "/input_changed_server_name=/ s/=turbo-VirtualBox/=localhost/" $CONFIG_PROPERTIES_FILE

# make installer files executable
chmod 755 /tmp/installer/install*