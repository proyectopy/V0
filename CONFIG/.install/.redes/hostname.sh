#!/bin/bash

########################################################################
# Script: hostname.sh
# Descripcion: Configurar la zona horaria de ProyectoPy
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
hostname="$(cat /etc/hostname)"
default="Si"
###################################################
#    CONFIRMAR CONFIGURACION DEL HOSTNAME (OK)   
###################################################
function changehost (){
    
    clear
    msg_host
    echo ""
    echo -ne " ${F_VDOBLE}Quieres Configurar el hostname [Si/No]: [$default] "
    read respuesta
    respuesta="${respuesta:-$default}"

    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $respuesta quieres configurar el hostname"
    sleep 3
    if [ $respuesta != $default ]
        then
            conf_hostname=false
            clear
            msg_sincambios
            sleep 3
            sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            source /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            
        else
            conf_hostname=true
            conf_hostname

    fi    
   
}
###################################################
#    CONFIGURAR EL HOSTNAME (OK)   
###################################################
function conf_hostname (){
    
    if [ "$conf_hostname" = true ]; then
        clear
        msg_host
        echo " "
        echo -ne "${F_VDOBLE}E hostname por defecto es [$hostname] :   "
        echo " "
        echo -ne "${F_VDOBLE}$(ColorAmarillo 'Introduce uno nuevo si quieres cambiarlo'). Despues pulsa [ENTER]:   "
        read nuevohost
        nuevohost="${nuevohost:-$hostname}"

        clear
        echo ""
        configurando_msg
        msg_host
        
        sleep 3
           
        sudo cp /etc/hosts /etc/hosts.old
        sudo sed -i "s/$hostname/$nuevohost/g" /etc/hosts    
        
        sudo cp /etc/hostname /etc/hostname.old
        sudo sed -i "s/$hostname/$nuevohost/g" /etc/hostname

        sleep 3    
        
        clear
        msg_host
        msg_cambiado
        msg_reboot

        sleep 3
        
    fi
}
changehost

