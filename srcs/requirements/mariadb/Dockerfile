FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server
#RUN rm -rf /var/lib/mysql && mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
COPY ../tools/entrypoint.sh /entrypoint.sh
#RUN chmod +x /init.sh && ./init.sh

#ENTRYPOINT ["mysqld_safe"]
ENTRYPOINT ["/entrypoint.sh"]

