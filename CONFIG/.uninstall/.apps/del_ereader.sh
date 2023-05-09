#!/bin/bash

########################################################################
# Script: del_ereader.sh
# Descripcion: Desinstalar eReader Ubooquity
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
PATH_UBOOQUITY=/opt/ubooquity
PATH_CRON=/var/spool/cron/crontabs/pi
eRead=" "
eReader="@reboot sleep 180 && cd $PATH_UBOOQUITY && nohup /usr/bin/java -jar $PATH_UBOOQUITY/Ubooquity.jar /opt/ubooquity/Ubooquity.jar --remoteadmin --headless"
########################################################################
########################################################################
# DESINSTALAR EREADER UBOOQUITY         
########################################################################

if [ -d $PATH_UBOOQUITY ];
    then
        clear
        msg_desinstalando

        # Eliminamos el servicio que creamos al instalar
        sudo systemctl stop eReader.service &>/dev/null
        sudo systemctl disable eReader.service &>/dev/null
        sudo rm /etc/systemd/system/eReader.service &>/dev/null
        sudo rm /etc/systemd/system/multi-user.target.wants/eReader.service &>/dev/null
        sudo systemctl daemon-reload &>/dev/null
        sudo systemctl reset-failed &>/dev/null

        # Eliminamos el crontab que creamos al instalar
        sudo sed -i 's,'"$eReader"','"$eRead"' &: \0/,' $PATH_CRON

        # Eliminamos el directorio que creamos al instalar
        sudo rm -R $PATH_UBOOQUITY
        
        # sudo apt-get update && sudo apt-get -y upgrade

        # Cerrar puertos en Ufw
        msg_reglasufw

        sudo ufw deny 2202 &>/dev/null
        sudo ufw deny 2203 &>/dev/null
        sudo ufw deny 5483 &>/dev/null
        sudo ufw deny 5488 &>/dev/null
        

        clear
        msg_desinstalado
    else
        clear
        msg_sincambios
        sleep 2
fi