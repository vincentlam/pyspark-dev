# pyspark-dev
Docker image for local development

## 0. Prerequisites
- docker
- vscode
- vscode extension - https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

## 1. Build
```
docker build --progress=plain -t pyspark .
```

## 2. Run
```
docker run --rm -d pyspark
```

## 3. Attach vscode to container
https://code.visualstudio.com/docs/remote/attach-container

## 4. Develop
open `/home/host` in vscode

## 5. Create Spark Session
```python
import pyspark
from delta import *

builder = pyspark.sql.SparkSession.builder.appName("MyApp") \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")

spark = configure_spark_with_delta_pip(builder).getOrCreate()
```