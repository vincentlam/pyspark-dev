# pyspark-dev
Docker image for local development

## 0. Prerequisites
- docker
- vscode
- vscode extension - https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

## 1. Build
```
docker build -t pyspark .
```

## 2. Run
```
docker run --rm -d -v $(pwd):/home/host pyspark
```

## 3. Attach vscode to container
https://code.visualstudio.com/docs/remote/attach-container

## 4. Develop
open `/home/host` in vscode
