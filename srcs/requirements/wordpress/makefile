all: build run

build:
	docker build -t wp .

run:
	docker run -d --name wordpress wp

exec:
	docker exec -it wordpress bash

stop:
	docker stop wordpress

down: stop
	docker rm wordpress

re: clean all exec

clean: down
	docker image rm wp
	docker system prune --volumes -f