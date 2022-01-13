#!/bin/zsh
docker build -t grav .

docker run \
    --rm \
    -it \
    --name grav \
    -p 8080:80 \
    -v ${PWD}/log:/var/log/nginx \
    -v ${PWD}/user:/var/www/html/user \
    grav $1