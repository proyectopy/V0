#!/bin/bash

########################################################################
# Script: wifi.sh
# Descripcion: Configurar red wifi
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
default_ssid="nombre-de-tu-wifi"
default_psk="password-de-tu-wifi"
default_key="WPA-PSK"
# WPA/WPA2 TKIP/AES
ip=192.168.1.105
mask=255.255.255.0
###################################################
# CONFIRMAR CONFIGURACION DE UNA IP FIJA (OK)  
###################################################
function network (){
    
    clear
    msg_redes
    echo ""
    echo -ne " ${F_VDOBLE}Quieres Activar el WIFI de tu Raspberry: [$default] "
    read network
    network="${network:-$default}"
    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $network quieres configurar la red"
    sleep 3

    if [ $network != $default ]
        then

            conf_wifi=false
            sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuredes.sh
            source /home/pi/.configuracion/.scripts/.menus/menuredes.sh

        else
        
            conf_wifi=true
            conf_wifi
    fi
}
###################################################
# CONFIGURACION DE LA CONEXION DE RED (OK)  
###################################################
function conf_wifi (){
    if [ "$conf_wifi" = true ]; then

        clear
        configurando_msg
        msg_redes

        
        ###################################################
        #            OBTENER NOMBRE DEL WIFI              #
        ###################################################
        clear
        msg_wifissid
        echo ""
        echo -ne " ${F_VDOBLE}El valor por defecto es $default_ssid. Introduce el nombre de la red"
        echo ""
        echo -ne " ${F_VDOBLE}Escribe el nombre de la red y pulsa [ENTER]:"
        read ssid
        # : ${ssid:=$default_ssid}

        sleep 3

        # Comprueba que se haya introducido algun dato
        while [ "$ssid" = "" ]
        do
            # read ssid
            clear
            msg_error
            echo ""
            echo -ne " ${F_VDOBLE}No se puede quedar vacio"
            echo ""
            echo -ne " ${F_VDOBLE}El valor por defecto es $default_ssid."
            echo ""
            echo -ne " ${F_VDOBLE}Introduce el nombre de tu red. y pulsa [ENTER]:"
            read ssid
        done

        ###################################################
        #              OBTENER LA CLAVE WIFI              #
        ###################################################

        
        clear
        msg_wifikey
        echo ""
        echo -ne " ${F_VDOBLE}El valor por defecto es $default_psk. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " ${F_VDOBLE}Escribe la clave de tu WiFi y pulsa [ENTER]:" 
        read psk
        # : ${psk:=$default_psk}
        

        while [ "$psk" = "" ]
        do
            # read psk
            clear
            msg_error
            echo ""
            echo -ne " ${F_VDOBLE}No se puede quedar vacio"
            echo ""
            echo -ne " ${F_VDOBLE}El valor por defecto es $default_psk."
            echo ""
            echo -ne " ${F_VDOBLE}Introduce la clave WiFi. y pulsa [ENTER]:" 
            read psk
        done
        sleep 3
        
        sleep 3
        sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bkp
        sudo chmod 777 /etc/wpa_supplicant/wpa_supplicant.conf

        #modifica el archivo /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "country=ES" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo " " >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "ssid=\"$ssid"\" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "scan_ssid=1" >> /etc/wpa_supplicant/wpa_supplicant.conf 
        sudo echo "psk=\"$psk"\" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "key_mgmt=$default_key" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf

        sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf
        
        sudo cp /etc/network/interfaces /etc/network/interfaces.bkp
        sudo chmod 777 /etc/network/interfaces

        # Modifica el archivo /etc/network/interfaces
        
        sudo echo " " >> /etc/network/interfaces
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/network/interfaces
        sudo echo "# Interface eth0" >> /etc/network/interfaces
        sudo echo "auto etho" >> /etc/network/interfaces
        sudo echo "iface eth0 inet static" >> /etc/network/interfaces 
        sudo echo "address $ip" >> /etc/network/interfaces
        sudo echo "netmask $mask" >> /etc/network/interfaces

        sudo echo " " >> /etc/network/interfaces
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/network/interfaces
        sudo echo "# Interface WiFi" >> /etc/network/interfaces
        sudo echo "etc/network/interfaces" >> /etc/network/interfaces
        sudo echo "allow-hotplug wlan0" >> /etc/network/interfaces 
        sudo echo "wpa-ssid \"$ssid"\" >> /etc/network/interfaces
        sudo echo "wpa-psk \"$psk"\" >> /etc/network/interfaces

        sudo chmod 644 /etc/network/interfaces

       clear
        msg_redes_ok
        msg_reboot
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

