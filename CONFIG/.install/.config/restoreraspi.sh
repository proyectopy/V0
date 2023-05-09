#!/bin/bash

########################################################################
# Script: updateraspy.sh
# Descripcion: Funcion para restaurar servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
# Tareas; Descomentar reinicio linea 64
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
# DIRECTORIO CONFIGURACION
DIRECTORIOCONF=/home/pi/.configuracion/.scripts/

########################################################################
# FUNCION RESTAURAR REVISADO DESCOMENTAR REINICIO
########################################################################
function restaurar() {

    if [ -d "$DIRECTORIOCONF" ]
        then
            cursor_off
            # echo "El directorio ${DIRECTORIO} existe"
            restaurar=true
            if [ "$restaurar" = true ]; 
                then

                    #######################################
                    #   RECOLOCAR CARPETAS POR DEFECTO    #
                    #######################################

                    sleep 5
                    clear
                    msg_restaurando
                    sudo mv .configuracion/.scripts/.files/ /home/pi/
                    sudo mv .configuracion/.scripts/.install/ /home/pi/
                    sudo mv .configuracion/.scripts/.uninstall/ /home/pi/
                    sudo mv .configuracion/.scripts/.menus/ /home/pi/
                    sudo cp .configuracion/.scripts/ConfigPi.sh.orig /home/pi/ConfigPi.sh
                    sudo chmod +x /home/pi/ConfigPi.sh
                    sudo rm -rf .configuracion

                    #######################################
                    #    borrar el Crontab del updater    #
                    #######################################
                    # crontab -u pi -l | grep -v '/home/pi/.scripts/.actualizaciones/updater'  | crontab -u pi -
                    # sudo apt-get purge -y ufw
                    crontab -r
                    sleep 5
                msg_apagando
                sleep 3
            fi
            msg_apagado
            sleep 3
            cursor_on
            # sudo init 6
    fi
    
}
########################################################################
# FIN FUNCION RESTAURAR
########################################################################
restaurar