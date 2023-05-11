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

        #sudo mysql_secure_installation
#
        #sudo mysql_secure_installation <<_EOF_
        #    Ant4vi4n4
        #    y
        #    y
        #    Ant4vi4n4
        #    Ant4vi4n4
        #    y
        #    y
        #    y
        #    y
        #    _EOF_


    #sudo echo -e "\ny\ny\nAnt4vi4n4\nAnt4vi4n4\ny\ny\ny\ny" | /usr/bin/mysql_secure_installation
    #echo -e "\ny\ny\nabc\nabc\ny\ny\ny\ny\n" | ./usr/bin/mysql_secure_installation
    sudo chmod +x /home/pi/secure.sh
    sudo chown pi:pi /home/pi/secure.sh
    source /home/pi/secure.sh
    cursor_on
    msg_preparando
    fi
    # Descargar Emby
    #Version Beta
    #wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.8.0.8/emby-server-deb_4.8.0.8_armhf.deb #&>/dev/null

    #Version Estable
    # wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.7.6.0/emby-server-deb_4.7.6.0_armhf.deb &>/dev/null
    # Descomprime e instala emby
    
    # Instalar Emby
    #Version beta 4.8.0.8
    #sudo dpkg -i emby-server-deb_4.7.0.8_armhf.deb  #&>/dev/null
    #Version estable 4.7.6.0
    # sudo dpkg -i emby-server-deb_4.7.6.0_armhf.deb &>/dev/null 

    #clear
    #msg_abrirpuertos
    ##abre puertoe 6154 y 8096
    #sudo ufw allow 6154 &>/dev/null
    #sudo ufw allow 8096 &>/dev/null
    #sleep 3

    #msg_limpiando
    #Elimina el archivo comprimido
    #sudo rm -rf home/pi/emby-server-deb_4.7.6.0_armhf.deb


    # echo "" 
    # echo -ne "${F_VDOBLE}******************************************"
    # echo "${F_VDOBLE}       Configura a tu gusto Emby Server       "
    # sleep 3
    # echo "" 
    # echo -ne "${F_VDOBLE}        Visita en tu navegador            "
    # sleep 3
    # echo "" 
    # echo -ne "${F_VDOBLE}  \e[31mhttp://$hostname.local:8096\e[0m  "
    # echo "" 
    # echo -ne "${F_VDOBLE}******************************************"
    # echo "" 
    #clear
    #msg_instalado
    #cursor_on
}
install_nginx