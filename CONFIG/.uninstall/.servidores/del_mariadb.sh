#!/bin/bash

########################################################################
# Script: del_mariadb.sh
# Finalidad: Configuracion Inicial de la raspberry
# Descripcion: Desinstalacion de MariaDb en el servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: JUN2021/SEPT2022
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES NECESARIAS
########################################################################
paquete=mariadb-server
########################################################################
########################################################################
# DESINSTALAR MARIADB         *
########################################################################
if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
then
    msg_desinstalando
    sudo apt-get purge mariadb-server -y
    sudo apt-get purge libdbd-mariadb-perl -y
    sudo apt-get purge libmariadb3:armhf -y
    sudo apt-get purge mariadb-client-10.5 -y
    sudo apt-get purge mariadb-client-core-10.5 -y
    sudo apt-get purge mariadb-common -y
    sudo apt-get purge mariadb-server -y
    sudo apt-get purge mariadb-server-10.5 -y
    sudo apt-get purge mariadb-server-core-10.5 -y

    sudo apt autoremove -y
    # sudo apt-get update && sudo apt-get -y upgrade
       
else
    clear
    msg_desinstalado
    sleep 2
fi
