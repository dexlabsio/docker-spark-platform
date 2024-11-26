FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk-headless wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

ENV SPARK_VERSION=3.5.3
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON=python3

# Download and install Spark
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Download and install Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.2/hadoop-3.3.2.tar.gz && \
    tar -xzf hadoop-3.3.2.tar.gz && \
    mv hadoop-3.3.2 /opt/hadoop && \
    rm hadoop-3.3.2.tar.gz

ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_CLASSPATH="$(hadoop classpath)"
ENV SPARK_DIST_CLASSPATH="$HADOOP_CLASSPATH:$SPARK_HOME/jars"

# Add necessary jars
RUN wget https://jdbc.postgresql.org/download/postgresql-42.6.0.jar -O $SPARK_HOME/jars/postgresql-42.6.0.jar
RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar -O $SPARK_HOME/jars/aws-java-sdk-bundle-1.11.1026.jar
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar -O $SPARK_HOME/jars/hadoop-aws-3.3.2.jar

WORKDIR $SPARK_HOME

EXPOSE 4040-4060
EXPOSE 6066-6076
EXPOSE 7001-7100
EXPOSE 7101-7200
EXPOSE 7301-7400
EXPOSE 8080-8090
EXPOSE 10000-10100
