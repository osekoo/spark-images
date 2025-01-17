# Étape 1 : Base Image pour Kafka
FROM docker.io/ubuntu:22.04

USER root

# Update and install required packages
RUN apt-get update && \
    apt-get -y install sudo &&  \
    apt-get -y install dos2unix wget curl &&  \
    apt-get -y install openjdk-17-jdk  && \
    apt-get -y install gnupg software-properties-common && \
    apt-get -y install netcat && \
    apt-get clean

# Install Zookeeper
ENV ZOOKEEPER_VERSION=3.9.3
ENV ZOOKEEPER_HOME=/opt/zookeeper
ENV PATH=$ZOOKEEPER_HOME/bin:$PATH

RUN apt-get update && apt-get install -y curl && apt-get clean && \
    curl -sL https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz | tar -xz -C /opt && \
    mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin $ZOOKEEPER_HOME && \
    mkdir -p $ZOOKEEPER_HOME/data && \
    mkdir -p $ZOOKEEPER_HOME/logs

COPY zookeeper.properties $ZOOKEEPER_HOME/conf/zoo.cfg

# Download and install Apache Kafka
ENV KAFKA_VERSION=2.4.0
RUN curl -sL https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz | tar -xz -C /opt && \
    ln -s /opt/kafka_2.13-${KAFKA_VERSION} /opt/kafka

# Download and install Kafdrop
ENV KAFDROP_VERSION=4.1.0
RUN curl -L https://github.com/obsidiandynamics/kafdrop/releases/download/${KAFDROP_VERSION}/kafdrop-${KAFDROP_VERSION}.jar -o /opt/kafdrop.jar

# Add a script to start Kafka and Kafdrop
COPY start.sh /opt/kafka/bin/start.sh
RUN chmod +x /opt/kafka/bin/start.sh

# Add Kafka properties
COPY server.properties /opt/kafka/config/server.properties

# Create a folder for Kafka logs
RUN mkdir -p /var/lib/kafka/data
RUN chown root:root -R /var/lib/kafka/data

# Set the working directory
WORKDIR /opt/kafka

# Expose the necessary ports
EXPOSE 9092 9093 9000 2181

# Définir le point d'entrée
CMD ["bin/start.sh"]
