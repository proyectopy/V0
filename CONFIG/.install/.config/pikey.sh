#!/bin/bash

########################################################################
# Script: pikey.sh
# Descripcion: Configurar la clave del usuario Pi
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
###################################################
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################
function pikey (){
    clear    
    msg_ch_claves
     
    echo -ne "${F_VDOBLE}$(ColorAmarillo ' Escribe la contraseña para el usuario pi ') despues pulsa [ENTER]:   "    

    read new_password
    
    if [ -z "$new_password" ]
    then
        conf_pass=false
    else
        conf_pass=true
    fi

    conf_pass
}
###################################################
# CONFIGURAR LA CONTRASEÑA DEL USUARIO PI (OK)
###################################################
function conf_pass (){
    cursor_off
    if [ "$conf_pass" = true ]; then
        clear
        msg_cambiar

        echo "pi:$new_password" | sudo chpasswd

        sleep 3

        msg_cambiada

        sleep 3

    else

        clear
        msg_sincambios
        sleep 3

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
        source /home/pi/.configuracion/.scripts/.menus/menuclaves.sh
  
    fi
    cursor_on
}
pikey
