#!/bin/bash
set -e

# Create user and database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER spark WITH PASSWORD 'spark';
    CREATE DATABASE metastore;
    GRANT ALL PRIVILEGES ON DATABASE metastore TO spark;
    \c metastore
    ALTER SCHEMA public OWNER TO spark;
EOSQL

# Run Hive schema script as spark user
psql -v ON_ERROR_STOP=1 --username "spark" --dbname "metastore" -f /scripts/hive-schema-2.3.0.postgres.sql