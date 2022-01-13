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

## Mögliche Erweiterungen

### [LangSwitcher](https://github.com/getgrav/grav-plugin-langswitcher)

LangSwitcher ist ein Grav-Plugin, das muttersprachliche Textlinks zum Umschalten zwischen mehreren Sprachen in Grav (0.9.30 oder höher) bereitstellt.

### [Pagination](https://github.com/getgrav/grav-plugin-pagination)

Pagination ist ein Grav-Plugin, das es ermöglicht, eine Liste von Beiträgen in einzelne Seiten zu unterteilen.