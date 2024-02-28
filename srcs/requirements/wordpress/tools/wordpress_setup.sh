#!/bin/bash

#change working dir to where all the wordpress files are
cd /var/www/wordpress

# give MariaDB time to lauch correctly:
sleep 10

#if there is no wordpress config: create one. 
# Use the MariaDB credentials and the networkport 3306 to set it up
if [ ! -e /var/www/wordpress/wp-config.php ]; then
	wp config create --allow-root \
									  --dbname=$SQL_DATABASE \
									  --dbuser=$SQL_USER \
									  --dbpass=$SQL_PSWD \
									  --dbhost=mariadb:3306
fi

# This command installs WordPress with the specified parameters like site URL,
# site title, admin username, password, and email. This sets up the initial
# configuration of the WordPress site.
wp core install --url="$DOMAIN_NAME" \
							  --title="$SITE_TITLE" \
							  --admin_user="$WP_ADMIN" \
							  --admin_password="$WP_ADMIN_PSWD" \
							  --admin_email="$WP_ADMIN_EMAIL" \
							  --allow-root

# create a new wordpress user with the credentials from the .env
wp user create --allow-root $WP_USER $WP_USER_EMAIL \
							   --role=editor \
							   --user_pass=$WP_USER_PSWD \

# create dir if not existant
if [ ! -d /run/php ]; then
	mkdir /run/php
fi

# start the fast cgi process manager and run it in the foreground
/usr/sbin/php-fpm7.4 -F