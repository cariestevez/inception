FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && apt-get clean

COPY ../tools/entrypoint.sh /entrypoint.sh
COPY ../conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && \
    mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql && \
    chmod +x /entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]

