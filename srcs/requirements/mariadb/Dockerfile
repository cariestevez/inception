FROM debian:12.6

RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY	tools/setup.sh /bin/
RUN	chmod +x /bin/setup.sh

EXPOSE 3306

CMD	["setup.sh", "mysqld_safe"]

