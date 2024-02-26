#FROM debian:buster
FROM debian:oldstable

#listen to port 9000 during runtime (Fast CGI)
EXPOSE 9000

#update and upgrade the packages
RUN apt-get update -y && apt-get upgrade -y

#install wget to install wordpress later
RUN apt-get -y install wget

# install php, php fast cgi process manager, mysql extenion for php and the mariadb client
RUN apt-get -y install php7.3 php-fpm php-mysql mariadb-client

#copy the wordpressconf from the host machine to the docker container
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

#set the working directorie (like cd) inside the container
# download the wordpress and save it in the container
# extract wordpress and remove the downloaded archive
# change ownerchip to root for security reasons
WORKDIR /var/www
RUN wget https://wordpress.org/wordpress-6.3.tar.gz -P .
RUN tar -xzf wordpress-6.3.tar.gz && rm -rf wordpress-6.3.tar.gz
RUN chown -R root:root /var/www/wordpress

# download the wordpress command line interface (PHAR = PHP Archive)
# add executable permissions
# move the cli 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# copy the setup from the host machine to the container
# add exec rights to the shell script after moving
COPY ./tools/wordpress_setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wordpress_setup.sh

#set the working directory to the root inside the container
# common practice that other sub commands start from a known point
WORKDIR /

# after the container is created the setup.sh is executed to configure
# wordpress
ENTRYPOINT [ "bash", "/usr/local/bin/wordpress_setup.sh" ]
