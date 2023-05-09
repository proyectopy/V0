#!/bin/bash

########################################################################
# Script: del_java.sh
# Descripcion: Desinstalar Java OpenJDK 11
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
paquete=openjdk*
########################################################################
########################################################################
# DESINSTALAR OPEN JDK 11   
########################################################################
if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
    then
        clear
        msg_desinstalando
        msg_tarda

        sudo apt-get purge $paquete -y &>/dev/null
        sudo apt-get remove $paquete -y &>/dev/null

        sudo apt autoremove -y &>/dev/null
        # sudo apt-get update && sudo apt-get -y upgrade

        msg_desinstalado
        
    else
        clear
        msg_desinstalado
        sleep 2
fi
