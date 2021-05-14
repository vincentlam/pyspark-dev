FROM python:3.8-alpine

ARG SPARK_VERSION=3.1.1
ARG SPARK_BUILD=spark-3.1.1-bin-hadoop3.2
ARG HADOOP_BUILD=hadoop-3.2.2

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV HADOOP_HOME /opt/${HADOOP_BUILD}
ENV SPARK_HOME /opt/${SPARK_BUILD}

RUN apk update && apk upgrade && \ 
    apk add --no-cache --update bash git openjdk11 tar build-base gcc libffi-dev libzmq musl-dev python3-dev zeromq-dev 
RUN wget -O- https://apache.mirror.digitalpacific.com.au/spark/spark-${SPARK_VERSION}/${SPARK_BUILD}.tgz | tar zxf - -C /opt
RUN wget -O- https://apache.mirror.digitalpacific.com.au/hadoop/common/${HADOOP_BUILD}/${HADOOP_BUILD}.tar.gz | tar zxf - -C /opt

RUN pip install --no-cache-dir --upgrade pip setuptools wheel black jupyter pyspark pytest pre-commit && pip cache purge

RUN mkdir /opt/data

COPY jars/delta-core_2.12-0.8.0.jar /home/jars/delta-core_2.12-0.8.0.jar
COPY conf/spark-defaults.conf /opt/${SPARK_BUILD}/conf/spark-defaults.conf

ENTRYPOINT ["tail", "-f", "/dev/null"]
