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
    apt install -y php-mysql php-gd php-mcrypt php-curl php-xmlrpc php-intl php-soap php-mbstring php-xml php-zip
    echo "Se ha completado la instalacion con existo"

    
    echo "Ajustando ficheros para configuraciones de CMS"
    sleep 3
    a2dissite 000-default.conf

    rm -r /var/www/html

    cp -r cms/drupal950 /var/www/
    cp -r cms/drupal1016 /var/www/
    cp -r cms/joomla444 /var/www/
    cp -r cms/moodle433 /var/www/
    cp -r cms/phpmyadmin521 /var/www/
    cp -r cms/wordpress /var/www/


    mkdir /var/www/web1
    cp config_files/web.html /var/www/web1/
    cp config_files/apacheweb.conf /etc/apache2/sites-available/

    cp config_files/durpal1016.conf /etc/apache2/sites-available/
    cp config_files/moodle.conf /etc/apache2/sites-available/
    cp config_files/joomla.conf /etc/apache2/sites-available/
    cp config_files/wordpress.conf /etc/apache2/sites-available/
    cp config_files/phpmyadmin.conf /etc/apache2/sites-available/

    echo "Dando permisos y cambiando propietarios de /var/www/ "
    sleep 3
    chmod -R 755 /var/www/
    chown -R www-data:www-data /var/www/


    a2ensite apacheweb.conf
    a2ensite drupal1016.conf
    a2ensite moodle.conf
    a2ensite wordpress.conf
    a2ensite joomla.conf
    a2ensite phpmyadmin.conf

    systemctl restart apache2.service

else
    echo "Para ejecutar el script instalador debes ser Root o con sudo"
fi