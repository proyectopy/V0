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
paquetephp=php
paqueteserver=nginx
paquetemaria=mariadb-server
emby=true
####################################################
#      COMPROBAR INSTALACION DE NGINX       
####################################################
function install_nginx() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' $paqueteserver 2>/dev/null \ | grep -q '^.i $';
    then

        clear
        app_servidor
        msg_yaesta
        msg_instalado
        clear
        sleep 3
        install_mariadb

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
        msg_instalado
        
    fi    
    install_mariadb
}
########################################################################
#                   INSTALAR MARIADB
########################################################################
function install_mariadb() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquetemaria 2>/dev/null \ | grep -q '^.i $';
    then

        clear
        msg_yaesta
        msg_instalado
        sleep 3
        clear

    else
        clear
        cursor_off
        msg_preparando
        

        msg_instalando
        
        msg_espere
        sudo apt-get install $paquetemaria -y &>/dev/null
        
        #Start the MariaDB service.

        sudo systemctl start mariadb
        
        #Enable the MariaDB service to start at system reboot.

        sudo systemctl enable mariadb

        #SQL Secure
        sudo chmod +x /home/pi/secure.sh
        sudo chown pi:pi /home/pi/secure.sh
        source /home/pi/secure.sh
        cursor_on
        msg_preparando
    fi
    install_php
}
########################################################################
#                   INSTALAR PHP
########################################################################
function install_php() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquetephp 2>/dev/null \ | grep -q '^.i $';
    then

        clear
        msg_yaesta
        msg_instalado
        sleep 3
        clear
        
    else
        clear
        cursor_off
        
        

        msg_instalando
        
        msg_espere
        sudo apt-get install $paquetephp php-fpm php-curl php-cli php-zip php-mysql php-xml -y &>/dev/null
        msg_preparando
        #CREAR INFO.PHP .
        sudo touch /var/www/html/phpinfo.php
        sudo chmod 777 /var/www/html/phpinfo.php
        
        sudo echo "<?php" >> /var/www/html/phpinfo.php
        sudo echo "phpinfo();" >> /var/www/html/phpinfo.php
        sudo echo "?>" >> /var/www/html/phpinfo.php

        sudo ufw allow http
        sudo ufw allow https

        cursor_on
    fi
    install_snapd
}
########################################################################
#                   INSTALAR CERTIFICADO LETS'ENCRIPT
########################################################################
function install_snapd() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' snapd 2>/dev/null \ | grep -q '^.i $';
    then

        clear
        msg_yaesta
        msg_instalado
        sleep 3
        clear
    else
        clear
        cursor_off
        
        

        msg_instalando
        
        msg_espere
        #Instalar snapd

        sudo apt install snapd -y &>/dev/null

        #Instalar core snap.

        sudo snap install core -y &>/dev/null
        sudo snap refresh core -y &>/dev/null

        msg_preparando

        #instalar certbot 
        sudo apt autoremove -y &>/dev/null
        sudo apt remove certbot -y &>/dev/null
        
        #Usar Snap para instalar Certbot.

        sudo snap install --classic certbot

        #Crear simlink al directorio de Certbot.

        sudo ln -s /snap/bin/certbot /usr/bin/certbot

        #Solicitar certificado y configurarlo en NGINX

        sudo certbot --nginx


        cursor_on
    fi
    source /home/pi/.configuracion/.scripts/.menus/menuservidor.sh
}
install_nginx