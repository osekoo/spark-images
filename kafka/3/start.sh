#!/bin/bash

# Start Kafka in KRaft mode
/opt/kafka/bin/kafka-storage.sh format \
  --config /opt/kafka/config/server.properties \
  --cluster-id $(/opt/kafka/bin/kafka-storage.sh random-uuid)

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &

# Attendre que Kafka démarre
echo "Waiting for Kafka to be ready..."
while ! nc -z localhost 9092; do
  echo "Kafka is not ready yet. Retrying..."
  sleep 1
done

echo "Kafka is ready. Starting Kafdrop."

# Démarrer Kafdrop
java -jar /opt/kafdrop.jar --kafka.brokerConnect=localhost:9092 --server.port=9000
