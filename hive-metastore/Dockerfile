FROM postgres:14.13

# Set environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=postgres
ENV PGPORT=9083

# Create directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy the initialization script and Metastore setup scripts
COPY scripts/* /scripts/
COPY init-db.sh /docker-entrypoint-initdb.d/

# Make sure the script is executable
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
RUN chmod +x /scripts/*.sql

# Expose PostgreSQL port
EXPOSE 9083