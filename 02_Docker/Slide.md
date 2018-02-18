# Docker

## un facilitatore per utilizzare i Container e le tecnologie ad essi collegate

---

## Cosa è Docker

### Un facilitatore?

### Un hub di tecnologie?

### Un significato nuovo alla parola _Infrastruttura_ <br> e un modo nuovo per costruirla.

---

## Docker, gli inizi

![Graphics DevOps Origin](02_Docker/img/Docker-linux-dependencies.png)
<!-- .element height="50%" width="50%" -->

---

## Docker Oggi

![Graphics DevOps Origin](02_Docker/img/ContainerLifeCycle_and_Technologies.png)
<!-- .element height="100%" width="100%" -->

---

## L'immagine secondo Docker.inc

![Graphics DevOps Origin](02_Docker/img/Container_Meaning_from_Docker_Website.png)
<!-- .element height="100%" width="100%" -->

È un <b><i>artefatto</i></b>. Il <i style="color:DodgerBlue;">Container</i> è la sua rappresentazione operativa come il <span style="color:Tomato;">processo</span> lo è del <span style="color:MediumSeaGreen;">codice</span>.

---

## Il Container

<table>
  <tbody>
    <tr>
      <td style="center">
        <img src="02_Docker/img/WhatIsAContainer.png" 
             alter="Graphics DevOps Origin" 
             width="3600">
      </td>
      <td style="center; vertical-align: middle;">
        Il <i>Container</i> è un elemento isolato e autosufficiente, accessibile attraverso la rete. Esso astrae a livello applicativo le dipendenze necessarie al codice.
      </td>
    </tr>
  </tbody>
</table>

---

### Docker 101: Introduction to Docker 

<iframe 
  width="730" height="550" 
  src="https://www.youtube.com/embed/kwsJIH5TGIg?ecver=1;start=135;end=628;loop=1" 
  frameborder="0" 
  allow="autoplay; encrypted-media" 
  allowfullscreen>
</iframe>

---
## VM Consolidation

![Graphics DevOps Origin](02_Docker\img\VMConsolidation.png)
<!-- .element height="100%" width="100%" -->

---
## Container Consolidation

![Graphics DevOps Origin](02_Docker\img\ContainerConsolidation.png)
<!-- .element height="100%" width="100%" -->

---

## Creazione di un Container

```bash
bash-4.4$ docker run -it ubuntu bash
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
1be7f2b886e8: Pull complete
6fbc4a21b806: Pull complete
c71a6f8e1378: Pull complete
4be3072e5a37: Pull complete
06c6d2f59700: Pull complete
Digest: sha256:e27e9d7f7f28d67aa9e2d7540bdc2b33254b452ee8e60f388875e5b7d9b2b696
Status: Downloaded newer image for ubuntu:latest
root@66170252cf62:/#uname -a
Linux 66170252cf62 4.9.75-linuxkit-aufs #1 SMP Tue Jan 9 10:58:17 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
```

---

## Creazione di un'Immagine

```docker
FROM php:5.6-apache
# Install XDebug
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

# Install PHP exrensions.
RUN apt-get update \
    	&& apt-get install -y \
    		imagemagick \
    		graphicsmagick \
    		zip \
    		unzip \
    		wget \
    		curl \
    		git \
    		mysql-client \
    		moreutils \
    		dnsutils \
        && docker-php-ext-install -j$(nproc) mysqli \
    	&& rm -rf /var/lib/apt/lists/*
# Enable mod_rewrite.
RUN a2enmod deflate filter rewrite headers

# Enable mod_expires
RUN cp /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/

# Copy PHP configuration file template.
COPY php.ini /usr/local/etc/php
```

`From: ./02_Docker/code/01/dockerfile`

---

## Layers

![Container Layers](02_Docker/img/container-layer.png)
<!-- .element height="100%" width="100%" -->

---

## Cosa succede dopo un <i style="color:MediumSeaGreen;">docker run</i>

![Layers2Command Order](02_Docker/img/Layers_and_commands.png)
<!-- .element height="55%" width="55%" -->

---

## Layers condivisi

![Container Sharing Layers](02_Docker/img/sharing-layers.jpg)
<!-- .element height="80%" width="80%" -->

---

## Host-FileSystem condivisi

![Host Dirs Sharing](02_Docker/img/shared-volume.jpg)
<!-- .element height="80%" width="80%" -->

---

## Files Vision in OverlayFS

![OverlayFS Vision Order](02_Docker/img/overlay_constructs.jpg)
<!-- .element height="120%" width="120%" -->

---

## Glossario Docker base

- _Docker Engine_: deamon gestore dei elementi di un _Docker Host_

- _Docker Client_: CommandLine Interface per interagire con la _Docker Engine_ locale o remota

- _Docker Image_: readonly template generato da `docker build` da cui avviare uno o più Container

- _Docker Container_: artefatto attivo prodotto da `docker run` a partire da un'immagine

---

## Glossario Docker avanzato

- _Docker Host_: Sistema fisico o virtuale in cui viene eseguita la _Docker Engine_

- _Docker Registry_: Repository di immagini Pubblico [hub.docker.com](http://hub.docker.com) o Privato

- _Docker Compose_: Orchestrator di infrastrutture multicontainer organizzati in servizi

- _Docker Swarm_: Cluster multihost ad orchestrazione automatica

---

## Workflow comandi Docker 

![Container Layers](02_Docker/img/Docker_cli_command_and_workflow.png)
<!-- .element height="100%" width="100%" -->

---

## Principali Verbi Docker

- Build Image (Interpretazione del Dockerfile)

  ```bash
  docker build dockerID/imagename:tag .
  ```

- Run Container (creazione del Container da un'immagine)

  ```bash
  docker run -d dockerID/imagename:tag
  ```

- Pull Image (scarico di un'immagine)

  ```bash
  docker pull dockerID/imagename:tag
  ```

- Push Image (invio di un immagine al repository)

  ```bash
  docker push dockerID/imagename:tag
  ```
---

## Analisi di un Dockerfile

```docker
# vim:set ft=dockerfile:
FROM debian:jessie

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

# add gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -ex; \
	\
	fetchDeps=' \
		ca-certificates \
		wget \
	'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu nobody true; \
	\
	apt-get purge -y --auto-remove $fetchDeps

RUN mkdir /docker-entrypoint-initdb.d

# install "pwgen" for randomizing passwords
# install "apt-transport-https" for Percona''s repo (switched to https-only)
RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https ca-certificates \
		pwgen \
	&& rm -rf /var/lib/apt/lists/*

ENV GPG_KEYS \
# Key fingerprint = 1993 69E5 404B D5FC 7D2F  E43B CBCB 082A 1BB9 43DB
# MariaDB Package Signing Key <package-signing-key@mariadb.org>
	199369E5404BD5FC7D2FE43BCBCB082A1BB943DB \
# pub   1024D/CD2EFD2A 2009-12-15
#       Key fingerprint = 430B DF5C 56E7 C94E 848E  E60C 1C4C BDCD CD2E FD2A
# uid                  Percona MySQL Development Team <mysql-dev@percona.com>
# sub   2048g/2D607DAF 2009-12-15
	430BDF5C56E7C94E848EE60C1C4CBDCDCD2EFD2A \
# pub   4096R/8507EFA5 2016-06-30
#       Key fingerprint = 4D1B B29D 63D9 8E42 2B21  13B1 9334 A25F 8507 EFA5
# uid                  Percona MySQL Development Team (Packaging key) <mysql-dev@percona.com>
# sub   4096R/4CAC6D72 2016-06-30
	4D1BB29D63D98E422B2113B19334A25F8507EFA5
RUN set -ex; \
	export GNUPGHOME="$(mktemp -d)"; \
	for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done; \
	gpg --export $GPG_KEYS > /etc/apt/trusted.gpg.d/mariadb.gpg; \
	rm -r "$GNUPGHOME"; \
	apt-key list

# add Percona''s repo for xtrabackup (which is useful for Galera)
RUN echo "deb https://repo.percona.com/apt jessie main" > /etc/apt/sources.list.d/percona.list \
	&& { \
		echo 'Package: *'; \
		echo 'Pin: release o=Percona Development Team'; \
		echo 'Pin-Priority: 998'; \
	} > /etc/apt/preferences.d/percona

ENV MARIADB_MAJOR 10.3
ENV MARIADB_VERSION 10.3.4+maria~jessie

RUN echo "deb http://ftp.osuosl.org/pub/mariadb/repo/$MARIADB_MAJOR/debian jessie main" > /etc/apt/sources.list.d/mariadb.list \
	&& { \
		echo 'Package: *'; \
		echo 'Pin: release o=MariaDB'; \
		echo 'Pin-Priority: 999'; \
	} > /etc/apt/preferences.d/mariadb
# add repository pinning to make sure dependencies from this MariaDB repo are preferred over Debian dependencies
#  libmariadbclient18 : Depends: libmysqlclient18 (= 5.5.42+maria-1~wheezy) but 5.5.43-0+deb7u1 is to be installed

# the "/var/lib/mysql" stuff here is because the mysql-server postinst doesn''t have an explicit way to disable the mysql_install_db codepath besides having a database already "configured" (ie, stuff in /var/lib/mysql/mysql)
# also, we set debconf keys to make APT a little quieter
RUN { \
		echo "mariadb-server-$MARIADB_MAJOR" mysql-server/root_password password 'unused'; \
		echo "mariadb-server-$MARIADB_MAJOR" mysql-server/root_password_again password 'unused'; \
	} | debconf-set-selections \
	&& apt-get update \
	&& apt-get install -y \
		"mariadb-server=$MARIADB_VERSION" \
# percona-xtrabackup is installed at the same time so that `mysql-common` is only installed once from just mariadb repos
		percona-xtrabackup-24 \
		socat \
	&& rm -rf /var/lib/apt/lists/* \
# comment out any "user" entires in the MySQL config ("docker-entrypoint.sh" or "--user" will handle user switching)
	&& sed -ri 's/^user\s/#&/' /etc/mysql/my.cnf /etc/mysql/conf.d/* \
# purge and re-create /var/lib/mysql with appropriate ownership
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	&& chmod 777 /var/run/mysqld \
# comment out a few problematic configuration values
	&& find /etc/mysql/ -name '*.cnf' -print0 \
		| xargs -0 grep -lZE '^(bind-address|log)' \
		| xargs -rt -0 sed -Ei 's/^(bind-address|log)/#&/' \
# don''t reverse lookup hostnames, they are usually another container
	&& echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
```

`From: ./02_Docker/code/02/dockerfile`

---