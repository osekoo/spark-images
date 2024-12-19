FROM docker.io/ubuntu:22.04

# Define environment variables
ENV SPARK_VERSION=3.5.3 \
    SPARK_MODE="master" \
    SPARK_MASTER_URL="spark://spark-master:7077"

# Update and install required packages
RUN apt-get update && \
    apt-get -y install sudo dos2unix wget curl openjdk-8-jdk && \
    apt-get clean

# Download and install Apache Spark
RUN wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar xvf spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Set environment variables for Spark
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Expose Spark-related ports
EXPOSE 8080 8081 4040 6066 7077

# Define the entrypoint script
COPY entrypoint.sh /opt/entrypoint.sh
RUN dos2unix /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
