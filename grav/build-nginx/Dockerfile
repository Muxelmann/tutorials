FROM ubuntu:22.04

ARG install_admin=YES

LABEL maintainer "user@email.com"
LABEL description "Ein Test-Webserver"

ENV TZ="Europe/Berlin" \
    NGINX_RUN_USER=www-data \
    NGINX_RUN_GROUP=www-data \
    NGINX_LOG_DIR=/var/log/nginx \
    HTML_DIR=/var/www/html \
    USER_DIR=/var/www/html/user \
    GRAV_VERSION=latest \
    GRAV_ADMIN=$install_admin

ADD src/* /tmp

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    chmod +x /tmp/*.sh && \
    apt update && \
    apt install -y \
        nano \
        unzip \
        wget \
        curl \
        nginx \
        php-fpm \
        php8.0-curl \
        php8.0-gd \
        php8.0-mbstring \
        php8.0-xml \
        php8.0-zip && \
    apt clean -y && \
    mv /tmp/default /etc/nginx/sites-available/ && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* && \
    rm -rf $HTML_DIR/* && \
    cd /tmp && ./install-grav.sh


VOLUME [ "/var/www/html/user", "/var/log/nginx" ]

EXPOSE 80 443

WORKDIR /tmp

ENTRYPOINT [ "/tmp/start.sh" ]

CMD [ "/bin/bash" ]