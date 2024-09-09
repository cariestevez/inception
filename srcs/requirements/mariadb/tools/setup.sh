#!/bin/bash
# setup.sh

# Variables for database setup
DB_NAME=${MYSQL_DATABASE:-thedatabase}
DB_USER=${MYSQL_USER:-theuser}
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Start MariaDB service
service mariadb start

# Execute SQL commands
mariadb -u root -p"$DB_ROOT_PASSWORD" -e "
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"

# Stop MariaDB service
service mariadb stop

echo "MariaDB setup complete!"

