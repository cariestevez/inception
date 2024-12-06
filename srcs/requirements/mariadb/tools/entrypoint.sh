#!/bin/bash

# # Initialize the database if it doesn't exist
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     echo "Initializing database..."
#     mysqld --user=mysql --datadir=/var/lib/mysql --initialize
#     #mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
# fi

# Start MariaDB in the background
# --skip-networking disables TCP connections and restricts communication to the Unix socket (communication between processes in same container only)
echo "Starting MariaDB server in the background for setup..."
mysqld_safe --skip-networking &
sleep 5

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent; do
    echo "MariaDB is not ready yet. Waiting..."
    sleep 2
done

# Run mysql client to communicate with the server & set up the database
echo "Running mysql client for setting up the database..."
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Shut down the background MariaDB server instance
echo "Shutting down temporary MariaDB instance..."
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Start MariaDB in the foreground
echo "Restarting MariaDB in the foreground..."
exec mysqld_safe
