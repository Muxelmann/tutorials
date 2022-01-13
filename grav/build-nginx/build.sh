#!/bin/zsh
tag=muxelmann/nginx-grav
docker build -t $tag .
docker push $tag

# docker run \
#     --rm \
#     -it \
#     --name grav \
#     -p 8080:80 \
#     -p 8443:443 \
#     -v ${PWD}/log:/var/log/nginx \
#     -v ${PWD}/user:/var/www/html/user \
#     $tag $1