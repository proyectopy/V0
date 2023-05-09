#!/bin/bash

########################################################################
# Script: menuapps.sh
# Descripcion: Menu Aplicaciones del servidor ProyectoPy
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
# IINICIO MENU APPS
########################################################################
menu_apps() {
    proyectopi
    msg_m_uninstall
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Desinstalar Rpi Monitor

        ${F_VDOBLE}$(ColorVerde '2)') Desinstalar Git

        ${F_VDOBLE}$(ColorVerde '3)') Deshabilitado

        ${F_VDOBLE}$(ColorVerde '4)') Deshabilitado

        ${F_VDOBLE}$(ColorVerde '5)') Deshabilitado

        ${F_VDOBLE}$(ColorVerde '6)') Desinstalar Otras

        ${F_VDOBLE}$(ColorVerde '7)') Menu Principal

        ${F_VDOBLE}$(ColorVerde '8)') Desinstalar apps


        ${F_VDOBLE}$(ColorVerde '0)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_rpi.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_rpi.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        ;;
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_gitandjq.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_gitandjq.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        ;;
    3)
        # sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/java.sh
        # source /home/pi/.configuracion/.scripts/.install/.apps/java.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        ;;
    4)
        # sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/ereader.sh
        # source /home/pi/.configuracion/.scripts/.install/.apps/ereader.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        ;;
    5)
        # sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/emby.sh
        # source /home/pi/.configuracion/.scripts/.install/.apps/emby.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        ;;

    6)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
        
    7)
        
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;

    8)
        
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        source /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        ;;
    0)
        
        clear
        msg_bye
        exit 0
        ;;

    *)
        msg_error_opcion

        sleep 2

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuappsl.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    esac
}
########################################################################
# FIN MENU APPS
########################################################################
menu_apps
