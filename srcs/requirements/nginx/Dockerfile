FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx && apt-get clean

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#EXPOSE 8080
#EXPOSE 443

#ENTRYPOINT ["bin/sh", "-c", "while true; do sleep 1000; done"]
# CMD ["nginx", "-g", "daemon off;"]
# ENTRYPOINT ["bash", "-c", "nginx -g 'daemon off;'"]
ENTRYPOINT ["nginx", "-g", "daemon off;"]

