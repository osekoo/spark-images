#!/bin/bash

# Select the command based on SPARK_MODE
if [ "$SPARK_MODE" == "master" ]; then
  /opt/spark/sbin/start-master.sh && tail -f /opt/spark/logs/*.out
elif [ "$SPARK_MODE" == "worker" ]; then
  /opt/spark/sbin/start-worker.sh ${SPARK_MASTER_URL} && tail -f /opt/spark/logs/*.out
elif [ "$SPARK_MODE" == "submit" ]; then
  echo "Spark submit mode is selected. Waiting for spark-submit command..."
  tail -f /dev/null
elif [ "$SPARK_MODE" == "env" ]; then
  echo "Starting spark cluster..."
  export SPARK_PUBLIC_DNS=localhost
  /opt/spark/sbin/start-master.sh
  /opt/spark/sbin/start-worker.sh spark://localhost:7077
  echo "Starting spark environment..."
  # check if spark-submit-job.sh exists
  if [ -f "/workspace/spark-submit-job.sh" ]; then
    dos2unix /workspace/spark-submit-job.sh
  fi
  echo ""
  echo "===================================================================="
  echo "Welcome to Spark environment!"
  spark-submit --version | head -n 1
  sbt --version | tail -n 1
  echo "  >> You can run your Spark job using 'spark-submit-job.sh' script."
  echo "  >> To monitor the Spark cluster, you can use the Spark Web UI at http://localhost:8080."
  echo "  >> To exit the environment, type 'exit'."
  echo "===================================================================="
  echo ""
  bash
else
  echo "Invalid SPARK_MODE: $SPARK_MODE"
  exit 1
fi
