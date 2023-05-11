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
paquete=nginx
########################################################################
########################################################################
# DESINSTALAR MARIADB         *
########################################################################
if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $';
then
    clear
    msg_desinstalando

    sudo apt-get purge $paquete -y &>/dev/null
    sudo apt autoremove -y &>/dev/null
    sudo apt purge nginx-common -y &>/dev/null

    msg_desinstalado

else
    clear
    msg_desinstalado
    sleep 2
fi





