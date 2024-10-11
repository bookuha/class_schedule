#!/bin/bash
set -e

export PGPASSWORD=$DB_PASSWORD

until pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

if [ -f "/backup/backup.dump" ]; then
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f "/backup/backup.dump"
    echo "Database restored from backup."
else
    echo "Backup file not found. Restore failed."
fi