FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && apt-get clean

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/self-signed.crt /etc/ssl/certs/
COPY ./conf/self-signed.key /etc/ssl/private/

#EXPOSE 8080
EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]

