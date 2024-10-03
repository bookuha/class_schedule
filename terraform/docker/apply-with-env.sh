#!/bin/bash
# apply-with-env.sh

# Load variables from .env file
export $(grep -v '^#' .env | xargs)

# Run terraform apply with environment variables
terraform apply \
  -var="postgres_host=$POSTGRES_HOST" \
  -var="postgres_port=$POSTGRES_PORT" \
  -var="postgres_db=$POSTGRES_DB" \
  -var="postgres_user=$POSTGRES_USER" \
  -var="postgres_password=$POSTGRES_PASSWORD" \
  -var="mongo_database=$MONGO_DATABASE" \
  -var="mongo_default_server_cluster=$MONGO_DEFAULT_SERVER_CLUSTER" \
  -var="redis_host=$REDIS_HOST" \
  -var="redis_port=$REDIS_PORT" \
  -var="redis_external_port=$REDIS_EXTERNAL_PORT" \
  -var="frontend_api_url=$FRONTEND_API_URL"