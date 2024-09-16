#!/bin/bash

# Exit on errors
set -e

# Substitute environment variables in the init.sql file
envsubst < /etc/mysql/template_init.sql > /etc/mysql/init.sql

exec "$@"
