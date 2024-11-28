FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY ../tools/entrypoint.sh /entrypoint.sh
COPY ../conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]

