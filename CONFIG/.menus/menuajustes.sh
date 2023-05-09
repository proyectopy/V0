#!/bin/bash

########################################################################
# Script: menuajustes.sh
# Descripcion: Menu Ajustes del servidor ProyectoPy
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
menu_ajustes() {
    proyectopi
    msg_m_ajustes
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Ajustes Claves Usuarios 

        ${F_VDOBLE}$(ColorVerde '2)') Ajustes Zona horaria

        ${F_VDOBLE}$(ColorVerde '3)') Ajustes Hdd

        ${F_VDOBLE}$(ColorVerde '4)') Ajustes de Red

        ${F_VDOBLE}$(ColorVerde '5)') Menu Principal


        ${F_VDOBLE}$(ColorVerde '0)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        source /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        ;;
    
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/timezone.sh
        source /home/pi/.configuracion/.scripts/.install/.config/timezone.sh
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        ;;
    3)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        source /home/pi/.configuracion/.scripts/.menus/menuhdd.sh
        ;;
    4)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        ;;
        
    5)
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

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        ;;
    esac
}
########################################################################
# FIN MENUS AJUSTES
########################################################################
menu_ajustes