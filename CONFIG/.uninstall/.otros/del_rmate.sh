#!/bin/bash

########################################################################
# Script: del_unzip.sh
# Descripcion: Desinstalar Unzip
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
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
paquete=unzip
########################################################################
########################################################################
#                       DESINSTALAR UNZIP       
########################################################################
# La siguiente instruccion comprueba que el paquete no existe
# dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';

if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
    then
    clear
    msg_desinstalando 
    sleep 2
    sudo apt-get remove --purge $paquete -y
    clear
    msg_desinstalado
    else
    sudo apt autoremove -y
    # sudo apt-get update && sudo apt-get -y upgrade
    clear
    msg_error_instalado
    sleep 3
    exit
    fi


# sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
# sudo chmod a+x /usr/local/bin/rmate





