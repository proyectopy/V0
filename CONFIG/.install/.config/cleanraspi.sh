#!/bin/bash

########################################################################
# Script: cleanraspy.sh
# Descripcion: Funcion para la limpieza del servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
# Tareas: Descomentar reinicio linea 71
########################################################################
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
limpiar=true
########################################################################
########################################################################
# FUNCION LIMPIAR REVISADO DESCOMENTAR REINICIO
########################################################################
function limpiar() {
    
        ###############################
        # Limpiar Raspberry REVISADO
        ###############################
        cursor_off
        clear
        msg_limpio
        msg_tarda

        msg_limpia
        # msg_limpiando
        #Espacio que se puede liberar
        directorio_actual=$(pwd)
        # echo $directorio_actual
        cd /var/cache/apt/archives 
        espacio=$(sudo du -h -s) #&>/dev/null 

        tput cup 21 33
        echo -ne "${F_VDOBLE}Un total de $espacio "

        cd $directorio_actual
        sleep 3
        clear
        msg_limpiando
        #liberar espacio
        sudo apt-get clean &>/dev/null 
        # sudo apt-get update &>/dev/null 
        # sudo apt-get -y upgrade &>/dev/null
        msg_espere
        #####################################
        # Reinicio de la Raspberry  REVISADO
        #####################################
        clear
        msg_apagando
        msg_apagado
        #Reinicia la Raspberry

        sleep 3
        cursor_on

        

        # menuajustes
        msg_reboot
        sudo init 6
        
}
limpiar