FROM ubuntu:22.04

ARG install_admin=NO

LABEL maintainer "user@email.com"
LABEL description "Ein Test-Webserver"

ENV TZ="Europe/Berlin" \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_PID_FILE=/var/run/apache2/apache2.pid \
    APACHE_RUN_DIR=/var/run/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_LOG_DIR=/var/log/apache2 \
    GRAV_VERSION=latest \
    GRAV_ADMIN=$install_admin \
    HTML_DIR=/var/www/html \
    USER_DIR=/var/www/html/user

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
        apache2 \
        php8.1 \
        php8.1-curl \
        php8.1-gd \
        php8.1-mbstring \
        php8.1-xml \
        php8.1-zip \
        && \
    apt clean -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* && \
    rm -rf /etc/apache2/sites-available/* && \
    mv /tmp/apache2.conf /etc/apache2/ && \
    mv /tmp/default.conf /etc/apache2/sites-available/ && \
    a2dissite 000-default.conf && \
    a2ensite default && \
    a2enmod ssl rewrite && \
    rm -rf /var/www/html/* && \
    cd /tmp && ./install-grav.sh

VOLUME [ "/var/www/html/user", "/var/log/apache2" ]

EXPOSE 80 443

WORKDIR /tmp

ENTRYPOINT [ "/tmp/start.sh" ]

CMD [ "/bin/bash" ]
