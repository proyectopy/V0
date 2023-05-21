#!/bin/bash

########################################################################
# Script: ereader.sh
# Descripcion: Instalar eReader ubooquity
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
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
paquete=jellyfin
emby=true
####################################################
#      COMPROBAR INSTALACION DE UFW        
####################################################
function install_ufw() {
    
    sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
    source /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
    
}
####################################################
#       COMPROBAR INSTALACION DE FFMPEG        
####################################################
function install_ffmpeg() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' ffmpeg 2>/dev/null \ | grep -q '^.i $';
    then
    
    clear
    app_ffmpeg
    msg_yaesta
    msg_instalado
    clear
    
    else
    
    msg_instalando
    app_ffmpeg
    msg_tarda
    msg_espere
     
    sudo apt-get install ffmpeg -y &>/dev/null 

    clear
    app_ffmpeg
    msg_instalado
    
    fi
}        
########################################################################
#                   INSTALAR    UBOOQUITY
########################################################################
function install_emby() {
    
    clear
    cursor_off
    msg_preparando
    install_ffmpeg

    msg_instalando
    app_emby
    msg_espere

    # DESCARGAR SCRIPT E INSTALAR
    #Version Beta
    wget -O- https://repo.jellyfin.org/install-debuntu.sh | sudo bash #&>/dev/null
    #wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.8.0.8/emby-server-deb_4.8.0.8_armhf.deb #&>/dev/null

    #Version Estable
    # wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.7.6.0/emby-server-deb_4.7.6.0_armhf.deb &>/dev/null
    # Descomprime e instala emby
    
    # Instalar Emby
    #Version beta 4.8.0.8
    #sudo dpkg -i emby-server-deb_4.7.0.8_armhf.deb  #&>/dev/null
    #Version estable 4.7.6.0
    # sudo dpkg -i emby-server-deb_4.7.6.0_armhf.deb &>/dev/null 

    clear
    msg_abrirpuertos
    #abre puertoe 6154 y 8096
    sudo ufw allow 8920 &>/dev/null
    sudo ufw allow 8096 &>/dev/null
    sleep 3

    msg_limpiando
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
    clear
    msg_instalado
    cursor_on
}
########################################################################
#               COMPROBAR E INSTALAR EMBY
########################################################################
function jellyfin() {
    if [ $emby = true ]; then

        # instalar
        if dpkg-query -W -f'${db:Status-Abbrev}\n' jellyfin 2>/dev/null \ | grep -q '^.i $'; 
        then 
        clear
        app_emby
        msg_yaesta
        msg_instalado
        else
        echo "empezamos a instalar"
        sleep 3
        install_ufw

        install_emby 
        fi
        else
        clear
        msg_sincambios
    fi
}
jellyfin       
   
               
