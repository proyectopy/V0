#!/bin/bash

########################################################################
# Script: del_ufw.sh
# Descripcion: Desinstalar Unzip
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V0
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
# dpkg -s $paquete
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
paquete=ufw
########################################################################
########################################################################
# DESINSTALAR UFW        
########################################################################

if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
    then
        clear
        msg_desinstalando
        app_ufw
        msg_espere
        sudo apt-get purge $paquete -y &>/dev/null
        sudo apt-get remove $paquete -y &>/dev/null

        #sudo apt-get update && sudo apt-get -y upgrade
        sudo apt autoremove -y &>/dev/null
        
        
    else
        clear
        msg_desinstalado
fi






