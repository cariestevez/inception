#!/bin/bash
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Starts MariaDB in the background
#mysqld_safe &
service mariadb start

#until mysql -u root -e "SELECT 1" > /dev/null 2>&1; do
#    echo "Waiting for MariaDB to be ready..."
#    sleep 2
#done

echo "Starting MariaDB shell for setup..."
mysql -u root -p <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wordpress_user'@'%' IDENTIFIED BY 'abcdef';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;
EOF
#CREATE USER 'wordpress_user'@'%' IDENTIFIED WITH mysql_native_password BY 'abcdef'; #plugin for old authentication method compatible with wordpress

service mariadb stop

echo "Starting MariaDB service..."

exec mysqld_safe

