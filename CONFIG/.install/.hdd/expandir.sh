#!/bin/bash

########################################################################
# Script: expandir.sh
# Descripcion: Configurar la expansión Raspbian para aprovechar la SD
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
default="Si"
###################################################
#    CONFIGURAR LA EXPANSION DEL SISTEMA    (OK) 
###################################################
function expand (){

    clear
    msg_expandir
    echo ""
    echo -ne " ${F_VDOBLE}Quieres expandir el sistema de archivos (Recomendado) y pulsa [ENTER]: [$default] "
    read ex
    ex="${ex:-$default}"

    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $ex quieres expandir el sistema de archivos"
    sleep 3
    

    if [ $ex != $default ]
        then
        conf_expand=false
        conf_expand
        else
        conf_expand=true
        # echo "$conf_network"
        sleep 3
        conf_expand
    fi
}
###################################################
#    EXPANSION DE LA SD CON EL SISTEMA    (OK) 
###################################################
function conf_expand (){

    if [ "$conf_expand" = true ]; 
        then 
        cursor_off
        clear
        msg_expandir
        msg_expandiendo

        #Ejecuta el resize de la sd de la Raspberry
        sudo raspi-config --expand-rootfs &>/dev/null
        msg_expandido
        # sleep 3
        clear
        msg_reboot
        cursor_on
        sleep 3

        else
        clear
        msg_sincambios
        sleep 3
        
    fi
    # menuhdd
}
expand