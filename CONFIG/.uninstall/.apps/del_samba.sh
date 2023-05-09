#!/bin/bash

########################################################################
# Script: del_sambs.sh
# Descripcion: Desinstalar Samba
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V0
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
paquete=samba
uf=ufw
########################################################################
########################################################################
# DESINSTALAR SAMBA         *
########################################################################

if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
    then
        clear
        msg_desinstalando
        msg_espere
        # progreso
        sudo rm /etc/samba/smb.conf
        sudo apt-get remove --purge samba -y #&>/dev/null
        sudo apt remove  --purge samba-common samba-common-bin -y #&>/dev/null
        sudo apt remove --purge python3-samba -y #&>/dev/null
        if dpkg-query -W -f'${db:Status-Abbrev}\n' $uf 2>/dev/null \ | grep -q '^.i $';
        then

        sudo apt autoremove -y #&>/dev/null

        # sudo apt-get update && sudo apt-get -y upgrade
        else

        msg_reglasufw

        sudo ufw deny 445 &>/dev/null
        sudo ufw deny 137/udp &>/dev/null
        sudo ufw deny 138/udp &>/dev/null
        sudo ufw deny 139 &>/dev/null
        fi

    else
        clear
        msg_desinstalado
        sleep 2
fi






