#!/bin/sh

set -e

echo "run db migration"
# Debugging
ls -l /app/app.env  # Check if the file exists and its permissions
cat /app/app.env    # Print the content of app.env for debugging

source /app/app.env
/app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"

