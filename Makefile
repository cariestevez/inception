NAME		= inception
SRCS		= ./srcs/requirements
COMPOSE		= ./srcs/docker-compose.yml
HOST_URL	= cestevez.42.fr

all: $(NAME)

$(NAME): up

image_exists = $(shell docker images -q $(1) 2> /dev/null)

build:
	@if [ -z "$(call image_exists,mariadb)" ]; then \
		echo "Building mariadb image..."; \
		docker build -t mariadb $(SRCS)/mariadb; \
	else \
		echo "mariadb image already exists, skipping build."; \
	fi
	@if [ -z "$(call image_exists,wordpress)" ]; then \
		echo "Building wordpress image..."; \
		docker build -t wordpress $(SRCS)/wordpress; \
	else \
		echo "wordpress image already exists, skipping build."; \
	fi
	@if [ -z "$(call image_exists,nginx)" ]; then \
		echo "Building nginx image..."; \
		docker build -t nginx $(SRCS)/nginx; \
	else \
		echo "nginx image already exists, skipping build."; \
	fi

up:	build
	@docker stack deploy -c $(COMPOSE) inception_stack
	@echo "Containers up"

down:
	@if docker stack ps inception_stack > /dev/null 2>&1; then \
		echo "Scaling services down..."; \
		docker service scale inception_stack_nginx=0 inception_stack_wordpress=0 inception_stack_mariadb=0; \
		echo "Containers down"; \
	else \
		echo "Stack not found, skipping service scaling"; \
	fi

restart:
	@if docker stack ps inception_stack > /dev/null 2>&1; then \
		echo "Restarting services..."; \
		docker service scale inception_stack_nginx=1 inception_stack_wordpress=1 inception_stack_mariadb=1; \
		echo "Containers restarted"; \
	else \
		echo "Stack not found, skipping service restart"; \
	fi

backup:
	@if [ -d ~/data ]; then \
		sudo tar -czvf ~/backup_data.tar.gz -C ~/ data/ && echo "Backup created: ~/backup_data.tar.gz"; \
	else \
		echo "No data directory found, skipping backup"; \
	fi

clean: down
	@if docker stack ls | grep -q inception_stack; then \
		echo "Removing inception stack..."; \
		docker stack rm inception_stack; \
		echo "Removed inception stack"; \
	else \
		echo "Stack not found, skipping stack removal"; \
	fi
fclean: backup clean
	sudo rm -rf ~/data/db_data/{*,.*} ~/data/wp_data/{*,.*} 2>/dev/null

	@if [ -n "$$(docker image ls nginx -q)" ]; then \
		docker image rm -f $$(docker image ls nginx -q) && \
		echo "Removed nginx image"; \
	fi

	@if [ -n "$$(docker image ls wordpress -q)" ]; then \
		docker image rm -f $$(docker image ls wordpress -q) && \
		echo "Removed wordpress image"; \
	fi

	@if [ -n "$$(docker image ls mariadb -q)" ]; then \
		docker image rm -f $$(docker image ls mariadb -q) && \
		echo "Removed mariadb image"; \
	fi

	@if [ -n "$$(docker volume ls --filter "name=$(NAME)" -q)" ]; then \
		docker volume rm $$(docker volume ls --filter "name=$(NAME)" -q) && \
		echo "Removed volumes"; \
	fi

	@if [ -n "$$(docker ps -a --filter "status=exited" -q)" ]; then \
		docker rm $$(docker ps -a --filter "status=exited" -q) && \
		echo "Removed exited containers"; \
	fi

	@if [ -n "$$(docker images -f "dangling=true" -q)" ]; then \
		docker rmi $$(docker images -f "dangling=true" -q) && \
		echo "Removed dangling images"; \
	fi

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
