#!/bin/bash

# Start Zookeeper
/opt/zookeeper/bin/zkServer.sh --config /opt/zookeeper/conf start-foreground &

# Wait for Kafka to be ready
echo "Waiting for Zookeeper to be ready..."
while ! nc -z localhost 2181; do
  echo "Zookeeper is not ready yet. Retrying..."
  sleep 1
done

# Format Kafka storage
/opt/kafka/bin/kafka-storage.sh format \
  --config /opt/kafka/config/server.properties \
  --cluster-id "$(/opt/kafka/bin/kafka-storage.sh random-uuid)"

# Start Kafka in KRaft mode
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &

# Wait for Kafka to be ready
echo "Waiting for Kafka to be ready..."
while ! nc -z localhost 9092; do
  echo "Kafka is not ready yet. Retrying..."
  sleep 1
done

echo "Kafka is ready. Starting Kafdrop."

# Start Kafdrop in daemon mode to monitor Kafka
java -jar /opt/kafdrop.jar --kafka.brokerConnect=localhost:9092 --server.port=9000
