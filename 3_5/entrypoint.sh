#!/bin/bash

# Select the command based on SPARK_MODE
if [ "$SPARK_MODE" == "master" ]; then
    /opt/spark/sbin/start-master.sh && tail -f /opt/spark/logs/*.out
elif [ "$SPARK_MODE" == "worker" ]; then
    /opt/spark/sbin/start-slave.sh ${SPARK_MASTER_URL} && tail -f /opt/spark/logs/*.out
elif [ "$SPARK_MODE" == "submit" ]; then
    echo "Spark submit mode is selected. Waiting for spark-submit command..."
    wait
else
    echo "Invalid SPARK_MODE: $SPARK_MODE"
    exit 1
fi
