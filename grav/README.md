# Grav

Grav ist eine einfache dateibasierte Web-Plattform. Hierfür ist keine Installation erforderlich. Man muss einfach das ZIP-Archiv entpacken und Grav ist installiert. Obwohl Grav ähnlichen Prinzipien folgt wie andere Flat-File-CMS-Plattformen, hat es eine andere Design-Philosophie als die meisten.

Hier wird meine Entwicklungserfahrungen mit Grav festgehalten. Zudem versuche ich auch meine Kenntnisse mit Docker zu testen und verbessern, indem ich Grav-Images aus entsprechenden Projekten mit *Dockerfile* erstelle. Momentan ist der Entwicklungsstand wie folgt:

- [x] [Grav unter Ubuntu 22.04 mit Apache2 und PHP 8.1](https://github.com/Muxelmann/tutorials/tree/main/grav/build-apache)
- [x] [Grav unter Ubuntu 22.04 mit nginx und PHP 8.0](https://github.com/Muxelmann/tutorials/tree/main/grav/build-nginx)

Beide Versionen können nun vom Docker Hub heruntergeladen werden:

```bash
# Für die auf Apache basierende Version
docker push muxelmann/apache-grav

# Für die auf Nginx basierende Version
docker push muxelmann/nginx-grav
```

## Dokumentation

Die offizielle Dokumentation von Grav (v1.7) wird [hier](https://learn.getgrav.org/17) bereitgestellt.

Sobald Grav (Core oder Admin) installiert ist, kann man die Entwicklertools wie folgt installieren:

```bash
bin/gpm install devtools
```

Mit `gpm` kann dann z.B. ein neues Thema (bzw. *Theme*) oder Plugin erstellt werden:

```bash
# Zum Erstellen eines Themas
bin/plugin devtools new-theme

# Zum Erstellen eines Plugins
bin/plugin devtools new-plugin
```

Wie ein Thema / Plugin aufgebaut ist wird weiter unten erklärt.

## Mögliche Erweiterungen

Mein für meine Webseite [Gerfficient.com](https://gerfficient.com) entwickeltes Thema setzt (_noch_) voraus, dass einige Plugins installiert sind; diese sind unten aufgelistet und kurz beschrieben. Es ist mein Ziel, die Funktionalität der Plugins in meine selbst entwickelten Plugins (oder sogar in das Thema selbst) zu integrieren. Das dient hauptsächlich meinem Lernziel.

### [LangSwitcher](https://github.com/getgrav/grav-plugin-langswitcher)

LangSwitcher ist ein Grav-Plugin, mit dem zwischen verschiedenen Sprachen gewechselt werden kann. Man installiert es wie folgt:

```bash
bin/gpm install langswitcher
```

### [Pagination](https://github.com/getgrav/grav-plugin-pagination)

Pagination ist ein Grav-Plugin, das es ermöglicht, eine Liste von Beiträgen in einzelne Seiten zu unterteilen.

### [SimpleSearch](https://github.com/getgrav/grav-plugin-simplesearch)

SimpleSearch ist ein einfaches, aber sehr leistungsfähiges Grav-Plugin, das eine Suchfunktion hinzufügt. Standardmäßig kann es Seitentitel, Inhalte, Taxonomien und auch einen puren Header durchsuchen.

```bash
bin/gpm install simplesearch
```

Pagination ist ein Grav-Plugin, das es ermöglicht, eine Liste von Beiträgen in einzelne Seiten zu unterteilen.

## Allgemeiner Aufbau

[Quelle](https://learn.getgrav.org/17/content)

## Thema

[Quelle](https://learn.getgrav.org/17/themes)

## Plugin

[Quelle](https://learn.getgrav.org/17/plugins)
