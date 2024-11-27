FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY ../tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

