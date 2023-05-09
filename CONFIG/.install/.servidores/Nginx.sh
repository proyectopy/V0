#!/bin/bash

########################################################################
# Script: Samba.sh
# Descripcion: Instalar Samba en elservidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/ENE2022
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# VARIABLES
########################################################################
#paquete=default-jdk
paquete=nginx
########################################################################
# FUNCIONES
########################################################################
function centrar {
     [[ $# == 0 ]] && return 1

     declare -i TERM_COLS="$(tput cols)"
     declare -i str_len="${#1}"
     [[ $str_len -ge $TERM_COLS ]] && {
          echo "$1";
          return 0;
     }

     declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
     [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
     filler=""
     for (( i = 0; i < filler_len; i++ )); do
          filler="${filler}${ch}"
     done

     printf "%s%s%s" "$filler" "$1" "$filler"
     [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
     printf "\n"

     return 0
}
########################################################################
# Variables Samba
########################################################################
export dir="/media/RaspberryPi"
export nombre="Wild South"
export usuario="pi"
export clave="$5$hOAQShHbJd$H7XtdiWyLOCP2HsGq38zmVpPVjJ4rxF4OwziXMZEgX9"
export wgroup="workgroup = 1NF3RN0"
####################################################
#            Instalando Java Open JDK 11        
####################################################
dpkg -s $paquete &> /dev/null
    if [ $? -ne 0 ]; then
            sleep 3
            clear
            centrar " "
            centrar "'####:'##::: ##::'######::'########::::'###::::'##::::::::::'###::::'##::: ##:'########:::'#######::"
            centrar ". ##:: ###:: ##:'##... ##:... ##..::::'## ##::: ##:::::::::'## ##::: ###:: ##: ##.... ##:'##.... ##:"
            centrar ": ##:: ####: ##: ##:::..::::: ##:::::'##:. ##:: ##::::::::'##:. ##:: ####: ##: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ## ## ##:. ######::::: ##::::'##:::. ##: ##:::::::'##:::. ##: ## ## ##: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ##. ####::..... ##:::: ##:::: #########: ##::::::: #########: ##. ####: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ##:. ###:'##::: ##:::: ##:::: ##.... ##: ##::::::: ##.... ##: ##:. ###: ##:::: ##: ##:::: ##:"
            centrar "'####: ##::. ##:. ######::::: ##:::: ##:::: ##: ########: ##:::: ##: ##::. ##: ########::. #######::"
            centrar "....::..::::..:::......::::::..:::::..:::::..::........::..:::::..::..::::..::........::::.......:::"
            #-------------------------------------------------------
            # Instalar Samba/CIFS  REVISADO
            # -------------------------------------------------------
            sudo apt install -y &paquete
            
            sudo ufw allow 445
            sudo ufw allow 137/udp
            sudo ufw allow 138/udp
            sudo ufw allow 139 

            sleep 3

            #Damos permisos al archivo
            sudo chmod 777 /etc/samba/smb.conf
            #modifica el archivo /etc/samba/smb.conf

            # recuerda cambiar la variable wgroup por el nombre de tu  
            # workgroup/NT-domain para que samba forme parte de el
            sudo sed -i "s/workgroup = WORKGROUP/ workgroup = 1NF3RN0/g" /etc/samba/smb.conf
            sudo sed -i "s/ map to guest = bad user/ map to guest = never/g" /etc/samba/smb.conf
            sudo sed -i "s/ read only = yes/ read only = no/g" /etc/samba/smb.conf
            sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/samba/smb.conf
            sudo echo "[RaspberryPi]" >> /etc/samba/smb.conf
            sudo echo "     comment = Carpeta compartida de la Raspberry Pi" >> /etc/samba/smb.conf
            sudo echo "     path = $dir" >> /etc/samba/smb.conf
            sudo echo "     guest ok = no" >> /etc/samba/smb.conf
            sudo echo "     browseable = No" >> /etc/samba/smb.conf
            sudo echo "     writeable = Yes" >> /etc/samba/smb.conf
            sudo echo "     write list = $usuario" >> /etc/samba/smb.conf
            sudo echo "     read only = no" >> /etc/samba/smb.conf
            sudo echo "     create mask = 0660" >> /etc/samba/smb.conf
            sudo echo "     directory mask = 0770" >> /etc/samba/smb.conf


            #Crear usuario 
            sudo useradd -c "$nombre" -s /sbin/nologin $usuario
            sudo passwd $usuario
            sudo smbpasswd -a $usuario

            #Crear directorio compartido
            sudo mkdir -p $dir
            sudo chown $usuario:$usuario $dir
            sudo chmod 750 $dir

            sudo systemctl restart smbd nmbd

            sudo chmod 644 /etc/samba/smb.conf 
            clear
            centrar " "
            centrar "::::::::'##:::'##::::'###:::::::::::::::::::'########::'######::'########::::'###:::::::::"
            centrar "::::::::. ##:'##::::'## ##:::::::::::::::::: ##.....::'##... ##:... ##..::::'## ##::::::::"
            centrar ":::::::::. ####::::'##:. ##::::::::::::::::: ##::::::: ##:::..::::: ##:::::'##:. ##:::::::"
            centrar "::::::::::. ##::::'##:::. ##:::::::::::::::: ######:::. ######::::: ##::::'##:::. ##::::::"
            centrar "::::::::::: ##:::: #########:::::::::::::::: ##...:::::..... ##:::: ##:::: #########::::::"
            centrar "::::::::::: ##:::: ##.... ##:::::::::::::::: ##:::::::'##::: ##:::: ##:::: ##.... ##::::::"
            centrar "::::::::::: ##:::: ##:::: ##:::::::::::::::: ########:. ######::::: ##:::: ##:::: ##::::::"
            centrar ":::::::::::..:::::..:::::..:::::::::::::::::........:::......::::::..:::::..:::::..:::::::"
            centrar " "
            centrar "'####:'##::: ##::'######::'########::::'###::::'##::::::::::'###::::'########:::'#######::"
            centrar ". ##:: ###:: ##:'##... ##:... ##..::::'## ##::: ##:::::::::'## ##::: ##.... ##:'##.... ##:"
            centrar ": ##:: ####: ##: ##:::..::::: ##:::::'##:. ##:: ##::::::::'##:. ##:: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ## ## ##:. ######::::: ##::::'##:::. ##: ##:::::::'##:::. ##: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ##. ####::..... ##:::: ##:::: #########: ##::::::: #########: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ##:. ###:'##::: ##:::: ##:::: ##.... ##: ##::::::: ##.... ##: ##:::: ##: ##:::: ##:"
            centrar "'####: ##::. ##:. ######::::: ##:::: ##:::: ##: ########: ##:::: ##: ########::. #######::"
            centrar "....::..::::..:::......::::::..:::::..:::::..::........::..:::::..::........::::.......:::"
        else  
            clear
            centrar " "
            centrar "::::::::'##:::'##::::'###:::::::::::::::::::'########::'######::'########::::'###:::::::::"
            centrar "::::::::. ##:'##::::'## ##:::::::::::::::::: ##.....::'##... ##:... ##..::::'## ##::::::::"
            centrar ":::::::::. ####::::'##:. ##::::::::::::::::: ##::::::: ##:::..::::: ##:::::'##:. ##:::::::"
            centrar "::::::::::. ##::::'##:::. ##:::::::::::::::: ######:::. ######::::: ##::::'##:::. ##::::::"
            centrar "::::::::::: ##:::: #########:::::::::::::::: ##...:::::..... ##:::: ##:::: #########::::::"
            centrar "::::::::::: ##:::: ##.... ##:::::::::::::::: ##:::::::'##::: ##:::: ##:::: ##.... ##::::::"
            centrar "::::::::::: ##:::: ##:::: ##:::::::::::::::: ########:. ######::::: ##:::: ##:::: ##::::::"
            centrar ":::::::::::..:::::..:::::..:::::::::::::::::........:::......::::::..:::::..:::::..:::::::"
            centrar " "
            centrar "'####:'##::: ##::'######::'########::::'###::::'##::::::::::'###::::'########:::'#######::"
            centrar ". ##:: ###:: ##:'##... ##:... ##..::::'## ##::: ##:::::::::'## ##::: ##.... ##:'##.... ##:"
            centrar ": ##:: ####: ##: ##:::..::::: ##:::::'##:. ##:: ##::::::::'##:. ##:: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ## ## ##:. ######::::: ##::::'##:::. ##: ##:::::::'##:::. ##: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ##. ####::..... ##:::: ##:::: #########: ##::::::: #########: ##:::: ##: ##:::: ##:"
            centrar ": ##:: ##:. ###:'##::: ##:::: ##:::: ##.... ##: ##::::::: ##.... ##: ##:::: ##: ##:::: ##:"
            centrar "'####: ##::. ##:. ######::::: ##:::: ##:::: ##: ########: ##:::: ##: ########::. #######::"
            centrar "....::..::::..:::......::::::..:::::..:::::..::........::..:::::..::........::::.......:::"
    fi      