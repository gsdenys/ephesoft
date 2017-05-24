#!/bin/bash

META_INT_DIR=/opt/Ephesoft/Application/WEB-INF/classes/META-INF/
DB_PROPERTIES_FILE=$META_INT_DIR/dcma-data-access/dcma-db.properties
BATCH_PROPERTIES_FILE=$META_INT_DIR/dcma-batch/dcma-batch.properties 
H2_JAR_FILE=/opt/Ephesoft/JavaAppServer/lib/h2.jar


# Configure hostname
if [ ! -z "$HOSTNAME" ]; then
	NEW_HOST="http\://$HOSTNAME\:8080/dcma-batches"

	sed -i "/batch.base_http_url=/ s|=.*|=$NEW_HOST|" $BATCH_PROPERTIES_FILE
fi

#set datasource url - the default is 'jdbc:h2:~\/test'
if [ ! -z "$DB_DATASOURCE" ]; then
	sed -i "/dataSource.url=/ s|=.*|=$DB_DATASOURCE|" $DB_PROPERTIES_FILE

	#set datasource username - the default user is 'test'
	if [ ! -z "$DB_USER" ]; then
		sed -i "/dataSource.username=/ s|=.*|=$DB_USER|" $DB_PROPERTIES_FILE
	fi

	#Set datasource password - the default password is '' (empty string)
	if [ ! -z "$DB_PASSWD" ]; then
		sed -i "/dataSource.password=/ s|=.*|=$DB_PASSWD|" $DB_PROPERTIES_FILE
	fi

	#Set the datasource dialect - the default is 'org.hibernate.dialect.H2Dialect'
	if [ ! -z "$DB_DIALECT" ]; then
		sed -i "/dataSource.dialect=/ s|=.*|=$DB_DIALECT|" $DB_PROPERTIES_FILE
	fi

	#Set the datasource driver - the default is 'org.h2.Driver'
	if [ ! -z "$DB_DRIVER" ]; then
		sed -i "/dataSource.driverClassName=/ s|=.*|=$DB_DRIVER|" $DB_PROPERTIES_FILE
	fi
else
	# In case of the database was not set, then start the H2 file based database 
	java -jar $H2_JAR_FILE &
fi





echo "starting ephesoft server"
/etc/init.d/ephesoft start

echo "Ephesoft logs"
tail -f /opt/Ephesoft/JavaAppServer/logs/catalina.out
