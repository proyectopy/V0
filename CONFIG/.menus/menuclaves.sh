#!/bin/bash

########################################################################
# Script: menuvlaves.sh
# Descripcion: Menu Ajuste Claves del servidor ProyectoPy
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
# INICIO SUBMENU CLAVES (OK)
########################################################################
menu_claves() {
    proyectopi
    msg_m_claves
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Cambiar Clave User Pi

        ${F_VDOBLE}$(ColorVerde '2)') Cambiar Clave User Root

        ${F_VDOBLE}$(ColorVerde '3)') Menu Ajustes

        ${F_VDOBLE}$(ColorVerde '4)') Menu Principal

        ${F_VDOBLE}$(ColorVerde '0)') Salir




        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/pikey.sh
        source /home/pi/.configuracion/.scripts/.install/.config/pikey.sh
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        source /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        ;;
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/rootkey.sh
        source /home/pi/.configuracion/.scripts/.install/.config/rootkey.sh
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        source /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
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

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        source /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        ;;
    esac
}
########################################################################
# FIN MENUS CLAVES
########################################################################
menu_claves