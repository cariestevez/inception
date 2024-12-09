COMPOSE	= ./srcs/docker-compose.yml
DATA	= /home/cestevez/data
#DATA	= /Users/carinaestevezorth/Documents/42curriculum/data

all:	up

install: 
	@sudo apt-get update
	@sudo apt-get install -y docker.io docker-compose
	@sudo usermod -aG docker $(USER)
	@newgrp docker

up:	
	@docker-compose -f $(COMPOSE) up -d

down:
	@docker-compose -f $(COMPOSE) down -v

prune:
	@docker system prune -af

backup:
	@if [ -d $(DATA) ]; then \
		sudo tar -czvf ~/backup_data.tar.gz -C $(DATA) && echo "Backup created: ~/backup_data.tar.gz"; \
	else \
		echo "No data directory found, skipping backup"; \
	fi

clean:	down prune
	
fclean:	clean
		sudo rm -rf $(DATA)/wordpress_db/* $(DATA)/wordpress_files/*
#sudo rm -rf ~/backup_data.tar.gz 2>/dev/null

status:
	@clear
	@echo "\nCONTAINERS\n"
	@docker ps -a
	@echo "\nIMAGES\n"
	@docker image ls
	@echo "\nVOLUMES\n"
	@docker volume ls
	@echo "\nNETWORKS\n"
	@docker network ls
	
re:	fclean up

.PHONY: all up down prune backup clean fclean status re
