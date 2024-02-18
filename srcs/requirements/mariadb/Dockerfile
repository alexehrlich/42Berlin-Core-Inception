#define the base image to use
FROM debian:oldstable

#update the package-manager and install the mariadb-server-package
RUN apt-get update -y %% apt-get install mariadb-server -y

#copy the conifg file from the container to local
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

CMD ["/script.sh"]
