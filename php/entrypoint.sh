#!/usr/bin/env sh
[ "$DEBUG" = "true" ] && set -x
set -e

# --
PHP_UID_DEFAULT=$(id -u www-data)
PROJECT_DIR=/var/www/html

# Here we check if GID and UID are already defined properly or not
# i.e Do we have a volume mounted and with a different uid/gid ?
if [[ -z "$(ls -n $PROJECT_DIR | grep $PHP_UID_DEFAULT)" ]]; then

    : ${PHP_UID:=$(id -u www-data)}
    : ${PHP_GID:=$(id -g www-data)}

    export PHP_UID
    export PHP_GID

    if [ "$PHP_UID" != "0" ] && [ "$PHP_UID" != "$(id -u www-data)" ]; then
      echo "Need to change UID and GID."
      # There is no usermod in the container
      #usermod  -u $PHP_UID www-data
      #groupmod -g $PHP_GID www-data
      sed -i -e 's/^\(www-data:[^:]\):[0-9]*:[0-9]*:/\1:'$PHP_UID:$PHP_GID':/' /etc/passwd
      chown -R www-data:www-data $PROJECT_DIR
      echo "UID and GID changed to $PHP_UID and $PHP_GID."
    fi
else
    echo "UID and GUI are OK !"
fi

exec "$@"
