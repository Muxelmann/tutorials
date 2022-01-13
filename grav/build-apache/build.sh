#!/bin/zsh
docker build -t grav .

docker run \
    --rm \
    -it \
    --name grav \
    -p 8080:80 \
    -p 8443:443 \
    -v ${PWD}/log:/var/log/apache2 \
    -v ${PWD}/user:/var/www/html/user \
    grav $1
    # -e GRAV_VERSION=1.7.26.1 \
    # -e GRAV_ADMIN=YES \