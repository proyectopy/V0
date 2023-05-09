#!/bin/bash

########################################################################
# Script: rpi.sh
# Descripcion: Instalar RpiMonitor
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
rpi=true
export paquete="rpimonitor"
########################################################################
########################################################################
# FUNCION INSTALAR RPI MONITOR
########################################################################
function install_rpi() {
    cursor_off
    
    msg_instalando
    app_rpi
    msg_espere
    
    #Instalamos UFW
    # sudo apt-get --fix-broken install -y &>/dev/nul

    # sudo apt-get install y apt-transport-https ca-certificates
    # sudo wget https://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
    # sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
    # sudo apt update
    # sudo apt install rpimonitor

    sudo apt-get install dirmngr
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F

    sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list

    # sudo apt-get install -y $ja &>/dev/null

    sudo apt-get -y update 
    sudo apt-get install -y $paquete

    msg_abrirpuertos
    sudo $paquete allow 8888 &>/dev/null

    sudo /etc/init.d/$paquete update
    sudo apt-get update
    sudo apt-get upgrade

    sudo /etc/init.d/$paquete update

    sleep 3
    echo "****************************************************"  
    echo "           Configura a tu gusto RpiMonitor          "
    sleep 3
    echo "               Visita en tu navegador               "
    sleep 3
    echo "    \e[31mhttp://$hostname.local:8888\e[0m    "
    echo "****************************************************" 

    clear
    msg_espere
    
    clear
    msg_instalado
    cursor_on

}
########################################################################
# FUNCION UFW
########################################################################
function rpi() {
    clear
    if [ $rpi = true ]; then

        if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $'; 
        then
         
        clear
        app_rpi
        msg_yaesta
        msg_instalado

        else 
        
        install_rpi

        fi
        else
        clear
        msg_sincambios
    fi   
}
rpi