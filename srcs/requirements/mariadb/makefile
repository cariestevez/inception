all: build run

build:
	docker build -t maria .

run:
	docker run -d --name mariadb maria

exec:
	docker exec -it mariadb bash

stop:
	docker stop mariadb

down: stop
	docker rm mariadb

re: clean all exec

clean: down
	docker image rm maria
	docker system prune --volumes -f
