# Ephesoft
The Ephesoft community edition docker project

## usage

To start Ephesoft docker container use the follow command 
 
    docker run -p 8080:8080 gsdenys/ephesoft

This command would start Ephesoft container and install MariaDB server inside it. 

This way, all data will be stored inside container, and once you kill the container you also will kill the data.
 
Other approach that you can use is externalize the database and shared folder. To do that you can use the **-e** operator to pass the following parameters to the container:

* **DB_DATASOURCE** - Use this property to pass the MariaDB/MySQL data source URL. e.g _jdbc:mysql://localhost:3306/ephesoft_
* **DB_USER** - The user that will be used to connect to the data source.
* **DB_PASSWD** - The user password used to connect to the data source.

Beyond the datasource parameter you also can use set parameter to change the host name and port of Ephesoft. You may want to do this to avoid errors when accessing some URL.

Change the Ephesoft hostname and port using the following parameters:

* **HOSTNAME** - The name of host.
* **PORT** - The port number.

If you want to externalize the ephesoft Shared Folder too, you just need to mount any volume nammed **/shared** inside your container using the **-v** command. eg. _-v /host/anyDir:/shared_

Below you can see an example of a fully passed parameter set to the Ephesoft container.

    docker run -p 8080:8080 -v /shared:/shared -e DB_DATASOURCE=jdbc:mysql://dbhost:3306/ephesoft -e DB_USER=ephesoft -e DB_PASSWD=ephesoft -e HOSTNAME=thehostname -e PORT=8080 gsdenys/ephesoft

After command executed, wait for Tomcat startup successfully and with a browser access follow URL.

http://localhost:8080/dcma

**PS:** If you want to have a container with MariaDB already installed, use the following command:
 
    docker run -p 8080:8080 gsdenys/ephesoft:mariadb