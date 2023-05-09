#!/bin/bash

########################################################################
# Script: rootkey.sh
# Descripcion: Configurar el acceso ssh para usuario root
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
#     OBTENER LA VARIABLE CONTRASEÑA ROOT (OK)     
###################################################
function rootkey (){
    clear    
    msg_ch_claves
     
    echo -ne "${F_VDOBLE}$(ColorAmarillo ' Escribe la contraseña para el usuario root ') despues pulsa [ENTER]:   "    
    
    read new_password_root

    if [ -z "$new_password_root" ]
        then
            conf_pass_root=false
        else
            conf_pass_root=true
    fi
    conf_pass_root
}
###################################################
# CONFIGURANDO EL ACCESO DEL USUARIO ROOT (OK)
###################################################
function conf_pass_root (){
    cursor_off
    if [ "$conf_pass_root" = true ]; then

    
       clear
        msg_cambiar

        echo "root:$new_password_root" | sudo chpasswd

        sleep 3

        #modifica el archivo /etc/ssh/sshd_config

        sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
        sleep 3
        #reinicia servicio ssh
        sudo service ssh restart

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
rootkey