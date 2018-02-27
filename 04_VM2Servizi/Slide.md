# Dalla Vm ai Servizi

## un modo per rimescolare le carte a nostro vantaggio

---

## Architettura a VM

![VM Datacenter](04_VM2Servizi/img/VMConsolidation.png)
<!-- .element height="100%" width="100%" -->

---

## Architettura a Container

![Container Datacenter](04_VM2Servizi/img/ContainerConsolidation.png)
<!-- .element height="100%" width="100%" -->

---

## Analisi di un _docker-compose.yml_

```yaml
version: '3'
services:
  db:
    image: mysql
    restart: always
    hostname: db
    domainname: develop.local
    container_name: db
    environment:
      MYSQL_ROOT_PASSWORD: secretadmin
    ports:
    - "3316:3306"
    volumes:
    - dbvolume01:/var/lib/mysql
  mail:
    image: tvial/docker-mailserver:latest
    restart: always
    hostname: mail
    domainname: develop.local
    container_name: mail
    ports:
    - "25:25"
    - "143:143"
    - "587:587"
    - "993:993"
    volumes:
    - maildata:/var/mail
    - mailstate:/var/mail-state
    - ./config:/tmp/docker-mailserver/
    - ./config/opendkim.conf:/etc/opendkim.conf
    environment:
    - ENABLE_SPAMASSASSIN=1
    - ENABLE_CLAMAV=1
    - ENABLE_FAIL2BAN=1
    - ENABLE_POSTGREY=1
    - ONE_DIR=1
    - DMS_DEBUG=1
    - ENABLE_SASLAUTHD=1
    - SASLAUTHD_MECHANISMS=rimap
    - SASLAUTHD_MECH_OPTIONS=127.0.0.1
    - SSL_TYPE=self-signed
    - PERMIT_DOCKER=172.18.0.0/16
    cap_add:
    - NET_ADMIN
    - SYS_PTRACE

volumes:
  dbvolume01: {}
  maildata:
    driver: local
  mailstate:
    driver: local
```

`From: ./04_VM2Servizi/code/01/dockerfile`
