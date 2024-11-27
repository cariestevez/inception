#!/bin/bash

# Initialize the database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background
# --skip-networking disables TCP connections and restricts communication to the Unix socket (communication between processes in same container only)
echo "Starting MariaDB service in the background for setup..."
mysqld_safe --skip-networking &
sleep 5

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent; do
    echo "MariaDB is not ready yet. Waiting..."
    sleep 2
done

# Run SQL commands
echo "Running initial SQL setup..."
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wordpress_user'@'%' IDENTIFIED BY 'abcdef';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;
EOF

# Shut down the background MariaDB instance
echo "Shutting down temporary MariaDB instance..."
mysqladmin -u root -p123456 shutdown

# Start MariaDB in the foreground
echo "Restarting MariaDB in the foreground..."
exec mysqld_safe
