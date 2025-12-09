    # ==========================
    # MENÚ DE SELECCIÓN DE CMS
    # ==========================
    clear
    echo "===================================="
    echo "   ¿QUÉ CMS DESEAS INSTALAR?"
    echo "===================================="
    echo "1) Drupal 9.5.0"
    echo "2) Drupal 10.16"
    echo "3) Joomla 4.4.4"
    echo "4) Moodle 4.3.3"
    echo "5) PhpMyAdmin 5.2.1"
    echo "6) WordPress"
    echo "7) ---->> Joomla601 <<-----"
    echo "===================================="
    read -p "Selecciona una opción (1-6): " opcion

    case $opcion in
        1)
            echo "Instalando Drupal 9.5.0..."
            mv cms/drupal950 /var/www/
            cp config_files/drupal1016.conf /etc/apache2/sites-available/drupal.conf
            a2ensite drupal.conf
            ;;
        2)
            echo "Instalando Drupal 10.16..."
            mv cms/drupal1016 /var/www/
            cp config_files/drupal1016.conf /etc/apache2/sites-available/
            a2ensite drupal1016.conf
            ;;
        3)
            echo "Instalando Joomla 4.4.4..."
            mv cms/joomla444 /var/www/
            cp config_files/joomla.conf /etc/apache2/sites-available/
            a2ensite joomla.conf
            ;;
        4)
            echo "Instalando Moodle 4.3.3..."
            mv cms/moodle433 /var/www/
            cp config_files/moodle.conf /etc/apache2/sites-available/
            a2ensite moodle.conf
            ;;
        5)
            echo "Instalando PhpMyAdmin 5.2.1..."
            mv cms/phpmyadmin521 /var/www/
            cp config_files/phpmyadmin.conf /etc/apache2/sites-available/
            a2ensite phpmyadmin.conf
            ;;
        6)
            echo "Instalando WordPress..."
            mv cms/wordpress /var/www/
            cp config_files/wordpress.conf /etc/apache2/sites-available/
            a2ensite wordpress.conf
            ;;
        7)
            echo "Instalando Joomla601..."
            mv cms/joomla601 /var/www/
            cp config_files/joomla.conf /etc/apache2/sites-available/
            a2ensite joomla.conf
            ;;
        *)
            echo "❌ Opción no válida"
            exit 1
            ;;
    esac

echo "Recargando apache2"
systemctl restart apache2.service

echo "Dando permisos y cambiando propietarios de /var/www/"
sleep 2
chmod -R 755 /var/www/
chown -R www-data:www-data /var/www/