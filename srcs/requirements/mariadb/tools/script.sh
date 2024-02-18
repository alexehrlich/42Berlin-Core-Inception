#!/bin/bash

#This scripts automates creating a MYSQL DB, a user, setting the privleges, changing
#the root and then shut
#start the mysql service
service mysql start 

#a file called db1.sql containing th command to create a DB
echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" > db1.sql

#create the user (.env) from the env-var db_user1 if not existent.
# '%' -> The user can connect from any host. E.g. localhost could be a restriction here
# append this command to the db1.sql file
echo "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;" >> db1.sql

#The user can perform every action SELECT, INSER, UPDATE, DELETE, CREATE, ALTER.. .on the db
# append to file
echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" >> db1.sql

#Change the password for the root user to 12345 and append it to the file
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql

#FLush the written privileges to make sure the chnage take effect immediately
echo "FLUSH PRIVILEGES;" >> db1.sql

#Execute the SQL-commands which were written into our db1.sql file from above
mysql < db1.sql

#send a termination signal to the MYSQL Server process, which shuts the server down
# shutting down a server after setup esures that those changes are properly applied
kill $(cat /var/run/mysqld/mysqld.pid)

mysqld