#!/bin/bash

if [ $(whoami) == "root" ]
then

    echo "Reiniciando servicio networking Parte 1"
    systemctl restart networking.service

    echo "Actualizando..."
    apt update -y

    echo "instalado apache2..."
    apt install -y apache2

    echo "instalado mariadb-server"
    apt install -y mariadb-server

    echo "instalando php"
    apt install -y php

    echo "Reiniciando servicio networking Parte 2"
    systemctl restart networking.service

    echo "Instalando todos los paquetes de php"
    apt install -y php-mysql php-gd php-mcrypt php-curl php-xmlrpc php-intl php-soap
    echo "Se ha completado la instalacion con existo"

    
    echo "Ajustando ficheros para configuraciones de CMS"
    sleep 3
    a2dissite 000-default.conf

    rm -r /var/www/html

    mv cms/drupal-950 /var/www/
    mv cms/drupal-1016 /var/www/
    mv cms/joomla-444 /var/www/
    mv cms/moodle-433 /var/www/
    mv cms/phpmyadmin-521 /var/www/
    mv cms/wordpress /var/www/


    mkdir /var/www/web1
    mv config_files/web.html /var/www/web1/
    mv config_files/apacheweb.conf /etc/apache2/sites-available/

    echo "Dando permisos y cambiando propietarios de /var/www/"
    sleep 3
    chmod -R 755 /var/www/
    chown -R www-data:www-data /var/www/

    a2ensite apacheweb.conf

    systemctl restart apache2.service

else
    echo "Para ejecutar el script instalador debes ser Root o con sudo"
fi