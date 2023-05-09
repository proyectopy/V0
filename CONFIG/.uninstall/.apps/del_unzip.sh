#!/bin/bash

########################################################################
# Script: del_unzip.sh
# Descripcion: Desinstalar Unzip
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
paquete=unzip
########################################################################
########################################################################
#                       DESINSTALAR UNZIP       
########################################################################
# La siguiente instruccion comprueba que el paquete no existe
# dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';

if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
    then
    cursor_off
    
    clear
    msg_desinstalando 
    sudo apt-get remove --purge $paquete -y
    clear
    msg_desinstalado
    
    cursor_on
    else
    sudo apt autoremove -y
    # sudo apt-get update && sudo apt-get -y upgrade
    clear
    msg_error_instalado

    exit
    fi








