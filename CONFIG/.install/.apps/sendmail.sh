#!/bin/bash

########################################################################
# Script: sendmail.sh
# Descripcion: Instalar y configurar ssmtp y mailutils
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
paquete=sendmail
sendmail=true
########################################################################
########################################################################
# FUNCION INSTALAR SSMTP Y MAILUTILS
########################################################################
function install_sendmail() {
    
    cursor_off

    msg_instalando
    sudo rm /var/lib/dpkg/lock-frontend &>/dev/null
    sudo dpkg --configure -a &>/dev/null
    #Instalamos ssmt

    app_ssmtp
    msg_espere
    sudo apt-get -y install ssmtp &>/dev/null
    
    #Instalamos ssmt
    msg_instalando

    app_mailutils
    msg_espere
    sudo apt-get -y install mailutils &>/dev/null

    clear
    msg_espere

    #Copia de seguridad del archivo de configuracion
    
    sudo chown pi:pi /etc/ssmtp/ssmtp.conf
    sudo chmod 777 /etc/ssmtp/ssmtp.conf
    sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.orig

    sleep 3

    #Escribe el archivo updater
    
    sudo echo '########################################################################' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo '# AÑADIDO POR EL SCRIPT DE CONFIGURACION' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo '########################################################################' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo 'AuthUser=proyectopy@gmx.es' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo 'AuthPass=L4cl4v3degmx.3s' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo 'FromLineOverride=YES' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo 'mailhub=mail.gmx.es:587' | sudo tee --append /etc/ssmtp/ssmtp.conf
    sudo echo 'UseSTARTTLS=YES' | sudo tee --append /etc/ssmtp/ssmtp.conf
    

    sudo chown root:root /etc/ssmtp/ssmtp.conf
    sudo chown root:root /etc/ssmtp/ssmtp.conf.orig
    
    sudo chmod 777 /etc/ssmtp/ssmtp.conf
    sudo chmod 777 /etc/ssmtp/ssmtp.conf.orig
    
    clear
    msg_instalado
    cursor_on

}
########################################################################
# FUNCION sendmail
########################################################################
function sendmail() {
    clear
    if [ "$sendmail" = true ]; then

        if dpkg-query -W -f'${db:Status-Abbrev}\n' ssmtp 2>/dev/null \ | grep -q '^.i $'; 
        then 
        clear
        msg_error_instalado
        else 
        install_sendmail
        fi
        else
        clear
        msg_sincambios
    fi   
}
sendmail