#!/bin/bash

# Start the MySQL service
service mysql start

# Setup the database
# Create a new database with the name from the .env
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create a new user
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PSWD}';"

# Give all privileges to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PSWD}';"

# Change the root user password to the one from the .env
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PSWD}';"

# Make the changes be effective immediately
mysql -e "FLUSH PRIVILEGES;"

# Restart the MySQL service
service mysql restart
