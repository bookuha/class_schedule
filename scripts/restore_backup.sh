#!/bin/bash
set -e

export PGPASSWORD=$DB_PASSWORD

until pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

psql -h $DB_HOST -p $DB_PORT -U $DB_USER -tc "SELECT 1 FROM pg_database WHERE datname = 'classschedule'" | grep -q 1 || \
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "CREATE DATABASE classschedule;"

if [ -f "/backup/backup.dump" ]; then
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d classschedule -f "/backup/backup.dump"
    echo "Database restored from backup."
else
    echo "Backup file not found. Restore failed."
fi