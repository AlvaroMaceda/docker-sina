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
  - Desde el directorio actual ejecuta el comando `docker-compose up -d`. La primera vez tardará unos minutos ya que debe descargar y construir los contenedores necesarios, las siguientes veces será bastante más rápido
4. Accede a phpmyadmin en la dirección http://localhost:9090 y realiza lo siguiente:
  - Crea el usuario y la base de datos para el blog. Los datos los tienes en vp-config.php
  - Carga la copia de la base de datos mediante la utilidad de importación de phpmyadmin
5. Accede al blog en la dirección http://localhost:8080

TO-DO: cambiar el host de Wordpress

## Parada

Cuando hayas terminado ejecuta el comando `docker-compose down`. Los cambios que hayas hecho tanto en la base de datos como en los ficheros del blog se conservarán en tu copia local.

## Empezar de nuevo

Si quieres volver al estado original del blog, borra **el contenido** de los directorios /wordpress y /db y realiza de nuevo la instalación desde el paso 2.

## Limpieza

TODO: Explicar como eliminar todas las imágenes, contenedores y volúmenes de docker


## Solución de problemas

define('WP_DEBUG', true);

TO-DO: Explicar cómo cambiar la configuración de mysql


Ver la versión de Wordpress en BD: tabla wp_options, registro db_version
https://codex.wordpress.org/WordPress_Versions


Ver la versión de Wordpress en ficheros:
In the wp-includes directory, open the version.php 


Deshabilitar todos los plugins:
Browse the table wp_options and find the option active_plugins. Delete the entry




