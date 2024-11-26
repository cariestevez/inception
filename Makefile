COMPOSE	= ./srcs/docker-compose.yml
DATA	= ~/data

all:	up

up:	
	@docker compose -f $(COMPOSE) up -d

down:
	@docker compose -f $(COMPOSE) down

prune:
	@docker system prune -af


backup:
	@if [ -d $(DATA) ]; then \
		sudo tar -czvf ~/backup_data.tar.gz -C $(DATA) && echo "Backup created: ~/backup_data.tar.gz"; \
	else \
		echo "No data directory found, skipping backup"; \
	fi

clean:	down prune
	sudo rm -rf $(DATA)/db_data/{*,.*} $(DATA)/wp_data/{*,.*} 2>/dev/null
	
fclean: clean
	sudo rm -rf ~/backup_data.tar.gz 2>/dev/null

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
	
re:	down clean up

.PHONY: all up down prune backup clean status re
