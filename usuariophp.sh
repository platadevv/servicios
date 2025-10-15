#!/bin/bash

echo "El usuario por defecto es 'phpmaster'."
read -p "¿Querés usar este nombre de usuario? (s/n): " respuesta

if [[ "$respuesta" =~ ^[Nn]$ ]]; then
    read -p "Ingresá el nuevo nombre de usuario: " usuario
    read -s -p "Ingresá la contraseña para el nuevo usuario: " clave
            echo ""
else
    usuario="phpmaster"
    clave="phpmaster"
fi

    echo "Creando usuario '${usuario}' con contraseña '${clave}'..."

    mysql -u root -p -e "
    CREATE USER IF NOT EXISTS '${usuario}'@'%' IDENTIFIED BY '${clave}';
    GRANT ALL PRIVILEGES ON *.* TO '${usuario}'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    "

    echo "Usuario '${usuario}' creado correctamente (o ya existía)."