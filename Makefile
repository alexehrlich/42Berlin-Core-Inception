# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aehrlich <aehrlich@student.42berlin.de>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/18 11:03:35 by aehrlich          #+#    #+#              #
#    Updated: 2024/02/20 16:26:12 by aehrlich         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

#start the multicontainer application
# -f: specify the path
# -d: start in detatched mode - runs in the background
up:
	@if ! [ -d "/home/data" ]; then \
		mkdir /home/data; \
		mkdir /home/data/wordpress; \
		mkdir/home/data/mysql; \
		echo "Data volumes created"; \
	fi
	@docker-compose -f ./srcs/docker-compose.yml up -d

#stop and remove the containers, networks and volumes from the 
# specified docker-compose.yml
down:
	@docker-compose -f ./srcs/docker-compose.yml down

#stop the containers, networks and volumes from the 
# specified docker-compose.yml without removing
stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

#start the containers, networks and volumes from the 
# specified docker-compose.yml which were stopped
start : 
	@docker-compose -f ./srcs/docker-compose.yml start

# list all the running docker containers
status : 
	@docker ps

