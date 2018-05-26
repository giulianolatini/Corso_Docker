# Gestione di Sistemi

## esempio di un'infrastruttura Wordpress organizzata a servizi

### definizione formale implementata con Docker

---

## Wordpress in Docker
### Schema generale

![Wordpress in Docker](06_GestioneSistemi/img/wordpress-docker.png)
<!-- .element height="50%" width="50%" -->

---

### Schema generale (Docker-compose.yml)

```yaml
version: '2'
services:
  wordpress:
      image: wordpress
      links:
          - mysql
      environment:
          - WORDPRESS_DB_PASSWORD=secretp@ssword
          - VIRTUAL_HOST=example.com
      expose:
          - 80
  mysql:
      image: mysql:5.7
      environment:
          - MYSQL_ROOT_PASSWORD=secretp@ssword
          - MYSQL_DATABASE=wordpress
```

```shell
From: ./06_GestioneSistemi/code/01/docker-compose.yml
```

---

### Schema implementativo

![Wordpress in Docker Implementazione](06_GestioneSistemi/img/architecture-generic.png)
<!-- .element height="50%" width="50%" -->

---

### Schema implementativo (docker-compose.yml)

```yaml
version: '3'
services:
    web:
        image: nginx:alpine
        volumes:
            - "./etc/nginx/default.conf:/etc/nginx/conf.d/default.conf"
            - "./etc/ssl:/etc/ssl"
            - "./web:/var/www/html"
            - "./etc/nginx/default.template.conf:/etc/nginx/conf.d/default.template"
        ports:
            - "8000:80"
            - "3000:443"
        environment:
            - NGINX_HOST=${NGINX_HOST}
        command: /bin/sh -c "envsubst '$$NGINX_HOST' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
        restart: always
        depends_on:
            - php
            - mysqldb
    php:
        image: nanoninja/php-fpm:${PHP_VERSION}
        restart: always
        volumes:
            - "./etc/php/php.ini:/usr/local/etc/php/conf.d/php.ini"
            - "./web:/var/www/html"
    composer:
        image: "composer"
        volumes:
            - "./web/app:/app"
        command: install
    myadmin:
        image: phpmyadmin/phpmyadmin
        container_name: phpmyadmin
        ports:
            - "8080:80"
        environment:
            - PMA_ARBITRARY=1
            - PMA_HOST=${MYSQL_HOST}
        restart: always
        depends_on:
            - mysqldb
    mysqldb:
        image: mysql
        container_name: ${MYSQL_HOST}
        restart: always
        env_file:
            - ".env"
        environment:
            - MYSQL_DATABASE=${MYSQL_DATABASE}
            - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
            - MYSQL_USER=${MYSQL_USER}
            - MYSQL_PASSWORD=${MYSQL_PASSWORD}
        ports:
            - "8989:3306"
        volumes:
            - "./data/db/mysql:/var/lib/mysql"
```

```shell
From: ./06_GestioneSistemi/code/02/docker-compose.yml
```

---

### Architettura Scalabile in Dinamico

![Wordpress in Docker con Kubernetes](06_GestioneSistemi/img/arch-wordpress-kube.jpg)
<!-- .element height="100%" width="100%" -->

---

### Pattern Architetturale multidbms

![Wordpress in Docker multidbms](06_GestioneSistemi/img/2015-9-25DockerNginxWordPressTopology.jpg)
<!-- .element height="60%" width="60%" -->

---

### Pattern Architetturale monodbms

![Wordpress in Docker monodbms](06_GestioneSistemi/img/2015-10-21DockerNginxWordPressProxyTopology.jpg)
<!-- .element height="60%" width="60%" -->

---

![Container Layers](img/Questions_Answers.jpg)
<!-- .element height="100%" width="100%" -->