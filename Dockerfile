FROM debian:13-slim AS gradle

RUN apt-get update; \
	apt-get install -y build-essential git sudo default-jre default-jdk

COPY HMCL_offline /data
WORKDIR /data
RUN ./gradlew

FROM alpine:3.20 AS flatpak

RUN apk add \
    --no-cache \
        flatpak flatpak-builder \
        appstream-compose \
        git git-lfs \
        curl wget sudo \
        xz bc \
        flex bash man-db \
        man-pages file shadow \
        gawk diffutils findutils

RUN git config \
    --global \
    --add protocol.file.allow always

RUN flatpak remote-add \
    --if-not-exists \
        flathub https://flathub.org/repo/flathub.flatpakrepo

COPY --chmod=755 --from=gradle /data/HMCL/build/libs/HMCL*.jar /usr/local/bin/HMCL.jar
