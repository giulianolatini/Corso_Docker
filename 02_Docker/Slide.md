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

## Glossario Dockern avanzato

- _Docker Host_: Sistema fisico o virtuale in cui viene eseguita la _Docker Engine_

- _Docker Registry_: Repository di immagini Pubblico (http://hub.docker.com) o Privato

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

