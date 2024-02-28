FROM debian:bullseye

#container will listen to this port at runtime. Its mapped to the hosts 443 (docker compose)
EXPOSE 443

#update and upgrade all packages in the container
RUN apt update -y && apt upgrade -y

#install the nginx and openssl
RUN apt install nginx -y && apt install openssl -y

#Create the TSL certificate for secure connection:
	# make a directory at /etc/nginx
	# run the openssl service to create a cert and a key
		# req: request a new certificate
		# -x509: The output should be a self signed certificate
		# -nodes: encrypt the private key
		# -out: safe the cert in a file
		# -keyout: safe the key in a file
RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes \
		-out /etc/nginx/ssl/TSL_certificate.crt -keyout /etc/nginx/ssl/TSL_private.key \
		-subj "/C=DE/ST=Berlin/L=Berlin/O=42/OU=42/CN=aehrlich.42.fr/UID=aehrlich"

#create a new directory in the container
RUN mkdir -p /run/nginx

#copy the server config from the host machine repo to the container
COPY ./conf/nginx.conf /etc/nginx/conf.d/server.conf

#run the service in the foreground
CMD [ "nginx", "-g", "daemon off;" ]
