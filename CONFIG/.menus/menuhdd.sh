#!/bin/bash

########################################################################
# Script: menuhdd.sh
# Descripcion: Menu Ajustes Disco duro del servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source .configuracion/.scripts/.files/funciones.sh
########################################################################
# VARIABLE VERSION
########################################################################
version="V0"
########################################################################
########################################################################
# INICIO MENU
########################################################################
########################################################################
# INICIO SUBMENU HDD (OK)
########################################################################
menu_hdd() {
    proyectopi
    msg_m_hdd
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Expandir Sistema de Archivos

        ${F_VDOBLE}$(ColorVerde '2)') Montar Particiones

        ${F_VDOBLE}$(ColorVerde '3)') Menu Ajustes

        ${F_VDOBLE}$(ColorVerde '4)') Menu Principal

        ${F_VDOBLE}$(ColorVerde '0)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.hdd/expandir.sh
        source /home/pi/.configuracion/.scripts/.install/.hdd/expandir.sh
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        source /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        ;;
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.hdd/mounthdd.sh
        source /home/pi/.configuracion/.scripts/.install/.hdd/mounthdd.sh
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        source /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        ;;
    3)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        ;;

    4)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;
    0)
        
        clear
        msg_bye
        exit 0
        ;;

    *)
        msg_error_opcion

        sleep 2

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        source /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        ;;
    esac
}
########################################################################
# FIN MENUS SERVIDOR
########################################################################
menu_hdd