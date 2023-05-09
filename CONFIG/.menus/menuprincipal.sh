#!/bin/bash

########################################################################
# Script: menuprincipal.sh
# Descripcion: Menu Principal del servidor ProyectoPy
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
menu_inicio() {
    proyectopi
    msg_m_inicio
    echo -ne "

        ${F_VDOBLE}$(ColorVerde '1)') Ajustes Iniciales

        ${F_VDOBLE}$(ColorVerde '2)') Instalar Servidor

        ${F_VDOBLE}$(ColorVerde '3)') Instalar Aplicaciones

        ${F_VDOBLE}$(ColorVerde '4)') Actualizar sistema

        ${F_VDOBLE}$(ColorVerde '5)') Limpiar y Reiniciar

        ${F_VDOBLE}$(ColorVerde '6)') Restaurar Valores de Fábrica

        ${F_VDOBLE}$(ColorVerde '7)') Todo

        ${F_VDOBLE}$(ColorVerde '8)') Copia de seguridad


        ${F_VDOBLE}$(ColorVerde '0)') Salir


        ${F_VDOBLE}$(ColorAmarillo ' ¿Que quieres hacer?. ') Introduce el numero de la opción elegida  "
    read a
    case $a in
    1)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        ;;
    2)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuservidor.sh
        source /home/pi/.configuracion/.scripts/.menus/menuservidor.sh
        ;;
    3)
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        source /home/pi/.configuracion/.scripts/.menus/menuapps.sh
        ;;
    4)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/updateraspi.sh
        source /home/pi/.configuracion/.scripts/.install/.config/updateraspi.sh
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;
        
    5)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/cleanraspi.sh
        source /home/pi/.configuracion/.scripts/.install/.config/cleanraspi.sh
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;
    6)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/restoreraspi.sh
        source /home/pi/.configuracion/.scripts/.install/.config/restoreraspi.sh
        ;;
        
    7)
        # todo
        # menu
        ;;

    8)
        sudo chmod +x /home/pi/.configuracion/.scripts/.install/.config/backupraspi.sh
        source /home/pi/.configuracion/.scripts/.install/.config/backupraspi.sh
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

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        source /home/pi/.configuracion/.scripts/.menus/menuprincipal.sh
        ;;
    esac
}
########################################################################
# FIN menu_inicio
########################################################################
menu_inicio