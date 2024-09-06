FROM debian:12.6

RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests nginx -y && \
    rm -rf /var/lib/apt/lists/*

#COPY ./conf/nginx.conf /etc/nginx/nginx.conf (done in compose file with swarm)
COPY ./*.html /usr/share/nginx/html/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
