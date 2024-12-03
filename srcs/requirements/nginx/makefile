all: build run

build:
	docker build -t nginx-img .

run:
	docker run -d --name nginx -p 8080:80 nginx-img

exec:
	docker exec -it nginx bash

stop:
	docker stop nginx

down: stop
	docker rm nginx

re: clean all exec

clean: down
	docker image rm nginx-img
	docker system prune --volumes -f
