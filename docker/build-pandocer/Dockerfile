FROM ubuntu:22.04

LABEL maintainer "user@email.com"
LABEL description "Eine Umgebung um Markdown in PDF zu konvertieren"

ADD src.tgz /

ENV TZ="Europe/Berlin"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    chmod +x /src/pandocer && \
    mv /src/pandocer /usr/local/bin && \
    apt update && \
    apt install -y \
        pandoc \
        pandoc-citeproc \
        texlive-full && \
    apt clean -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists/*

WORKDIR /data

VOLUME [ "/data" ]

ENTRYPOINT ["/bin/bash"]