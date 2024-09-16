FROM debian:12.6

RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests -y mariadb-server gettext && \
    rm -rf /var/lib/apt/lists/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN	chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf

COPY	tools/template_init.sql /etc/mysql/template_init.sql
RUN	chmod +x /etc/mysql/template_init.sql

COPY 	tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN 	chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 	3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld_safe"]

