#!/bin/bash

########################################################################
# Script: raspcontrol.sh
# Descripcion: Instalar Raspcontrol, centro web  de control para Raspberry Pi.
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
raspcontrol=true
hostname="proyectopy"
#export paquete="rpimonitor"
########################################################################
########################################################################
# FUNCION INSTALAR RPI MONITOR
########################################################################
function install_raspcontrol() {
    cursor_off
    
    msg_instalando
    
    msg_espere
    
    #Instalamos UFW
    # sudo apt-get --fix-broken install -y &>/dev/nul

    # sudo apt-get install y apt-transport-https ca-certificates
    # sudo wget https://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
    # sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
    # sudo apt update
    # sudo apt install rpimonitor

    sudo git clone https://github.com/harmon25/raspcontrol.git /.githubRepos/raspcontrol/

     # Escribe el archivo con la autentificacion
    sudo mkdir -p /etc/raspcontrol/
    sudo touch /etc/raspcontrol/database.aptmnt
    sudo chown -R pi:pi /etc/raspcontrol/database.aptmnt
    

    sudo echo "{" >> /etc/raspcontrol/database.aptmnt
    sudo echo "  \"user\":       \"wild\"," >> /etc/raspcontrol/database.aptmnt
    sudo echo "  \"password\":       \"Ant4vi4n4\"," >> /etc/raspcontrol/database.aptmnt
    sudo echo "}" >> /etc/raspcontrol/database.aptmnt

    sudo chown -R www-data:www-data /etc/raspcontrol/database.aptmnt
    sudo chmod -R 740 /etc/raspcontrol/database.aptmnt
    

    sleep 3
    echo "****************************************************"  
    echo "           Configura a tu gusto RpiMonitor          "
    sleep 3
    echo "               Visita en tu navegador               "
    sleep 3
    echo "    \e[31mhttp://$hostname.local:raspcontrol\e[0m    "
    sleep 3
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
function comprobar() {
    clear
    if [ $raspcontrol = true ]; then

        
        
        install_raspcontrol

        
    fi   
}
comprobar