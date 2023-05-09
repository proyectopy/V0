#!/bin/bash

########################################################################
# Script: del_gitandjq.Sh
# Descripcion: Desinstalar GIT & JQ
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
paquete=ufw
########################################################################
########################################################################
# DESINSTALAR GIT & JQ        
########################################################################

########################################################################
# OPCION DESINSTALAR 
########################################################################
function uninstall_apps() {
    default="SI"
    clear 
    msg_desinstalar

    echo ""
    echo -ne " ${F_VDOBLE}Quieres Desinstalar GIT y JQ [Si/No]: [$default] "
    read uninstall
    uninstall="${uninstall:-$default}"

    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $uninstall quieres desinstalar las aplicaciones"
    sleep 3
    if [ $uninstall == $default ]
        then
        cursor_off
        sleep 3
        espere
        sudo apt-get purge git -y &>/dev/null
        sudo apt-get purge jq -y &>/dev/null
        des_ok
        cursor_on
        else
        clear
        msg_sincambios
        sleep 2
    fi

}
uninstall_apps





