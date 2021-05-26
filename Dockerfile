FROM openjdk:11-slim-buster

ARG SPARK_VERSION=3.1.1
ARG SPARK_BUILD=spark-3.1.1-bin-hadoop3.2
# ARG HADOOP_BUILD=hadoop-3.2.2

ENV HADOOP_HOME /opt/${SPARK_BUILD}
ENV SPARK_HOME /opt/${SPARK_BUILD}

RUN apt-get update && apt-get upgrade -y \
    && apt-get -y install git wget python3.7 python3-pip python3.7-dev python3-setuptools python3-wheel \
    && apt-get autoclean
RUN wget -O- https://apache.mirror.digitalpacific.com.au/spark/spark-${SPARK_VERSION}/${SPARK_BUILD}.tgz | tar zxf - -C /opt
# RUN wget -O- https://apache.mirror.digitalpacific.com.au/hadoop/common/${HADOOP_BUILD}/${HADOOP_BUILD}.tar.gz | tar zxf - -C /opt
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel black jupyter pandas pyspark delta-spark pytest-cov pre-commit pytz

COPY jars/delta-core_2.12-0.8.0.jar /home/jars/delta-core_2.12-0.8.0.jar
COPY conf/spark-defaults.conf /opt/${SPARK_BUILD}/conf/spark-defaults.conf
COPY data /home/data

ENTRYPOINT ["tail", "-f", "/dev/null"]
