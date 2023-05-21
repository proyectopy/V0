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
PATH_SOURCES=/etc/apt/sources.list.d/jellyfin.list
PATH_JELLY=/var/lib/jellyfin/
ff=ffmpeg
paquete=jellyfin*
########################################################################
########################################################################
# DESINSTALAR EMBY SERVER       *
########################################################################

if [ -d $PATH_JELLY ];
    then
        clear
        msg_desinstalando

        # DESINSTALAMOS
        
        apt remove $paquete && apt purge $paquete -y &>/dev/null


        # Eliminamos el directorio de LISTAS 
        
        rm -f $PATH_SOURCES
        # Eliminamos ffmpeg
        # sudo apt-get purge $ff -y &>/dev/null
        # sudo apt-get remove --purge $paquete -y &>/dev/null
        # sudo apt-get update && sudo apt-get -y upgrade

        # Cerrar puertos en Ufw

        msg_reglasufw
        sleep 3

        sudo ufw deny 8920 &>/dev/null
        sudo ufw deny 8096 &>/dev/null
        

        clear
        msg_desinstalado
        sleep 3
    else
        clear
        msg_sincambios
        sleep 2
    fi