
# Blog de Sina

El objetivo de este repositorio es tener un entorno de desarrollo para poder realizar modificaciones y pruebas con el blog de Sina.

Funciona con Docker. Debes tener instalado y configurado en tu máquina tanto Docker como Docker Compose.

## Instalación

Para poder montar una copia del blog de Sina debes seguir los siguientes pasos:

1. Descarga de datos del servidor
  - Descarga los ficheros de Wordpress del servidor
  - Haz un volcado de la base de datos
2. Copia los ficheros del blog
  - Copia los ficheros de Wordpress del servidor en el directorio wordpress
3. Si estás trabajando en linux, modifica el contenido de docker-compose.yml y pon en PHP_UID y PHP_GID el id de tu usuario y grupo, para que puedas editar los ficheros de wordpress desde tu ordenador.
4. Lanza los contenedores docker necesarios 
  - Desde el directorio actual ejecuta el comando `docker-compose up -d` en este directorio. La primera vez tardará unos minutos ya que debe descargar y construir los contenedores necesarios, las siguientes veces será bastante más rápido
5. Accede a phpmyadmin en la dirección http://localhost:9090 y realiza lo siguiente:
  - Crea el usuario y la base de datos para el blog. Los datos los tienes en wp-config.php
  - Carga la copia de la base de datos mediante la utilidad de importación de phpmyadmin
6. Modifica tu fichero de hosts (/etc/hosts si estás en linux) para incluir www.asociacionsina.org con la dirección 127.0.0.1. De este modo no tendrás que tocar nada en Wordpress. Recuerda eliminarlo cuando quieras acceder al blog real.
7. Accede al blog en la dirección http://www.asociacionsina.org

## Parada

Cuando hayas terminado ejecuta el comando `docker-compose down` en este directorio. Los cambios que hayas hecho tanto en la base de datos como en los ficheros del blog se conservarán en tu copia local.

## Empezar de nuevo

Si quieres volver al estado original del blog, borra **el contenido** de los directorios /wordpress y /db, ejecuta el comando `docker-compose rm` y realiza de nuevo la instalación desde el paso 2.

## Limpieza

Puedes realizar una limpieza de los ficheros de docker ejecutando la serie de comandos:
  - `docker-compose rm`
  - `docker image rm docker-sina_php docker-sina_mysql docker-sina_apache bitnami/phpmyadmin` *
  - `docker volume prune`

* Puede que el borrado de bitnami/phpadmin de error si estás usando la imagen en otro contenedor. También puedes borrar todas las imágenes de tu sistema que no se estén usando con `docker image prune --all`

## Solución de problemas

Puedes añadir configuración adicional para php de varias formas:
- Añadiendo ficheros .ini en el directorio /php, destruyendo los contenedores (`docker-compose rm`) y volviendo a arrancar 
- Modificando .htaccess del directorio /wordpress y añadiendo las opciones que quieras, por ejemplo:
  `php_value upload_max_filesize 256M`
  ¡Pero recuerda no subir los cambios a producción si no los quieres allí!)

Si tienes algún problema con los servidores, puedes ejecutar `docker-compose up` sin la opción `-d` y verás todos los mensajes de error. También puedes modificar wp-config.php y poner `define('WP_DEBUG', true);` 

### Conexion a cualquiera de los servidores

Puedes abrir una línea de comandos en cualquiera de los contenedores que se necesitan para ejecutar la aplicación con el siguiente comando:
`docker exec -ti SERVIDOR /bin/sh`

Por ejemplo, para conectarse al servidor php: `docker exec -ti sina_php /bin/sh`. Todos los servidores excepto php admiten también bash.

Los nombres de los cuatro servidores son:
- sina_mysql
- sina_apache
- sina_php
- sina_phpmyadmin


Ver los modulos instalados en apache: httpd -M

### Conexión a mysql

Puedes conectar a mysql desde línea de comandos ejecutando:
`docker run -it --network docker-sina_sina --rm mysql mysql -hsina_mysql -uroot -prootpassword`
Desde ahí podrás ejecutar consultas directamente a la base de datos. 

Recuerda que también tienes disponible un phpmyadmin en http://localhost:9090

### Conexión a Wordpress
Si no encuentras la dirección http://www.asociacionsina.org/wp-admin seguramente sea porque está activado el plugin better-wp-security.

Para acceder debes cambiar el nombre del directorio wp-content/plugins/better-wp-security a better-wp-security-disabled, tras lo cual ya podrás acceder. Renombra el directorio a su nombre original y activalo de nuevo.

### Versión de Wordpress
Hay dos versiones de Wordpress: la de la base de datos y la de los ficheros. En principio deberían ser compatibles, pero puedes consultarlo de la siguiente forma:

- Versión de la base de datos: 
  La puedes ver en la tabla wp_options, registro db_version. Hay una lista que te indicará a qué versión pertenece el número: https://codex.wordpress.org/WordPress_Versions
- Versión de Wordpress:
  La puedes encontrar en el fichero wp-includes/version.php 

### Deshabilitar plugins
Deshabilitar todos los plugins:
Browse the table wp_options and find the option active_plugins. Delete the entry

### Docker

Rehacer imágenes: `docker-compose build`
FALTA MIRAR EL TEMA DE USUARIO PHP
/usr/local/etc/php-fpm.d/www.conf



