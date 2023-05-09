#!/bin/bash

########################################################################
# Script: ips.sh
# Descripcion: Configurar ip fija, gateway y nameserver
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
default="Si"
default_ip="192.168.1.105"
default_gtw="192.168.1.1"
default_nmsrv="8.8.8.8"
###################################################
# CONFIRMAR CONFIGURACION DE UNA IP FIJA (OK)  
###################################################
function network (){
    
    clear
    msg_redes
    echo ""
    echo -ne " ${F_VDOBLE}Quieres configurar la red (Recomendado) : [$default] "
    read network
    network="${network:-$default}"
    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $network quieres configurar la red"
    sleep 3

    if [ $network != $default ]
        then

            conf_network=false
            sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            source /home/pi/.configuracion/.scripts/.menus/menuredes.sh

        else
        
            conf_network=true
            conf_network
    fi
}
###################################################
# CONFIGURACION DE LA CONEXION DE RED (OK)  
###################################################
function conf_network (){
    if [ "$conf_network" = true ]; then

        clear
        configurando_msg
        msg_redes

        
        ###################################################
        #            OBTENER LA VARIABLE IP               #
        ###################################################
        clear
        msg_ip
        echo ""
        echo -ne " ${F_VDOBLE}El valor por defecto es $default_ip. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " ${F_VDOBLE}Que IP quieres para tu Raspberry y pulsa [ENTER]: [$default_ip] "
        read ipadress
        : ${ipadress:=$default_ip}
        # echo ""
        # echo "$ipadress"
        sleep 3
        
        # echo -n "\nPara introducir la IP usa el formato xx.xx.xx.xx\nQue IP usará la Raspberry y pulsa [ENTER]: "
        # read ipadress
        while [ "$ipadress" = "" ]
        do
            clear
            msg_error
            echo ""
            echo -ne " ${F_VDOBLE}No se puede quedar vacio"
            echo -ne " ${F_VDOBLE}El valor por defecto es $default_ip."
            echo -ne " ${F_VDOBLE}Usa el mismo formato para cambiarlo."
            echo -ne " ${F_VDOBLE}Que IP quieres para tu Raspberry y pulsa [ENTER]: [$default_ip] " 
            read ipadress
        done

        ###################################################
        #          OBTENER LA VARIABLE GATEWAY            #
        ###################################################

        
        clear
        msg_gateway
        echo ""
        echo -ne " ${F_VDOBLE}El valor por defecto es $default_gtw. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " ${F_VDOBLE}Que Puerta de acceso usa tu Raspberry y pulsa [ENTER]: [$default_gtw] " 
        read gateway
        : ${gateway:=$default_gtw}
        # echo ""
        # echo "$gateway"

        # echo -n "\nPara el gateway usa el formato xx.xx.xx.xx\nQue Gateway usará tu Raspberry y pulsa [ENTER] "
        # read gateway
        while [ "$gateway" = "" ]
        do
            clear
            msg_error
            echo ""
            echo -ne " ${F_VDOBLE}No se puede quedar vacio"
            echo -ne " ${F_VDOBLE}El valor por defecto es $default_gtw. \n Usa el mismo formato para cambiarlo "
            echo -ne " ${F_VDOBLE}Que Gateway quieres para tu Raspberry: [$default_gtw] " 
            read gateway
        done

        ###################################################
        #          OBTENER LA VARIABLE NAMESERVER         #
        ###################################################

        
        clear
        msg_nmsrv
        echo ""
        echo -ne " ${F_VDOBLE}El valor por defecto es $default_nmsrv. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " ${F_VDOBLE}Que servidores de nombres usa tu Raspberry y pulsa [ENTER]: [$default_nmsrv] " 
        read nameservers
        : ${nameservers:=$default_nmsrv}

        # echo ""
        # echo "$nameservers"

        # echo -n "\nPara el servidores de nombres usa el formato xx.xx.xx.xx\nQue NameServers usará tu Raspberry y pulsa [ENTER]:"
        # read nameservers
        while [ "$nameservers" = "" ]
        do
            clear
            msg_error
            echo ""
            echo -ne " ${F_VDOBLE}No se puede quedar vacio"
            echo -ne " ${F_VDOBLE}El valor por defecto es $default_nmsrv. \n Usa el mismo formato para cambiarlo "
            echo -ne " ${F_VDOBLE}Que nameserver quieres para tu Raspberry: [$default_nmsrv] " 
            read nameservers
        done
        clear
        configurando_msg
        msg_redes
        # echo ""
        # echo "$ipadress"
        # echo ""
        # echo "$gateway"
        # echo ""
        # echo "$nammeservers"
        
        #modifica el archivo /etc/dhcpcd.conf
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/dhcpcd.conf
        sudo echo "interface eth0" >> /etc/dhcpcd.conf
        sudo echo "static ip_address=$ipadress/24" >> /etc/dhcpcd.conf
        sudo echo "static routers=$gateway" >> /etc/dhcpcd.conf
        sudo echo "static domain_name_servers=$gateway $nameservers" >> /etc/dhcpcd.conf

        clear
        msg_redes_ok
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuredes.sh

        else

        msg_sincambios
        sleep 3
        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh

    fi
}
network

