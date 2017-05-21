#!/usr/bin/env sh

##
#configure MariaDB
##
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

mysql -uroot -e "SET PASSWORD = PASSWORD('turbo')"

##
#configure installer
##
cd /tmp
unzip ephesoft.zip -d installer
cd installer

sed -i "/input_new_database_instance=/ s/=y/=n/" Response-Files/config.properties 

chmod 755 install install-helper