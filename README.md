# Credhub-docker

Docker image for credhub (include a docker-compose file to run with uaa).

## Run without UAA

```bash
docker run -d -p 127.0.0.1:9000:9000 orangeopensource/credhub:latest
```

## Run with UAA

You will need a config file for UAA which can be found [here](/docker-compose/config/uaa.yml).

1. Start a UAA with Docker: `docker run -d --name uaa --mount type=bind,source=$PWD/docker-compose/config/uaa.yml,target=/uaa/uaa.yml -p 127.0.0.1:8080:8080 pcfseceng/uaa:latest`
2. Start credhub with docker with binding uaa: `docker run -d --link uaa -e UAA_URL=http://localhost:8080/uaa -e UAA_INTERNAL_URL=http://uaa:8080/uaa -p 127.0.0.1:9000:9000 pcfseceng/uaa:latest`

## Run docker-compose

Clone this repo and run `docker-compose up -d` inside folder [/docker-compose](/docker-compose).

## Use with credhub-cli

You can now connect to credhub with this command:

```bash
credhub-cli login -s https://localhost:9000 -u credhub -p password --skip-tls-validation
```
