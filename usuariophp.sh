#!/bin/bash

# Comprobar que MariaDB/MySQL esté activo
if ! systemctl is-active --quiet mariadb; then
    echo "❌ MariaDB no está en ejecución."
    exit 1
fi

echo "⚠️ El usuario por defecto es 'phpmaster'."
read -p "¿Querés usar este nombre de usuario? (s/n): " respuesta

if [[ "$respuesta" =~ ^[Nn]$ ]]; then
    read -p "✅ Ingresá el nuevo nombre de usuario: " usuario
    read -s -p "✅ Ingresá la contraseña para el nuevo usuario: " clave
    echo ""
else
    usuario="phpmaster"
    clave="phpmaster"
    echo "LA CONTRASEÑA DEL PHPMASTER ES --->> phpmaster <<---"
    sleep 1
fi

# Pedir contraseña de root
read -s -p "🔑 Ingresá la contraseña del usuario root de MySQL: " mysql_root_pass
echo ""

echo "⏳ Creando usuario '${usuario}' con privilegios de ROOT..."

mysql -u root -p"$mysql_root_pass" <<EOF
CREATE USER IF NOT EXISTS '${usuario}'@'%' IDENTIFIED BY '${clave}';
ALTER USER '${usuario}'@'%' IDENTIFIED BY '${clave}';
GRANT ALL PRIVILEGES ON *.* TO '${usuario}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "✅ Usuario '${usuario}' creado/actualizado con privilegios TOTALES (tipo root)."
else
    echo "❌ Error al crear o actualizar el usuario."
fi