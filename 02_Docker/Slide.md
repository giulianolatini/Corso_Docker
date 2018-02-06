# Docker

## un facilitatore per utilizzare i Container e le tecnologie ad essi collegate

---

>quoting quoting quoting quoting quoting quoting quoting quoting quoting
>quoting quoting quoting quoting quoting quoting quoting quoting quoting
>quoting quoting quoting quoting quoting quoting quoting quoting quoting
>quoting quoting quoting quoting quoting quoting quoting quoting quoting
>quoting quoting quoting quoting quoting quoting quoting quoting quoting

---

Prova Prova

Prova Prova

---

* test
* Test
* TEST

---

- Item 1
<!-- .element: class="fragment" data-fragment-index="2" -->
- Item 2
<!-- .element: class="fragment" data-fragment-index="1" -->

---

```yaml
version: '2'

services:
  web:
    image: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ${DOCKER_COMPOSE_HOME}/.conf/nginx/site.conf:/etc/nginx/conf.d/default.conf:ro
      - ${SITE_ROOT}:/var/www/html:rw
    links:
      - php

  php:
    build: ./php/
    volumes:
      - ${DOCKER_COMPOSE_HOME}/.conf/php-fpm/site.conf:/etc/php5/fpm/pool.d/site.conf:ro
      - ${SITE_ROOT}:/var/www/html:rw
    environment:
      XDEBUG_CONFIG: remote_host=${REMOTE_HOST}
```
<!-- .element: class="stretch" -->

---

```python
#!/usr/bin/env python27
import urllib2
import base64
import json
import os
import sys
import re

os.system("clear")
print "-" * 80
print "Command Line Search Tool"
print "-" * 80

def Banner(text):
    print "=" * 70
    print text
    print "=" * 70
    sys.stdout.flush()
```
<!-- .element: class="stretch" -->