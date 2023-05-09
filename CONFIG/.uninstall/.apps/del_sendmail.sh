#!/bin/bash

########################################################################
# Script: del_sendmail.sh
# Descripcion: Desinstalar Sendmail
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
paquete=ssmtp
utils=mailutils
########################################################################
########################################################################
# DESINSTALAR SENDMAIL        
########################################################################

if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
    then
    # clear
    # msg_desinstalando
    # msg_espere
    # sudo apt-get remove --purge $paquete -y &>/dev/null
    
    # sudo rm -rf /etc/$paquete


    # sudo apt-get update -y &>/dev/null
    # sudo apt autoremove -y &>/dev/null

        sudo rm /var/lib/dpkg/lock-frontend &>/dev/null
        sudo dpkg --configure -a &>/dev/null

        clear
        msg_desinstalando
        
        msg_espere
        ssmtp
        sudo apt-get purge $paquete -y &>/dev/null
        "$utils"
        sudo apt-get purge $utils -y &>/dev/null

        #sudo apt-get update && sudo apt-get -y upgrade
        sudo apt autoremove -y &>/dev/null
        
        
    else
        clear
        msg_desinstalado
fi






