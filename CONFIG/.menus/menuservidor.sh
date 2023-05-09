#!/bin/bash

########################################################################
# Script: menuservidor.sh
# Descripcion: Menu creacion del servidor ProyectoPy
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
# SERVIDOR MENU
########################################################################
menu_servidor() {
    proyectopi
    msg_m_servidor
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Servidor

        ${F_VDOBLE}$(ColorVerde '2)') Servidor

        ${F_VDOBLE}$(ColorVerde '3)') Servidor

        ${F_VDOBLE}$(ColorVerde '4)') Servidor

        ${F_VDOBLE}$(ColorVerde '5)') Menu Ajustes

        ${F_VDOBLE}$(ColorVerde '6)') Menu Principal


        ${F_VDOBLE}$(ColorVerde '0)') Salir
        

        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        # ufw
        # menu_apps
        ;;
    2)
        # ufw
        # menu
        ;;
    3)
        # servidor
        # menu
        ;;
    4)
        # limpiar
        # menu_inicio
        ;;
    5)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        ;;
        
    6)
        
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
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuservidor.sh
        source /home/pi/.configuracion/.scripts/.menus/menuservidor.sh
        ;;
    esac
}
########################################################################
# FIN MENUS SERVIDOR
########################################################################
menu_servidor