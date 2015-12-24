# httpd-php
Base docker configuration image for httpd + php

# Synopsis
Root image definition [Dockerfile](Dockerfile) provides composer and other
packages commonly required by other extensions.  Change [Dockerfile](Dockerfile)
to apply dependency for down stream images.

- [Dockerfile.mongodb](Dockerfile.require_mongodb) builds and install
  (https://packagist.org/packages/mongodb/mongodb) extension driver, and set
build triggers for app.

# Usage
- The structure of your project

```
app-root/
    composer.json
    php.ini
    Dockerfile
    src/
        <your application code here>
```

- Choose a base image for your project.  Base image
  [magvlab/php](https://hub.docker.com/r/magvlab/php/) should be
  treated as a global configuration root and should not be your app's base
image.  Instead, use one of the tagged image with build triggers e.g.
[magvlab/php:with-ext-mongodb](https://hub.docker.com/r/magvlab/php/).

- How to build and run your app
    1. `cd into-your-app-directory`
    2. `docker build -t magvlab/your-app-name-here:debug .`
    3. `docker run -it --rm -p port-you-open:80 magvlab/you-app-name-here:debug`
    4. test your app
    5. make changes
    6. repeat step 2

- What happens during build
    1. `php.ini` gets copied into image
    2. `composer.json` copied into `/var/www/html`
    3. run `composer install` in directory `/var/www/html`
    4. And then every step you defined in your `Dockerfile`

- What is a bare minimum `Dockerfile` for my app

```
FROM magvlab/php:with_ext_mongodb
MAINTAINER Jeffrey Jen <jeffrey@magv.com>

# install your app
COPY src/ /var/www/html/
```

- What if I need more extensions?

```
FROM magvlab/php:with_ext_mongodb
MAINTAINER Jeffrey Jen <jeffrey@magv.com>

# install extension and enable them right away
RUN apt-get update && apt-get install -y \
    <extension-lib-1> \
    <extension-lib-2> && \
    docker-ext-php-install <extension-1> <extension-2>

# install your app
COPY src/ /var/www/html/
```
