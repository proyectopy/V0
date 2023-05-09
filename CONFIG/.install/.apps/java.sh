#!/bin/bash

########################################################################
# Script: ereader.sh
# Descripcion: Instalar eReader ubooquity
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
java=true
ja="default-jdk"
########################################################################
# FUNCION INSTALAR JAVA
########################################################################

####################################################
#            INSTALAR JAVA OPEN JDK 11        
####################################################
function install_java() {
    cursor_off
    clear
    msg_instalando
    app_java
    msg_tarda
    msg_espere

    #Instalar Java Opn JDK 11
    sudo apt-get install -y $ja &>/dev/null
    
    sleep 3
    clear
    app_java
    msg_instalado
    cursor_on
} 

########################################################################
# FUNCION COMPROBAR INSTALACION DE JAVA
########################################################################
function java() {
    
    if [ "$java" = true ]; then
            
        # comprueba
        if dpkg-query -W -f'${db:Status-Abbrev}\n' $ja 2>/dev/null \ | grep -q '^.i $'; 
        then 
        clear
        app_java
        msg_yaesta
        msg_instalado
        else 
        sleep 3
        install_java 
    
        fi
        else
        clear
        msg_sincambios
    fi
}
java           
   
               
