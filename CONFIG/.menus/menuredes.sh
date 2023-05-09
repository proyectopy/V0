#!/bin/bash

########################################################################
# Script: menuredes.sh
# Descripcion: Menu ajuste de redes del servidor ProyectoPy
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
# INICIO MENU REDES
########################################################################
menu_redes() {
    proyectopi
    msg_m_redes
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Ajustes Hostname

        ${F_VDOBLE}$(ColorVerde '2)') Ajustes de Red

        ${F_VDOBLE}$(ColorVerde '3)') Configurar DuckDns

        ${F_VDOBLE}$(ColorVerde '4)') Ajustes WiFi

        ${F_VDOBLE}$(ColorVerde '5)') Menu Ajustes

        ${F_VDOBLE}$(ColorVerde '6)') Menu Principal

        ${F_VDOBLE}$(ColorVerde '7)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.redes/hostname.sh
        source /home/pi/.configuracion/.scripts/.install/.redes/hostname.sh
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        ;;
        
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.redes/ips.sh
        source /home/pi/.configuracion/.scripts/.install/.redes/ips.sh
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        ;;

    3)  sudo chmod +x /home/pi/.configuracion/.scripts/.install/.redes/duckdns.sh
        source /home/pi/.configuracion/.scripts/.install/.redes/duckdns.sh
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        ;;

    4)  sudo chmod +x /home/pi/.configuracion/.scripts/.install/.redes/wifi.sh
        source /home/pi/.configuracion/.scripts/.install/.redes/wifi.sh
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        ;;    

    5)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        ;;

    6)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;
    7)
        
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
# FIN MENUS REDES
########################################################################
menu_redes