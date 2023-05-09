#!/bin/bash

########################################################################
# Script: timezone.sh
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
espana="${F_VDOBLE}Vamos a instalar la zona horaria"
otra="${F_VDOBLE}Has elegido la zona horaria por defecto"
error="${F_VDOBLE}Escribe un formato correcto por ejemplo Europe/Paris"
pregunta="${F_VDOBLE}¿Que timezone quieres para tu Raspberry?"
tiempo=10    
madrid="Europe/Madrid"
OBLIGATORIO='/'
default="Si"
###################################################
#           OBTENER LA VARIABLE TIMEZONE  (OK)     
###################################################
function cuestion (){


    clear
    msg_tz
    echo ""
    echo -ne " ${F_VDOBLE}Quieres Configurar la zona Horaria (Recomendado) [Si/No]: [$default] "
    read tz
    tz="${tz:-$default}"

    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $tz quieres configurar la Zona Horaria"
    sleep 3
    if [ $tz != $default ]
        then
            conf_timezone=false
            # echo " $conf_network"
            sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
            source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        else

            clear
            msg_tz
            echo ""
            echo -ne "$pregunta [$madrid] ?  "
            read tz
            tz=${tz:-$madrid}
            # echo -ne "${F_VDOBLE}$tz"
            if [[ "$tz" == *"$OBLIGATORIO"* ]]; 
                then #comprueba que esista la barra
                    if  [ "$tz" = "$madrid" ] ;then #comprueba que sea la respuesta por defecto
                        echo -ne "\n$otra $madrid\n" #imprime el mensaje de elegido por defecto
                        conf_timezone=true
                        #echo "$conf_timezone"
                        conf_timezone
                        else
                            if  [ "$tz" = "$tz" ] ;then #comprueba que NO sea la respuesta por defecto
                            echo -ne "\n$espana $tz\n" #imprime el mensaje de elegido por defecto
                            conf_timezone=true
                            #echo "$conf_timezone"
                            conf_timezone
                            fi
                        fi    
                else 
                        conf_timezone=false
                        msg_tz
                        echo -ne "\n$error\n"
                        sleep 3
            fi
            # cuestion    
    fi                   
}
###################################################
#   CONFIGURAR EL TIMEZONE O ZONA HORARIA  (OK)     
###################################################
function conf_timezone (){
    cursor_off
    if [ "$conf_timezone" = true ]; then
        
        clear
        configurando_msg
        msg_tz
        msg_espere
        #modifica tu timezone donde pone Europe/Madrid en la siguente linea#
        sudo timedatectl set-timezone $tz --no-pager
        # --help
        # timedatectl 

        #modifica tu locale descomentando es_ES.UTF-8  
        sudo sed -i 's/^# *\(es_ES.UTF-8\)/\1/' /etc/locale.gen && sudo locale-gen &>/dev/null
        #modifica el archivo hostname cambiando el nuevo nombre
        sudo sed -i "s/LANG=en_GB.UTF-8/LANG=es_ES.UTF-8/g" /etc/default/locale
        # sudo dpkg-reconfigure locales 
        sudo update-locale 
        sleep 3
        msg_tz_ok
    else

        clear
        msg_sincambios
        sleep 3

        sudo chmod +x /home/pi/.configuracion/.scripts/.menus/menuajustes.sh
        source /home/pi/.configuracion/.scripts/.menus/menuajustes.sh

    fi
    cursor_on   
}
cuestion