#!/bin/bash

#start the (by Docker) installed SQL service
service mysql start

# Setup the data base
# -e: Execute a single line in the command line

#create a new database with the name from the .env
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

#create a new user
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PSWD}';"

#give all privileages to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PSWD}';"

#change the root user pwd to the one from the .env
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PSWD}';"

#make the changes be effective immediately
mysql -e "FLUSH PRIVILEGES;"

#shutdown to make the changes happen
mysqladmin -u root -p$SQL_ROOT_PSWD shutdown

#start the mysql service again
exec mysqld_safe