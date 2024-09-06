NAME		= inception
SRCS		= ./srcs/requirements
COMPOSE		= ./srcs/docker-compose.yml
HOST_URL	= cestevez.42.fr

all: $(NAME)

$(NAME): up

build:
	@docker build -t mariadb $(SRCS)/mariadb
	@docker build -t wordpress $(SRCS)/wordpress
	@docker build -t nginx $(SRCS)/nginx

up:	build
	#@sudo hostsed add 127.0.0.1 $(HOST_URL) > $(HIDE) && echo " $(HOST_ADD)"
	#@docker compose -p $(NAME) -f $(COMPOSE) up --build || (echo " $(FAIL)" && exit 1)
	@docker stack deploy -c $(COMPOSE) inception_stack
	@echo "Containers up"

down:
	# Scale services down to 0 replicas instead of removing the stack
	@docker service scale inception_stack_nginx=0 inception_stack_wordpress=0 inception_stack_mariadb=0
	@echo "Containers down"

restart:
	@docker service scale inception_stack_nginx=1 inception_stack_wordpress=1 inception_stack_mariadb=1
	@echo "Containers restarted"

backup:
	@if [ -d ~/data ]; then \
		sudo tar -czvf ~/backup_data.tar.gz -C ~/ data/ && echo "Backup created: ~/backup_data.tar.gz"; \
	else \
		echo "No data directory found, skipping backup"; \
	fi

clean: down
	# Remove the stack and any associated services
	@docker stack rm inception_stack
	@echo "Removed inception stack"

fclean: backup clean
	@sudo rm -rf ~/data  # Remove persistent data (volumes)

	@if [ -n "$$(docker image ls $(NAME)-nginx -q)" ]; then \
		docker image rm -f $(NAME)-nginx && \
		echo "Removed nginx image"; \
	fi

	@if [ -n "$$(docker image ls $(NAME)-wordpress -q)" ]; then \
		docker image rm -f $(NAME)-wordpress && \
		echo "Removed wordpress image"; \
	fi

	@if [ -n "$$(docker image ls $(NAME)-mariadb -q)" ]; then \
		docker image rm -f $(NAME)-mariadb && \
		echo "Removed mariadb image"; \
	fi
	
	# Remove all volumes associated with the project (if necessary)
	@if [ -n "$$(docker volume ls --filter "name=$(NAME)" -q)" ]; then \
		docker volume rm $$(docker volume ls --filter "name=$(NAME)" -q) && \
		echo "Removed volumes"; \
	fi

	# Optionally remove dangling containers and images
	@if [ -n "$$(docker ps -a --filter "status=exited" -q)" ]; then \
		docker rm $$(docker ps -a --filter "status=exited" -q) && \
		echo "Removed exited containers"; \
	fi

	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then \
		docker rmi $$(docker images -f "dangling=true" -q) && \
		echo "Removed dangling images"; \
	fi

	#@sudo hostsed rm 127.0.0.1 $(HOST_URL) > $(HIDE) && echo " $(HOST_RM)"

status:
	@clear
	@echo "\nCONTAINERS\n"
	@docker ps -a
	@echo "\nIMAGES\n"
	@docker image ls
	@echo "\nVOLUMES\n"
	@docker volume ls
	@echo "\nNETWORKS\n"
	@docker network ls --filter "name=$(NAME)_all"
	@echo ""
	
re: fclean all

.PHONY: build all up down restart backup clean fclean status re
