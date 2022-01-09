FROM ubuntu:22.04

LABEL maintainer "user@email.com"
LABEL description "Ein Test-Webserver"

# ENV-Befehl: Alle Umgebungsvariablen setzen
ENV TZ="Europe/Berlin" \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2

# RUN-Befehl: Zeitzone einstellen, Apache installieren,
# apt-Cache leeren, HTTPS aktivieren
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt update && \
    apt install -y apache2 && \
    apt clean -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* && \
    a2ensite default-ssl && \
    a2enmod ssl && \
    rm -rf /var/www/html/*

# EXPOSE-Befehl: Ports 80 und 443 freigeben
EXPOSE 80 443

# ADD-Befehl: Kopiert die Index-Datei des
# Webseitenordners in /var/www/html
COPY index.php /var/www/html

# CMD-Befehl: Definiert das Startkommando
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]