# Docker

Um Docker zu installieren, folgt man am besten den Anweisungen auf der [Webseite](https://docs.docker.com/engine/install/) von Docker. Über das *convenience script* kann man Docker unter auf Linux basierenden Betriebssystemen über das Terminal installieren:

```bash
# Zuerst die installierten Pakete aktualisieren
sudo apt update
sudo apt upgrade

# Ggf. überflüssige oder veraltete Pakete löschen
sudo apt remove docker docker-engine docker.io containerd runc

# Dann den Skript herunterladen und ausführen
sudo apt install curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Im Nachfolgenden werden alle `docker` Befehle als *root* ausgeführt - der Wechsel hierzu geht im Terminal mittels `sudo -s`. Alternativ kann man auch ein `sudo` vor jeden `docker` Befehl schreiben, das wird hier jedoch der Überschaubarkeit halber ausgelassen. Zudem wird statt "*Docker-Container*" oder "*Docker-Images*" lediglich auf einen Container bzw. ein Image Bezug genommen, auch wenn es sich eigentlich um Docker-Container und Docker-Images handelt.

## Hello, World!

### Apache Server

Im Ordner *hello-world-php* liegen Dateien mit denen Docker einen auf Apache basierenden Webserver erstellen kann. Die Befehle zum Erstellen des Images und zum Ausführen desselben sind:

```bash
# Wechselt in den entsprechenden Ordner
cd hello-world-php

# Erzeugt ein neues Image mit dem Tag (-t) `hello-world-php`
docker build -t hello-world-php .

# Führt das erzeugte Image (letztes Argument) als Daemon (-d) unter dem Namen `hello-world-php` aus.
# Zudem wird der Port 8080 des Host mit dem Port 80 des Containers (also dem Server) verbunden.
docker run -d --name hello-world-php -p 8080:80 hello-world-php
```

Der Nun kann die Webseite aufgerufen werden!

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/hello-world-php/_screenshot.png)

Der Container wird wie folgt beendet, sodass der Port 8080 wieder freigegeben wird:

```bash
# Hält den Container, also den Server an
docker stop hello-world-php
# Löscht das erzeugte Image (optional)
docker rm hello-world-php
```

### Node.js

Im Ordner *hello-world-node* liegen Dateien mit denen Docker einen auf Node.js basierenden Webserver erstellen kann. Die Befehle zum Erstellen des Images und zum Ausführen desselben sind:

```bash
# Wechselt in den entsprechenden Ordner
cd hello-world-node

# Erzeugt ein neues Image mit dem Tag (-t) `hello-world-node`
docker build -t hello-world-node .

# Führt das erzeugte Image (letztes Argument) als Daemon (-d) unter dem Namen `hello-world-node` aus.
# Zudem wird der Port 8080 des Host mit dem Port 80 des Containers (also dem Server) verbunden.
docker run -d --name hello-world-node -p 8080:80 hello-world-node
```

Der Nun kann die Webseite aufgerufen werden!

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/hello-world-node/_screenshot.png)

Der Container wird wie folgt beendet, sodass der Port 8080 wieder freigegeben wird:

```bash
# Hält den Container, also den Server an
docker stop hello-world-node
# Löscht das erzeugte Image (optional)
docker rm hello-world-node
```

### Python

Im Ordner *hello-world-python* liegen Dateien mit denen Docker einen auf Python 3 basierenden Webserver erstellen kann. Die Befehle zum Erstellen des Images und zum Ausführen desselben sind:

```bash
# Wechselt in den entsprechenden Ordner
cd hello-world-python

# Erzeugt ein neues Image mit dem Tag (-t) `hello-world-python`
docker build -t hello-world-python .

# Führt das erzeugte Image (letztes Argument) als Daemon (-d) unter dem Namen `hello-world-python` aus.
# Zudem wird der Port 8080 des Host mit dem Port 80 des Containers (also dem Server) verbunden.
docker run -d --name hello-world-python -p 8080:80 hello-world-python
```

Der Nun kann die Webseite aufgerufen werden!

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/hello-world-python/_screenshot.png)

Der Container wird wie folgt beendet, sodass der Port 8080 wieder freigegeben wird:

```bash
# Hält den Container, also den Server an
docker stop hello-world-python
# Löscht das erzeugte Image (optional)
docker rm hello-world-python
```

## Docker Grundlagen

Die grundlegendsten Befehle für Docker lauten wie folgt:

```bash
# Zum Ausführen eines Images
docker run <image-name>

# Zum Anzeigen der Statusinformationen; -a zeigt alles an
docker ps -a

# Um einen laufenden Container anzuhalten
docker stop <container-name>

# Zum Aufräumen alter Container
docker rm <container-name>

# Um die neuste Version eines Images herunterzuladen
docker image pull <image-name>
```

### Ausführen

Um sich das spätere Aufräumen von in der Vergangenheit ausgeführten Containern zu sparen, kann man sie auch mit der Option `--rm` starten.

Um einen Container (z.B. zum Entwickeln) interaktiv in einer Konsole zu starten, übergibt man die Optionen `-i` und `-t` die als `-it` zusammengefasst werden können. Mit der Option `-i` wird der Container interaktiv ausgeführt und `-t` startet einen Pseudo-Terminalemulator (also Pseudo-TTY) der mit der Standardeingabe verbunden wird.

Beim Start eines Containers wird diesem eine zufällige UID zugewiesen. Einen benutzerdefinierten Namen kann man mit `--name` übergeben und einen Hostnamen mit `-h` zuweisen.

Um weitere Befehle an einen Container zu übermitteln, kann man `docker exec` benutzen. Z.B..

```bash
# Zum Auflisten aller aktiven Prozesse
docker exec -it my-ubuntu /usr/bin/top
```

oder

```bash
# Um eine weitere Bash-Session zu öffnen
docker exec -it my-ubuntu /bin/bash
```

Um einen Container im Hintergrund weiterlaufen zu lassen, kann man ihn mit der Option `-d` als Hintergrundprozess (*daemon*) starten.

Um mit Ports des Containers kommunizieren zu können, benutzt man die Option `-p`, wobei folgendes gilt:

```bash
docker run -d -p <host-port>:<docker-port> <image-name>
```

Umgebungsvariablen können mit der Option `-e` übergeben werden. Hierbei werden die Variablen wie folgt benannt:

```bash
docker run -e VARIABLENNAME=variablenwert <docker-image>
```

### Daten Speichern

In einem Container können Daten gespeichert werden, die aber gelöscht werden, sobald der Container gelöscht oder ein neues Image benutzt wird. Um dies zu vermeiden, kann man ein Volume benutzen, das nichts anderes als einen Pfad im Container ist. Dieses Volume wird dann standardmäßig unter `/var/docker/volumes` auf dem Host gespeichert; und zwar in dem Ordner mit der UID des Containers.

Will man dem Volume einen bestimmten Namen zuweisen, geschieht das mit der Option `-v`:

```bash
docker run -v <volume-name>:/var/www/html <image-name>
```

Das Volume wird jedoch weiter in `/var/docker/volumes` gespeichert, jedoch nicht mit jedem neuen Container überschrieben.

Will man jedoch einen anderen Pfad angeben, in dem der Ordner des Volume angelegt werden soll, kann man einen absoluten Pfad statt eines Namens übergeben. Wird z.B. im Container unter dem Pfad `/var/www/html` eine Webseite gespeichert, so kann dieser Pfad im *Dockerfile* (siehe unten) als Volume gekennzeichnet werden. Dann besteht auch die Möglichkeit mit der Option `-v` diesen Pfad auf dem Host als Volume Ordner bereitzustellen:

```bash
docker run -v /path/on/host/to/volume:/var/www/html <image-name>
```

Bei Fedora und RHEL muss zusätzlich die Flag `:z` übergeben werden, also:

```bash
docker run -v /path/on/host/to/volume:/var/www/html:z <image-name>
```

Dann kann man auch einen Container aktualisieren, ohne Datenverlust! Z.B.:

```bash
docker stop my-ubuntu
docker rm my-ubuntu
docker pull ubuntu
docker run -d --name my-ubuntu -v myhome:/home my-ubuntu
```

Volumes können mit dem Befehl `docker inspect` analysiert werden. Ist man nur an gewissen Einträgen der Analyse interessiert, kann man mit `-f` (*format*) die Ausgabe beschränken:

```bash
docker inspect -f '{{ .Mounts }}' my-image
```

Kennt man dann den Namen des Volume, kann man es so analysieren:

```bash
docker volume inspect <volume-id>
```

### Logging

Die Fehler- und Ereignisausgaben eines im Hintergrund laufenden Containers können wie folgt eingesehen werden:

```bash
docker logs <container-name>
```

### Kommunikation

Um mehrere Container miteinander kommunizieren zu lassen, muss ein Netzwerk erstellt werden:

```bash
docker network create my-test-network
```

Dann können mehrere Container diesem Netzwerk beitreten und miteinander Kommunizieren. So würde z.B. der Code zum Starten eines Webservers aussehen, der auf MariaDB, PHPmyAdmin und Wordpress aufbaut:

```bash
docker run \
  -d \
  --name mariadb-test \
  --network my-test-network \
  -e MYSQL_RANDOM_ROOT_PASSWORD=1 \
  -e MYSQL_DATABASE=wp \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=secret \
  -v maria-mysql:/var/lib/mysql \
  mariadb # ggf. arm64v8/mariadb

docker run \
  -d \
  --name phpmyadmin-test \
  --network my-test-network \
  -e PMA_HOST=mariadb-test \
  -p 8080:80 \
  phpmyadmin/phpmyadmin # ggf. arm64v8/phpmyadmin
  
docker run \
  -d \
  --name wordpress-test \
  --network my-test-network \
  -h wordpress-test \
  -e WORDPRESS_DB_HOST=mariadb-test \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_NAME=wp \
  -e WORDPRESS_DB_PASSWORD=secret \
  -v wp-content:/var/www/html/wb-content \
  -p 8081:80 \
  wordpress # ggf. arm64v8/wordpress
```

**Anmerkung** zu Apples M1-Chip und anderen Arm 64bit Platformen: Falls der Container nicht startet oder abstürzt, können folgende Images benutzt werden:

- `arm64v8/mariadb` für MariaDB,
- `arm64v8/phpmyadmin` für PHPmyAdmin, und
- `arm64v8/wordpress` für Wordpress.

Jedoch scheint in meinem Test nur das standardmäßig heruntergeladene PHPmyAdmin Image nicht zu funktionieren - MariaDB und Wordpress laufen einwandfrei.

Eine Abfrage über `docker ps` sollte dann folgendes Ergebnis ausgeben:

```
CONTAINER ID   IMAGE                COMMAND                  CREATED              STATUS              PORTS                                   NAMES
a13986fdfa63   mariadb              "docker-entrypoint.s…"   About a minute ago   Up 9 minutes        3306/tcp                                mariadb-test
1c6ca84d0274   wordpress            "docker-entrypoint.s…"   2 minutes ago        Up 3 minutes        0.0.0.0:8081->80/tcp, :::8081->80/tcp   wordpress-test
94357a819b6d   arm64v8/phpmyadmin   "/docker-entrypoint.…"   7 minutes ago        Up 7 minutes        0.0.0.0:8080->80/tcp, :::8080->80/tcp   phpmyadmin-test
```

Aktualisieren lassen sich die Container dann **ohne Datenverlust** wie folgt:

```bash
# Alte Container anhalten und löschen
docker stop mariadb-test phpmyadmin-test wordpress-test
docker rm mariadb-test phpmyadmin-test wordpress-test

# Images aktualisieren
docker pull mariadb               # ggf. arm64v8/mariadb
docker pull phpmyadmin/phpmyadmin # ggf. arm64v8/phpmyadmin
docker pull wordpress             # ggf. arm64v8/wordpress

# Container starten ohne die DB neu zu konfigurieren
docker run \
  -d \
  --name mariadb-test \
  --network my-test-network \
  -v maria-mysql:/var/lib/mysql \
  mariadb # ggf. arm64v8/mariadb

docker run \
  -d \
  --name phpmyadmin-test \
  --network my-test-network \
  -e PMA_HOST=mariadb-test \
  -p 8080:80 \
  phpmyadmin/phpmyadmin # ggf. arm64v8/phpmyadmin
  
docker run \
  -d \
  --name wordpress-test \
  --network my-test-network \
  -h wordpress-test \
  -e WORDPRESS_DB_HOST=mariadb-test \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_NAME=wp \
  -e WORDPRESS_DB_PASSWORD=secret \
  -v wp-content:/var/www/html/wb-content \
  -p 8081:80 \
  wordpress # ggf. arm64v8/wordpress
```

PHPmyAdmin und Wordpress können dann über einen Browser wie gewohnt aufgerufen werden:

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/media/test-network-pma.png)

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/media/test-network-wordpress.png)

### Aufräumen

Container können mit `docker stop` angehalten werden. Hierbei kann die ID oder der Name des Containers übergeben werden.

Mit `docker rm` können dann angehaltene Container gelöscht werden. Läuft der Container noch, so kann er mit `-f` (*force*) zwangsweise (beendet und) gelöscht werden.

Sind alle Container eines bestimmten Images beendet, so kann man auch das Image selbst löschen; und zwar mit `docker image rm`. Dann muss jedoch beim nächsten Mal das Image vollständig erneut heruntergeladen werden.

Ebenso kann man Volumen mit `docker volume rm` löschen. Hat man jedoch einen benutzerdefinierten Ordner einem Volume des Containers zugewiesen, so muss man diesen Ordner selber löschen (z.B. mit `rm -rf` unter Linux).

Will man nun die drei vorstehend gestarteten Container, deren Volumen und das dazugehörige Netzwerk aufräumen, sähe der Befehl hierfür wie folgt aus:

```bash
# Alte Container anhalten und löschen
docker stop mariadb-test phpmyadmin-test wordpress-test
docker rm mariadb-test phpmyadmin-test wordpress-test

# Die Volumen löschen
docker rm maria-mysql
docker rm wp-content

# Das Netzwerk löschen:
docker network rm my-test-network

# Die zu Grunde liegenden Images löschen
docker image rm mariadb wordpress phpmyadmin/phpmyadmin
# ggf. docker image rm arm64v8/mariadb arm64v8/wordpress arm64v8/phpmyadmin
```

Will man alle Container löschen so macht man dies wie folgt:

```bash
docker rm $(docker ps -aq)
```

Will man jedoch nur Container, die von einem bestimmten Image abhängig sind löschen, geschieht dies z.B. wie folgt:

```bash
docker rm $(docker ps -a -q -f ancestor=ubuntu)
```

Um alle verwaisten Volumes zu löschen gibt es den `prune` Befehl:

```bash
docker volume prune
```

Will man alle nicht verwendeten Container und deren Volume löschen, geht das mit dem folgenden Befehl:

```bash
docker system prune -a --volumes
```

### Verwaltung

Der Platzbedarf eines Images und Containers kann wie folgt eingesehen werden:

```bash
docker images
docker ps -a -s
```

wobei die Option `-s` den Platzbedarf der Container der zurückgegebene Tabelle hinzufügt.

Einen Überblick über Docker als solches gibt es mit dem folgenden Befehl:

```bash
docker system df
```

## Dockerfile

Die Datei *Dockerfile* ermöglicht es, benutzerdefinierte Images zu erstellen. Dafür enthält sie eine recht einfache Syntax mit im Nachstehenden erklärten Schlüsselworten, die die Konfiguration des Images ermöglichen. Ist das Dockerfile fertig, kann mit `docker build` daraus ein Image erstellt werden.

### `ADD` und `COPY`

...kopieren Dateien in das Dateisystem des Images. Das Schlüsselwort `ADD` akzeptiert zudem nicht nur eine Datei, sondern auch eine URL, ein Verzeichnis oder eine Archivdatei (die sogar entpackt im Image gespeichert wird).

###  `CMD` und `ENTRYPOINT`

...führen den angegebenen Befehl beim Start des Containers aus.

Wird mit `docker run` ein Befehl übergeben, ersetzt dieser den mit `CMD` angegebenen Befehl. Der übergebene Befehl wird dem von `ENTRYPOINT` hinzugefügt, sodass der von `ENTRYPOINT` angegebene Befehl immer beim Start des Containers ausgeführt wird.

Für die Schlüsselworte wird der absolute Dateiname des Befehls, sowie seine Parameter jeweils in doppelte Anführungszeichen gestellt und durch Kommata getrennte eckige Klammern übergeben; z.B.:

```
CMD ["/etc/start.sh", "param1", "param2"]
```

###  `ENV`

...setzt eine Umgebungsvariable.

###  `EXPOSE`

...gibt die aktiven Ports des Containers an.

###  `FROM`

...gibt das Image an, auf dem das mit `docker build` erzeugte Image beruht.

### `LABEL`

...legt eine Zeichenkette zum identifizieren des Images fest.

### `RUN`

...führt den angegebenen Befehl beim Erzeugen des Images aus. Hiermit werden in der Regel Befehle zur Installation von Paketen oder Abhängigkeiten übergeben. Mit der Option `-y` können oft störende Ja/Nein-Abfragen vermieden werden, wie z.B. bei `apt`:

```bash
RUN apt update && \
  apt upgrade -y && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*
```

Es ist speicherplatzeffizienter möglichst alle Befehle mit dem bedingten Und `&&` in einem Befehl für `RUN` zu kombinieren.

### `USER`

...gibt ein Benutzerkonto für `RUN`, `CMD` und `ENTRYPOINT` an.

### `VOLUME`

...gibt an, welche Verzeichnisse im Image ein Volume sind. Die Syntax ist ähnlich wie bei `CMD` oder `ENTRYPOINT`, nur dass hier alle absoluten Pfade aufgelistet werden, die als Volume zur Verfügung stehen sollen:

```
VOLUME ["/var/lib/mysql", "/var/log/mysql"]
```

Diesen Volumen können dann mit der Option `-v` wie vorstehend Beschrieben ein Name zugewiesen werden, oder sie können in einem gesonderten Ordner gespeichert werden.

### `WORKDIR`

...legt das Arbeitsverzeichnis für `RUN`, `CMD`, `COPY` usw. fest.

## Images erzeugen und testen

Mit dem Befehl `docker build` mit einem Dockerfile, wie es vorstehend beschrieben wurde, ein Image erzeugt. Mit der Option `-t` kann man dem Image auch einen Namen hinzufügen, wobei dieser wie folgt aufgebaut sein sollte:

```bash
docker build -t accountname/imagename
```

Baut man erzeugt man mehrere Versionen des Images, kann jeder Version auch ein Tag gegeben werden:

```bash
docker build -t accountname/imagename:tag
```

oder der Tag kann geändert werden:

```bash
docker tag accountname/imagename[:oldtag] accountname/imagename:newtag
```

Standardmäßig wird nämlich immer der letzten erzeugten Version der Tag `:latest` zugewiesen.

Testen kann man dann das erzeugte Image mit `docker run`, jedoch am Besten mit den Optionen `-it` zum Interagieren und mit `--rm` um nach dem Ausführen alles wieder zu löschen, sodass beim nächsten Ausführen keine Dateien des Vorgängers übrig bleiben. Da das Image immer neu erzeugt werden muss, bleiben alte Versionen zurück, die wie folgt gelöscht werden können:

```bash
docker rm $(docker ps -a -q -f ancestor=accountname/imagename)
docker rmi $(docker images accountname/imagename -f dangling=true -q)
```

Hierbei ist `docker rmi` die Kurzform für `docker image rm`.

### Einen einfachen Webserver erstellen

Als einfaches Projekt für Einsteiger, wird nun die Datei *Dockerfile* angelegt und der folgende Code hinein kopiert:

```Dockerfile
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
```

Neben der Datei *Dockerfile* legt man nun im selben Verzeichnis die Datei *index.php* an und schreibt folgenden Code hinein:

```html
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test-Webserver</title>
</head>
<body>
    <h1>Hallo, Welt!</h1>
    <p>Dieser Webserver wurde mit einem <em>Dockerfile</em> erstellt.</p>
</body>
</html>
```

Das auf Ubuntu 22.04 basierende Image kann dann mit dem folgenden Befehl erstellt werden:

```bash
docker build -t user/testwebserer . 
```

Und mit dem folgenden Befehl getestet werden:

```bash
docker run -d -p 8080:80 -p 8443:443 --name testwebserver user/testwebserver
```

Danach sollte die URL `http://localhost:8080/` aufgerufen werden können, sowie die URL `https://localhost:8443/` bei der die Verbindung mit einem selbst signierten SSL-Zertifikat verschlüsselt wird (ggf. muss dieses Zertifikat vom Browser akzeptiert werden):

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/media/test-webserver.png)

Mit den vorstehend besprochenen Befehlen `docker stop`, `docker start` und `docker rm` kann dann der erzeugte Container angehalten, wieder gestartet und gelöscht werden. Beim Ausführen kann auch mit der Option `-v` der Webordner unter */var/www/html* sowie der Logordner unter `*/var/log/apache2* einem Volumen zugewiesen werden und von außerhalb des Containers verwaltet werden.