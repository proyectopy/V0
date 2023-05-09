#!/bin/bash

########################################################################
# Script: ufw.sh
# Descripcion: Instalar ufw
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V0
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
# dpkg -s $paquete
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
ufw=true
export paquete="ufw"
########################################################################
########################################################################
# FUNCION INSTALAR UFW
########################################################################
function install_ufw() {
    cursor_off
    
    msg_instalando
    app_ufw
    msg_espere
    
    #Instalamos UFW
    sudo apt-get --fix-broken install -y &>/dev/null
    sudo apt -y install $paquete &>/dev/null
    yes | sudo $paquete enable &>/dev/null

    clear
    msg_espere
    
    msg_abrirpuertos
    sudo $paquete allow ssh &>/dev/null
    clear
    msg_instalado
    cursor_on

}
########################################################################
# FUNCION UFW
########################################################################
function ufw() {
    clear
    if [ $ufw = true ]; then

        if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $'; 
        then
         
        clear
        app_ufw
        msg_yaesta
        msg_instalado

        else 
        
        install_ufw 

        fi
        else
        clear
        msg_sincambios
    fi   
}
ufw