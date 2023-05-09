#!/bin/bash

########################################################################
# Script: del_emby.sh
# Descripcion: Desinstalar Emby Server
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
PATH_EMBY=/opt/emby-server/
ff=ffmpeg
paquete=emby-server
########################################################################
########################################################################
# DESINSTALAR EMBY SERVER       *
########################################################################

if [ -d $PATH_EMBY ];
    then
        clear
        msg_desinstalando

        # Detenemos el servicio
        sudo systemctl stop $paquete &>/dev/null
        
        sudo systemctl daemon-reload &>/dev/null
        sudo systemctl reset-failed &>/dev/null

        
        # Eliminamos el directorio de 
        sudo rm -R $PATH_EMBY
        
        # Eliminamos ffmpeg
        # sudo apt-get purge $ff -y &>/dev/null
        # sudo apt-get remove --purge $paquete -y &>/dev/null
        # sudo apt-get update && sudo apt-get -y upgrade

        # Cerrar puertos en Ufw

        msg_reglasufw
        sleep 3

        sudo ufw deny 6154 &>/dev/null
        sudo ufw deny 8096 &>/dev/null
        

        clear
        msg_desinstalado
        sleep 3
    else
        clear
        msg_sincambios
        sleep 2
    fi