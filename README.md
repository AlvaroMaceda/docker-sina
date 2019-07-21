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
3. Lanza los contenedores docker necesarios 
  - Desde el directorio actual ejecuta el comando `docker-compose up -d` en este directorio. La primera vez tardará unos minutos ya que debe descargar y construir los contenedores necesarios, las siguientes veces será bastante más rápido
4. Accede a phpmyadmin en la dirección http://localhost:9090 y realiza lo siguiente:
  - Crea el usuario y la base de datos para el blog. Los datos los tienes en vp-config.php
  - Carga la copia de la base de datos mediante la utilidad de importación de phpmyadmin
5. Modifica tu fichero de hosts (/etc/hosts si estás en linux) para incluir www.asociacionsina.org con la dirección 127.0.0.1. De este modo no tendrás que tocar nada en Wordpress. Recuerda eliminarlo cuando quieras acceder al blog real.
6. Accede al blog en la dirección http://www.asociacionsina.org

## Parada

Cuando hayas terminado ejecuta el comando `docker-compose down` en este directorio. Los cambios que hayas hecho tanto en la base de datos como en los ficheros del blog se conservarán en tu copia local.

## Empezar de nuevo

Si quieres volver al estado original del blog, borra **el contenido** de los directorios /wordpress y /db y realiza de nuevo la instalación desde el paso 2.

## Limpieza

Puedes realizar una limpieza de los ficheros de docker 
TODO: Explicar como eliminar todas las imágenes, contenedores y volúmenes de docker


## Solución de problemas

TO-DO: Explicar cómo cambiar la configuración de mysql

Si tienes algún problema con los servidores, puedes ejecutar `docker-compose up` sin la opción `-d` y verás todos los mensajes de error. También puedes modificar wp-config.php y poner `define('WP_DEBUG', true);` 

### Conexión a mysql
Puedes conectar a mysql desde línea de comandos ejecutando:
`docker run -it --network sina_backend --rm mysql mysql -hsina_mysql -uroot -prootpassword`
Desde ahí podrás ejecutar consultas directamente a la base de datos. Ten en cuenta que tambióen 

### Versión de Wordpress
Hay dos versiones de Wordpress: la de la base de datos y la de los ficheros. En principio deberían ser compatibles, pero puedes consultarlo de la siguiente forma:

- Versión de la base de datos: 
  La puedes ver en la tabla wp_options, registro db_version. Hay una lista que te indicará a qué versión pertenece el número: https://codex.wordpress.org/WordPress_Versions
- Versión de Wordpress:
  La puedes encontrar en el fichero wp-includes/version.php 

### Deshabilitar plugins
Deshabilitar todos los plugins:
Browse the table wp_options and find the option active_plugins. Delete the entry




