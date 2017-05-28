#!/bin/bash


echo "===================== ATTENTION! ====================="
echo "This is an Ephesoft Community container builded for a test propouse."
echo "It's not ready for production!!"
echo "If you want to install in production i encourage you to contact the Ephesoft Inc or any one Ephesoft partner."
echo "Access http://www.ephesoft.com/"
echo "======================================================="


META_INT_DIR=/opt/Ephesoft/Application/WEB-INF/classes/META-INF/
DB_PROPERTIES_FILE=$META_INT_DIR/dcma-data-access/dcma-db.properties
BATCH_PROPERTIES_FILE=$META_INT_DIR/dcma-batch/dcma-batch.properties 


# Configure hostname
if [ -z "$PORT" ]; then
	PORT="8080"
fi

if [ -z "$HOSTNAME" ]; then
	HOSTNAME="localhost"
fi

NEW_HOST="http\://$HOSTNAME\:$PORT/dcma-batches"
sed -i "/batch.base_http_url=/ s|=.*|=$NEW_HOST|" $BATCH_PROPERTIES_FILE


#check if /shared is a mounted volume

if grep -qs '/shared' /proc/mounts; then
	#check if SharedFolder ist not a symlink
	if [ ! -z "$(ls -A /opt/Ephesoft/SharedFolders)" ]; then
		echo "Set shared folder as /shared"
		mv /opt/Ephesoft/SharedFolders /tmp
		ln -s /shared /opt/Ephesoft/SharedFolders
	fi

	if [ ! -L /opt/Ephesoft/SharedFolders ]; then
		echo "Transforming SharedFolders directory in a symlink to /shared, that was mounted as volume"
		mv /opt/Ephesoft/SharedFolders /tmp
		ln -s /shared /opt/Ephesoft/SharedFolders
		mv /tmp/SharedFolders/* /shared
	fi

	rm -rf /tmp/*
fi



#set datasource url - the default is 'jdbc:mysql://localhost:3306/ephesoft'
if [ ! -z "$DB_DATASOURCE" ]; then
	sed -i "/dataSource.url=/ s|=.*|=$DB_DATASOURCE|" $DB_PROPERTIES_FILE

	#set datasource username - the default user is 'ephesoft'
	if [ ! -z "$DB_USER" ]; then
		sed -i "/dataSource.username=/ s|=.*|=$DB_USER|" $DB_PROPERTIES_FILE
	fi

	#Set datasource password - the default password is 'ephesoft'
	if [ ! -z "$DB_PASSWD" ]; then
		sed -i "/dataSource.password=/ s|=.*|=$DB_PASSWD|" $DB_PROPERTIES_FILE
	fi
else
	if [ ! -f /etc/init.d/mysql ]; then
		echo "============= Installing MariaDB ============="
		echo "Please wait... It'll take some time"

		#yum update -y
		yum -y install MariaDB-server MariaDB-client

		echo "configure ephesoft datasource"
		/etc/init.d/mysql start

		mysql -uroot -e "CREATE DATABASE IF NOT EXISTS ephesoft"

		mysql -uroot -e "GRANT USAGE ON *.* TO 'ephesoft'@'localhost' IDENTIFIED BY 'ephesoft'"
		mysql -uroot -e "DROP USER 'ephesoft'@'localhost'"
		mysql -uroot -e "GRANT USAGE ON *.* TO 'ephesoft'@'%' IDENTIFIED BY 'ephesoft'"
		mysql -uroot -e "DROP USER 'ephesoft'@'%'"
		mysql -uroot -e "CREATE USER 'ephesoft'@'localhost' IDENTIFIED BY 'ephesoft'"
		mysql -uroot -e "GRANT ALL PRIVILEGES ON ephesoft.* TO 'ephesoft'@'localhost' WITH GRANT OPTION"
		mysql -uroot -e "CREATE USER 'ephesoft'@'%' IDENTIFIED BY 'ephesoft'"
		mysql -uroot -e "GRANT ALL PRIVILEGES ON ephesoft.* TO 'ephesoft'@'%' WITH GRANT OPTION"

		mysql -uroot -e "SET PASSWORD = PASSWORD('ephesoft')"	
	else
		echo "Starting MariaDB server"
		/etc/init.d/mysql start
	fi
fi


echo "starting ephesoft server"
/etc/init.d/ephesoft start

echo "Ephesoft logs"
tail -f /opt/Ephesoft/JavaAppServer/logs/catalina.out