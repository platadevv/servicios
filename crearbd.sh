#!/bin/bash

read -p "Nombre de la base de datos: " dbname
read -p "Usuario de MySQL: " mysqluser

# Verificar si el usuario existe
usuario_existe=$(mysql -u root -p -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user='$mysqluser');")

if [ "$usuario_existe" -eq 0 ]; then
    echo "El usuario '$mysqluser' NO existe en MySQL. Abortando."
    exit 1
fi

# Verificar si la base de datos ya existe
bd_existe=$(mysql -u "$mysqluser" -p -sse "SHOW DATABASES LIKE '$dbname';")

if [ "$bd_existe" == "$dbname" ]; then
    echo "La base de datos '$dbname' ya existe para el usuario '$mysqluser'. Abortando."
    exit 2
fi

# Crear la base de datos
mysql -u "$mysqluser" -p -e "CREATE DATABASE \`${dbname}\`;"
echo "✅ Base de datos '${dbname}' creada usando el usuario '${mysqluser}'."