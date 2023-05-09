#!/bin/bash

########################################################################
# Script: gitandjq.sh
# Descripcion: Instalar GII y JQ
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
export paqgit="git"
export paqjq="jq"
########################################################################
########################################################################
# INSTALAR GIT Y JQ PARA PODER CLONAR EL REPOSITORIO
########################################################################
function gitandjq (){
    install_git
    install_jq
}
function install_git() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' $paqgit 2>/dev/null \ | grep -q '^.i $';
    then
    cursor_off
    clear
    app_git
    yainstalado
    else
    # msg_instalando
    instalando
    app_git
    espere
    sudo apt-get install git -y &>/dev/null
    sleep 3 
    ins_ok 
    cursor_on
    sleep 3
    fi
}  
function install_jq() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' $paqjq 2>/dev/null \ | grep -q '^.i $';
    then
    cursor_off
    app_jq
    yainstalado
    else
    # msg_instalando
    instalando
    app_jq
    espere
    sudo apt-get install jq -y &>/dev/null
    sleep 3 
    ins_ok
    cursor_on 
    sleep 3
    fi
} 
gitandjq