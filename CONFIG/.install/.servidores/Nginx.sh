#!/bin/bash

########################################################################
# Script: lemp.sh
# Descripcion: Instalar Nginx, MariaDB & PHP
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/MAYO2023
# Version: V0
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
hostname="$(cat /etc/hostname)"
uf=ufw
paquete=emby-server
emby=true
####################################################
#      COMPROBAR INSTALACION DE NGINX       
####################################################
function install_nginx() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' nginx 2>/dev/null \ | grep -q '^.i $';
    then

        clear
        app_servidor
        msg_yaesta
        msg_instalado
        clear

    else

        clear
        msg_instalando
        sudo apt-get install nginx -y &>/dev/null 
        sudo systemctl start nginx &>/dev/null 
        sudo systemctl enable nginx

        #Abriendo puertos
        msg_abrirpuertos
        sudo ufw allow 'Nginx Full'

        msg_preparando

        #borrar configuracion por defecto
        sudo rm -rf /etc/nginx/sites-enabled/default
        sudo rm -rf /etc/nginx/sites-available/default

        sudo touch /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo chmod 777 /etc/nginx/sites-available/proyectopy.duckdns.org



        sudo echo "server {" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo " " >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   listen 80;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   server_name proyectopy.duckdns.org www.proyectopy.duckdns.org;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "    " >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   root /var/www/html;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   index index.php index.html index.nginx-debian.html;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   access_log /var/log/nginx/example_access.log;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   error_log /var/log/nginx/example_error.log;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "    " >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   location / {" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   try_files \$uri \$uri/ /index.php\$is_args\$args;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   }" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "    " >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   location ~ \.php$ {" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   try_files \$uri =404;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   fastcgi_index index.php;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   include fastcgi_params;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   fastcgi_pass unix:/run/php/php7.4-fpm.sock;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "   }" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo "}" >> /etc/nginx/sites-available/proyectopy.duckdns.org
        sudo echo " " >> /etc/nginx/sites-available/proyectopy.duckdns.org

        sudo chmod 644 /etc/nginx/sites-available/proyectopy.duckdns.org

        sudo ln -s /etc/nginx/sites-available/proyectopy.duckdns.org /etc/nginx/sites-enabled/proyectopy.duckdns.org

        sudo systemctl reload nginx

    fi    

}
install_nginx