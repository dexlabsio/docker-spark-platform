#!/bin/bash

# Create and set permissions for Spark events directory
mkdir -p /tmp/spark-events
chmod 777 /tmp/spark-events

# Start Spark master
start-master.sh

# Wait for master to be ready
sleep 5

# Start Spark worker
start-worker.sh spark://$(hostname):7077

# Wait for worker to be ready
sleep 5

# Start Thrift server
start-thriftserver.sh --master spark://$(hostname):7077

# Keep container running and display logs
tail -f /opt/spark/logs/*