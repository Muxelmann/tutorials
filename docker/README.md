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

Im Nachfolgenden werden alle `docker` Befelhe als *root* ausgeführt - der Wechsel hierzu geht im Terminal mittels `sudo -s`. Alternativ kann man auch ein `sudo` vor jeden `docker` Befehl schreiben, das wird hier jedoch der Überschaubarkeit halber ausgelassen.

## Hello, World!

### Apache Server

Im Ordner *hello-world-php* liegen Dateien mit denen Docker einen auf Apache basierenden Webserver erstellen kann. Die Befehle zum Erstellen des Docker-Images und zum Ausführen desselben sind:

```bash
# Wechselt in den entsprechenden Ordner
cd hello-world-php

# Erzeugt ein neues Docker-Image mit dem Tag (-t) `hello-world-php`
docker build -t hello-world-php .

# Führt das erzeugte Docker-Image (letztes Argument) als Dämon (-d) unter dem Namen `hello-world-php` aus.
# Zudem wird der Port 8080 des Host mit dem Port 80 des Docker-Containers (also dem Server) verbunden.
docker run -d --name hello-world-php -p 8080:80 hello-world-php
```

Der Nun kann die Webseite aufgerufen werden!

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/hello-world-php/_screenshot.png)

Der Docker-Container wird wie folgt beendet, sodass der Port 8080 wieder freigegeben wird:

```bash
# Hält den Docker-Container, also den Server an
docker stop hello-world-php
# Löscht das erzeugte Docker-Image (optional)
docker rm hello-world-php
```

### Node.js

Im Ordner *hello-world-node* liegen Dateien mit denen Docker einen auf Node.js basierenden Webserver erstellen kann. Die Befehle zum Erstellen des Docker-Images und zum Ausführen desselben sind:

```bash
# Wechselt in den entsprechenden Ordner
cd hello-world-node

# Erzeugt ein neues Docker-Image mit dem Tag (-t) `hello-world-node`
docker build -t hello-world-node .

# Führt das erzeugte Docker-Image (letztes Argument) als Dämon (-d) unter dem Namen `hello-world-node` aus.
# Zudem wird der Port 8080 des Host mit dem Port 80 des Docker-Containers (also dem Server) verbunden.
docker run -d --name hello-world-node -p 8080:80 hello-world-node
```

Der Nun kann die Webseite aufgerufen werden!

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/hello-world-node/_screenshot.png)

Der Docker-Container wird wie folgt beendet, sodass der Port 8080 wieder freigegeben wird:

```bash
# Hält den Docker-Container, also den Server an
docker stop hello-world-node
# Löscht das erzeugte Docker-Image (optional)
docker rm hello-world-node
```

### Python

Im Ordner *hello-world-python* liegen Dateien mit denen Docker einen auf Python 3 basierenden Webserver erstellen kann. Die Befehle zum Erstellen des Docker-Images und zum Ausführen desselben sind:

```bash
# Wechselt in den entsprechenden Ordner
cd hello-world-python

# Erzeugt ein neues Docker-Image mit dem Tag (-t) `hello-world-python`
docker build -t hello-world-python .

# Führt das erzeugte Docker-Image (letztes Argument) als Dämon (-d) unter dem Namen `hello-world-python` aus.
# Zudem wird der Port 8080 des Host mit dem Port 80 des Docker-Containers (also dem Server) verbunden.
docker run -d --name hello-world-python -p 8080:80 hello-world-python
```

Der Nun kann die Webseite aufgerufen werden!

![A screenshot of the Browser](https://github.com/Muxelmann/tutorials/raw/main/docker/hello-world-python/_screenshot.png)

Der Docker-Container wird wie folgt beendet, sodass der Port 8080 wieder freigegeben wird:

```bash
# Hält den Docker-Container, also den Server an
docker stop hello-world-python
# Löscht das erzeugte Docker-Image (optional)
docker rm hello-world-python
```
