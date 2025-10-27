#!/bin/bash

echo "Starting superset-init.sh"

# Ensure database is initialized first
echo "Initializing database..."
superset db upgrade

# Setup roles and permissions
echo "Initializing roles and permissions..."
superset init

echo "Configuring database connection..."
superset set_database_uri --database_name my_postgres --uri "$SQLALCHEMY_DATABASE_URI"

# Create Admin user, you can read these values from env or anywhere else possible
echo "Creating admin user..."
superset fab create-admin --username "$ADMIN_USERNAME" --firstname Superset --lastname Admin --email "$ADMIN_EMAIL" --password "$ADMIN_PASSWORD" || true


# Starting server
echo "Starting Superset server..."
/bin/sh -c /usr/bin/run-server.sh