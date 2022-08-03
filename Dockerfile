FROM openjdk:11-slim-buster

ARG SPARK_VERSION=3.2.2
ARG SPARK_BUILD=spark-3.2.2-bin-hadoop3.2

ENV HADOOP_HOME /opt/${SPARK_BUILD}
ENV SPARK_HOME /opt/${SPARK_BUILD}

RUN apt-get update && apt-get upgrade -y \
    && apt-get -y install git wget build-essential libssl-dev libffi-dev python3.7 python3-pip python3.7-dev python3-setuptools python3-wheel \
    && apt-get autoclean
RUN wget -O- https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_BUILD}.tgz | tar zxf - -C /opt
RUN python3 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir --upgrade setuptools wheel black jupyter pandas pyspark==3.2.2 delta-spark pytest-cov pre-commit pytz

COPY data /home/host/data
WORKDIR /home/host

ENTRYPOINT ["tail", "-f", "/dev/null"]
