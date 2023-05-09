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
    msg_m_install
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Instalar UFW

        ${F_VDOBLE}$(ColorVerde '2)') Instalar Samba

        ${F_VDOBLE}$(ColorVerde '3)') Instalar Java

        ${F_VDOBLE}$(ColorVerde '4)') Instalar eReader

        ${F_VDOBLE}$(ColorVerde '5)') Instalar Emby

        ${F_VDOBLE}$(ColorVerde '6)') Instalar Otras

        ${F_VDOBLE}$(ColorVerde '7)') Menu Principal

        ${F_VDOBLE}$(ColorVerde '8)') Desinstalar apps


        ${F_VDOBLE}$(ColorVerde '0)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
        source /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/samba.sh
        source /home/pi/.configuracion/.scripts/.install/.apps/samba.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    3)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/java.sh
        source /home/pi/.configuracion/.scripts/.install/.apps/java.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    4)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/ereader.sh
        source /home/pi/.configuracion/.scripts/.install/.apps/ereader.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    5)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/emby.sh
        source /home/pi/.configuracion/.scripts/.install/.apps/emby.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;

    6)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/instalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/instalamas.sh
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
