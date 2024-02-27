#Get base image from docker hub
FROM debian:buster
#FROM debian:oldstable

#listen to port 3306 at runtime. Port 3306 ist default port for maria db to listen to DB server
EXPOSE 3306

# Update and upgrade:
RUN apt update -y && apt upgrade -y

# Install MariaDB:
RUN apt-get install mariadb-server -y

# Copy config file from the host machine for mariadb to the /etc of the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy setup script from the host machine to the container:
COPY ./tools/mariadb_setup.sh /usr/local/bin

# give execution rights to the .sh file
RUN chmod +x /usr/local/bin/mariadb_setup.sh

# When the container starts, this script is executed.
# There a new db and user is created and the service is gets started.
ENTRYPOINT [ "bash", "/usr/local/bin/mariadb_setup.sh" ]
