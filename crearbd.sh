#!/bin/bash

read -p "🗄️ Nombre de la base de datos: " dbname
read -p "👤 Usuario MySQL con privilegios totales: " mysqluser
read -s -p "🔑 Contraseña del usuario MySQL: " mysqlpass
echo ""

# Verificar conexión
mysql -u "$mysqluser" -p"$mysqlpass" -e "exit" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "❌ Error de conexión con MySQL. Usuario o contraseña incorrectos."
    exit 1
fi

# Verificar si la base de datos ya existe
bd_existe=$(mysql -u "$mysqluser" -p"$mysqlpass" -sse "SHOW DATABASES LIKE '${dbname}';")

if [ "$bd_existe" == "$dbname" ]; then
    echo "⚠️ La base de datos '${dbname}' ya existe. Abortando."
    exit 2
fi

# Crear la base de datos
mysql -u "$mysqluser" -p"$mysqlpass" -e "CREATE DATABASE \`${dbname}\`;"

if [ $? -eq 0 ]; then
    echo "✅ Base de datos '${dbname}' creada correctamente por el usuario '${mysqluser}'."
else
    echo "❌ Error al crear la base de datos."
fi