#!/bin/bash

########################################################################
# Script: menuuninstall.sh
# Descripcion: Menu desinstalacion de apps del servidor ProyectoPy
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
# MENU UNINSTALL
########################################################################
menu_uninstall() {
    proyectopi
    msg_m_uninstall
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Desintalar UFW

        ${F_VDOBLE}$(ColorVerde '2)') Desintalar Samba

        ${F_VDOBLE}$(ColorVerde '3)') Desintalar Java

        ${F_VDOBLE}$(ColorVerde '4)') Desintalar eReader

        ${F_VDOBLE}$(ColorVerde '5)') Desintalar Emby

        ${F_VDOBLE}$(ColorVerde '6)') Desisntalar Otras

        ${F_VDOBLE}$(ColorVerde '7)') Menu Principal

        ${F_VDOBLE}$(ColorVerde '8)') Instalar apps


        ${F_VDOBLE}$(ColorVerde '0)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_ufw.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_ufw.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        source /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        ;;
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_samba.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_samba.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        source /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        ;;
    3)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_java.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_java.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        source /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        ;;
    4)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_ereader.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_ereader.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        source /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        ;;
    5)
        sudo chmod +x /home/pi/.configuracion/.scripts/.uninstall/.apps/del_emby.sh
        source /home/pi/.configuracion/.scripts/.uninstall/.apps/del_emby.sh
        sleep 6
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        source /home/pi/.configuracion/.scripts/.menus/menuuninstall.sh
        ;;

    6)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        source /home/pi/.configuracion/.scripts/.menus/desinstalamas.sh
        ;;
        
    7)
        
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;

    8)
        
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    0)
        
        clear
        msg_bye
        exit 0
        ;;

    *)
        msg_error_opcion

        sleep 2

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    esac
}
########################################################################
# FIN MENU UNINSTALL
########################################################################
menu_uninstall
########################################################################