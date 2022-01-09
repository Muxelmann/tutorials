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

## Docker Compose und Docker Stack

Die Befehle `docker compose` und `docker stack deploy` benutzen eine auf YAML-Syntax basierende Datei namens *docker-compose.yml*, um mehrere Container einzurichten. Diese Container werden im folgenden auch *Service* genannt (sie werden nämlich auch unter dem so benannten Schlüsselwort in der YAML-Datei definiert).

### Installation

Für die Installation (zur Zeit der Version 2.2.3) muss unter Linux die ausführbare Datei `docker-compose` heruntergeladen und in */usr/local/bin* gespeichert werden. Das geschieht wie folgt:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -m)-$(uname -a)" -o docker-compose
sudo chmod +x docker-compose
sudo mv docker-compose /usr/local/bin
```

Danach sollte der Befehl `docker-compose` ausführbar sein. MacOS und Windows stellen den Unterbefehl `docker compose` bereits mit der Installation von Docker zur Verfügung. Daher muss der die Datei `docker-compose` (mit Bindestrich) nicht mehr besorgt werden.

Der Unterbefehl `docker stack` sollte jedoch für jedes Betriebssystem bei Docker mitgeliefert werden, sodass - alternativ zu `docker compose` bzw. `docker-compose` - `docker stack deploy` ausgeführt werden kann.

### YAML

YAML steht für *YAML Ain't Markup Language* und umfasst folgende Regeln:

- `---` leitet einen neuen Abschnitt ein
- `#` beschreibt die Zeile als Kommentar
- `"hello, world"` und `'hello, world'` bilden Zeichenketten
- `-` beschreibt einen Ausdruck in einer Liste
- `[foo, bar, foobar]` ist eine Alternative zu `-` um eine Liste von Ausdrücken zu beschreiben
- `key: value` beschreibt eine assoziative Liste
- `{name: Max Mustermann, age: 30}` ist eine Alternative zur assoziativen Liste
- `|` ist ein Wert, der einen Textblock beschreibt, bei dem Zeilenumbrüche erhalten bleiben
- `>` ist ein Wert, der einen Textblock beschriebt, bei dem Zeilenumbrüche nicht (leere Zeilen aber schon) erhalten bleiben

Zusammengefasst könnte eine YAML Datei dann wie folgt aussehen:

```yaml
# Datei sample.yml
data:
  list:
    - item1
    - item2
  key1: >
    Dieser Text ist dem
    Schlüssel 'data.key1' zugeordnet.
  key2: |
    code line 1
    code line 2
```

### Die Datei *docker-compose.yml*

Die Datei umfasst mehrere Schlüsselwörter, die wie vorstehend beschrieben benutzt werden. Hierbei ist die Grundstruktur der Datei wie folgt:

```yaml
version: "3"

services:
  servicename1:
    key1: property1
    key2: property2
    ...
  servicename2:
    key1: property1
    key2: property2
    ...
```

Die Top-Level-Abschnitte *version* und *services* sind zwingend nötig um die Version der YAML-Datei und die Services zu definieren. Weitere Top-Level-Abschnitte wie *volumes*, *networks* oder *secrets* können dann bei Bedarf hinzugefügt werden. Diese sind häufig mit gleichnamigen Schlüsselworten innerhalb eines Services verbunden.

Das Schlüsselwort *image* gibt an, welches Basis-Image für einen Service benutzt werden soll; z.B. `image: ubuntu: 22.04`. Anstelle eines Images kann auch ein Pfad zu einem Verzeichnis angeben, in dem sich die Datei *Dockerfile* befindet. Der Befehl `docker compose` berücksichtigt dann die Angaben in dieser Datei, erstellt ein entsprechendes Image und verwendet dieses als Basis-Image für den Service. Ist die Datei *Dockerfile* im selben Ordner wie die YAML-Datei *docker-compose.yml* gespeichert, reicht an dieser Stelle ein einfacher Punkt `.`.

Standardmäßig sind alle Services dem selben Netzwerk zugewiesen. Man kann jedoch eigene und mehrere Netzwerke definieren, die dann den Services gezielt zugewiesen werden. In diesem Fall muss man die Netzwerke auch in dem Top-Level-Abschnitt *networks* angeben:

```yaml
...
services:
  web:
    ...
    networks:
      - my-test-network

networks:
  my-test-network:
    external:
      name: host
```
Das Schlüsselwort *ports* legt eine Liste von Netzwerkports fest und wie sie dem Host zur Verfügung gestellt werden. Hierbei ist wieder die Reihenfolge `hostport:serviceport`:

```yaml
...
ports:
  - "8080:80"
  - "8443:443"
```

Möchte man die Ports aber nur innerhalb des Netzwerks freigeben, das `docker compose` bzw. `docker stack deploy` für die Container bzw. die Services erstellt hat, benutzt man anstelle des Schlüsselworts *ports* das Schlüsselwort *expose*:

```yaml
expose:
  - "5500"
  - "5001"
```

Das Schlüsselwort *volumes* definiert eine Liste von Volumen, die von den Containern bzw. den Services benutzt werden. Hierbei kann man den Volumen Pfade zuweisen, unter denen sie auf dem Host gespeichert werden sollen. Für MairaDB, das die Datenbank unter */var/lib/mysql* speichert, ginge dies z.B. wie folgt:

```yaml
...
volumes:
  - /data/db:/var/lib/mysql
```

Der Pfad auf dem Host muss nicht zwingend als absoluter Pfad angegeben werden und darf auch relativ, also mit einem Punkt `.` beginnend, sein. In diesem Fall wir der Pfad relativ zur Datei *docker-compose.yml* ausgewertet. Will man vom Home-Verzeichnis ausgehen, benutzt man `~/` statt `./`.

In der Definition der Services können einem Volumen auch ein Name zugewiesen werden. Er muss dann auch unter dem Top-Level-Abschnitt *volumes* aufgeführt werden, benötigt aber keine weiteren Eigenschaften. Docker kümmert sich darum, die Volumen einzurichten und speichert es dann unter */var/lib/docker/volumes*.

```yaml
...
services:
  nginx:
    volumes:
      - webdata:/var/www/html
    ...
    
  db:
    volumes:
      - dbdata:/var/lib/mysql

volumes:
  webdata:
  dbdata:
```

Das Schlüsselwort *environment* erlaubt das Setzen verschiedener Umgebungsvariablen. Hierbei können entweder Werte als Key-Value-Pair übergeben werden, oder als Listenelemente in dem Format `var=wert`:

```yaml
...
environment:
  WORDPRESS_DB_HOST: mariadb
  WORDPRESS_DB_NAME: wb
```

```yaml
...
environment:
  - WORDPRESS_DB_HOST=mariadb
  - WORDPRESS_DB_NAME=wb
```

Beide Vorgehensweisen sind gleichwertig. Sollen mehrere Umgebungsvariablen gesetzt werden, funktioniert dies unter Angabe einer Datei, die die Umgebungsvariablen enthält; also mit `env_file: dateiname`.

Die Schlüsselworte *entrypoint* und *command* erlauben es, das Image eines Services mit vom Standard abweichenden Befehlen zu starten. Hierbei müssen die neuen Befehle als Liste oder wie vorstehend beschrieben in eckigen Klammern übergeben werden:

```yaml
...
entrypoint: ["new-script.sh"]
command: ["php", "-a"]
```

```yaml
...
entrypoint:
  - "new-script.sh"
command:
  - "php"
  - "-a"
```

Beide Vorgehensweisen sind gleichwertig.

Das Schlüsselwort *restart* kann bei `docker compose` bestimmt werden, ob die Container bei einem Computerstart oder einem Fehler automatisch neu gestartet werden sollen. Das Standardverhalten lautet `no`; andere sind `always`, `on-failure` oder `unless-stopped`. Oft wir hierbei das Neustartverhalten wie folgt gesetzt:

```yaml
...
restart: always
```

Das Schlüsselwort *deploy* steuert, wie Container bzw. Services durch `docker stack deploy` eingerichtet werden und gelten nur für den Schwarmmodus; sie werden von `docker compose` ignoriert. Hierfür muss mindestens YAML-Version 3.1 definiert werden:

```yaml
version: "3.1"

services:
  nginx:
    image: nginx:alpine
    
    # Dies wird nur im Schwarmmodus berücksichtigt
    deploy:
    
      # Gibt an, wo der Service ausgeführt wird
      placement:
        # Hier wird einfach der Hostname verglichen
        - node.hostname == "host-number-1"
      
      # Gibt an, wie viele Instanzen ausgeführt werden sollen
      replicas: 5
      
      # Gibt Beschränkungen der Ressourcen an
      resources:
        # Beschränkt die maximale CPU-Last und die Obergrenze der Speichernutzung
        limits:
          cpus:  "0.25"
          memory: 50M
          
      # Gibt an, wann und wie der Service neu gestartet werden soll
      restart_policy:
        # Hier kommen `any|on-failure|none` in Betracht
        condition: on-failure
        # Standardmäßig wir keine Verzögerung, also 0, eingestellt
        delay: 2s
        # Standardmäßig gibt es keine Obergrenze
        max_attempts: 3
```

### Beispiel für Compose

```yaml
# Die Versionsnummer muss für `docker stack deploy` angegeben werden
# und mindestens Nummer 3 betragen
version: "3"

# Definiert die Dienste oder Services die mit dieser YAML-Datei
# erzeugt werden
services:
  # Der Datenbank-Service nutzt wieder MariaDB und im
  # folgenden wird eine Datenbank für Wordpress
  # eingerichtet und mit einem Volume verbunden
  db:
    image: mariadb:latest
    volumes:
      - vol-db:/var/lib/mysql
    environment:
      MYSQL_RANDOM_ROOT_PASSWORD: 1
      MYSQL_DATABASE: wp
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: secret
    restart: always
    
  # Der Service zur Inhaltsverwaltung ist Wordpress und
  # wird mit dem Datenbank-Service und einem Volume verbunden
  wordpress:
    image: wordpress:latest
    volumes:
      - vol-www:/var/www/html/wp-content
    ports:
      - "8082:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_NAME: wp
      WORDPRESS_DB_PASSWORD: secret
    restart: always
    
# Die oben definierten Volume müssen am Ende noch einmal
# explizit aufgeführt werden, 
volumes:
  vol-www:
  vol-db:
```

Die Kommunikation zwischen den beiden Services wird durch die richtige Bezeichnung des Servicenamen und unter Angabe der entsprechenden Portnummer sichergestellt. In diesem Beispiel heißt der Datenbank-Service `db` und läuft hinter der standardmäßigen Portnummer 3306. Der Wordpress-Service nutzt dann Namen und Portnummer des Datenbank-Service als Wert des Schlüssels `WORDPRESS_DB_HOST`, der dann einfach `db:3306` ist.

Erzeugt und ausgeführt werden dann zwei Container mit dem folgenden Befehl:

```bash
docker compose up -d
```

Eine Statusabfrage mit `docker ps` zeigt dann folgende Ausgabe:

```
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS          PORTS                                   NAMES
f339775118b0   wordpress:latest   "docker-entrypoint.s…"   17 seconds ago   Up 17 seconds   0.0.0.0:8082->80/tcp, :::8082->80/tcp   compose-webserver-wordpress-1
7dd71b92fc2b   mariadb:latest     "docker-entrypoint.s…"   17 seconds ago   Up 17 seconds   3306/tcp                                compose-webserver-db-1
```

Und über den Browser sollte nun die Webseite aufgerufen werden können:

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/media/compose-website.png)

Angehalten, wieder gestartet und gelöscht werden die Container dann mit den entsprechenden für `docker compose` bzw. `docker-compose`:

```bash
# Zum Anhalten aller Container bzw. Service
docker compose stop
# Zum wieder Starten aller Container bzw. Services
docker compose start
# Zum löschen aller Container bzw. Services
docker compose rm

# Hiermit werden alle Container bzw. Services sowohl angehalten als auch gelöscht
docker compose down
```

Die erzeugten Volumen müssen gesondert aufgeräumt werden:

```bash
docker volume rm compose-webserver_vol-www compose-webserver_vol-db
```

### Beispiel für Stack

Um mit `docker stack` arbeiten zu können, muss ein *Swarm* erzeugt werden. Hierfür muss nicht zwangsläufig ein ganzer Computerverbund aufgesetzt werden, sondern der Swarm kann auch mit dem Befehl `docker swarm init` erzeugt werden. Der dadurch erzeugte Swarm umfasst aber nur einen Computer, was aber für die Nutzung von `docker stack` vollkommen ausreicht. Die Datei *docker-compose.yml* wird dann wie folgt benutzt:

```bash
docker stack deploy -c docker-compose.yml testwebserver
```

Die Option `-c` legt die YAML-Datei fest, die eingelesen werden soll und das letzte Argument definiert den Namen des Setups bzw. des Stacks. Als Ausgabe erscheint dann:

```
Creating network testwebserver_default
Creating service testwebserver_db
Creating service testwebserver_wordpress
```

Der Befehl `docker stack ls` beweist dann, dass der Stack mit zwei Services erstellt wurde. Die Services können dann mit `docker service ls` angezeigt werden. Wird in der Spalte *REPLICAS* angezeigt, dass kein Service gestartet wurde (also *0/1* o.ä.) kann die Fehlerursache mit `docker service ps <sid/stackname>` gesucht werden. Mit der Option `--no-trunc` wird dann eine ausführlichere Ausgabe wiedergegeben:

```
docker service ps testwebserver_db --no-trunc
docker service ps testwebserver_wordpress --no-trunc
```

Angehalten und gelöscht werden kann ein Stack dann wie folgt:

```bash
docker stack rm testwebserver
```

Die in *docker-compose.yml* angegebenen Volumen bleiben dabei erhalten, sodass der Stack auch später wieder ohne Datenverlust gestartet werden kann. Braucht man die Daten nicht mehr, können sie wie vorstehend besprochen mit `docker volume rm` gelöscht werden.

### Debugging mit Compose

Um die in der *docker-compose.yml* definierten Service nicht als Hintergrundprozesse auszuführen, kann man die Option `-d` einfach weglassen. Somit werden sämtliche Logging-Ausgaben aller Container angezeigt. Man kann dan mitverfolgen, was in den Containern ausgeführt wird.

Alternativ kann man sich eine Liste laufender Container mit `docker ps` anzeigen lassen und dann mit dem Befehl `docker logs <cname>` die Logging-Ausgaben anzeigen lassen. Der Befehl `docker compose logs` zeigt das kombinierte Log aller Container der Gruppe. Man kann dann auch - wie vorstehend beschrieben - einem Container der als Hintergrundprozess läuft interaktiv beitreten, und dort dann eine Shell starten - z.B.:

```bash
docker exec -it testwebserver_wordpress_1 /bin/sh
```

### Passwörter und andere Geheimnisse

Um Passwörter (wie in den vorstehenden Beispielen) nicht als Umgebungsvariable im Klartext übergeben zu müssen, stellt `docker compose` das Schlüsselwort *secrets* zur Verfügung. Dieses Schlüsselwort muss dann im Service selbst und im Top-Level-Abschnitt der Datei *docker-compose.yml* angegeben werden. Die Mindestversion von YAML beträgt hierbei wieder 3.1.

Im folgenden Beispiel wird in der Datei *my-secrets.txt* die Zeichenkette "*Dieser Text ist unglaublich geheim...*" gespeichert und das Folgende in der Datei *docker-compose.yml* definiert:

```yaml
version: "3.1"

services:
  test:
    image: alpine
    
    # Definiert ein Geheimnis namens `password1`
    secrets:
      - password1
    # Dieses Geheimnis wird in der gleichnamigen Datei in `/run/secrets` gespeichert
    command: ["cat", "-n", "/run/secrets/password1"]

# Zudem müssen die Geheimnisse mit Inhalt gefüllt werden
secrets:
  # Für `password1` wird der Inhalt der Datei `my-secrets.txt` benutzt
  password1:
    file: ./my-secrets.txt
```

Führt man nun den Befehl `docker compose up` (bzw. `docker-compose up`) aus, erhält man die folgende Ausgabe:

```
[+] Running 1/0
 ⠿ Container build-simple-secrets-test-1  Recreated                            0.0s
Attaching to build-simple-secrets-test-1
build-simple-secrets-test-1  |      1	Dieser Text ist unglaublich geheim...
build-simple-secrets-test-1 exited with code 0
```
