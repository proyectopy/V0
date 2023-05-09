#!/bin/bash

########################################################################
# Script: funciones.sh
# Descripcion: Funciones para Instalacion del servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# # # Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
# Hay que probar
########################################################################
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
# source .configuracion/.scripts/.files/mensajes.sh
########################################################################
########################################################################
# VARIABLES DE LOS COLORES
########################################################################
verde='\e[32m'
amarillo='\e[33m'
azul='\e[34m'
azulclaro='\e[36m'
rojo='\e[31m'
claro='\e[0m'
########################################################################
# FUNCIONES A USAR
########################################################################
########################################################################
# VARIABLES QUE SE USAN
export DIRECTCLONAR=/home/pi/V0
# TAMAÑO DEL TEXTO
F_VDOBLE="\033#6"
########################################################################
########################################################################
# FUNCION CENTRAR
########################################################################
centrar() {
    [[ $# == 0 ]] && return 1

    declare -i TERM_COLS="$(tput cols)"
    declare -i str_len="${#1}"
    [[ $str_len -ge $TERM_COLS ]] && {
        echo "$1"
        return 0
    }

    declare -i filler_len="$(((TERM_COLS - str_len) / 2))"
    [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
    filler=""
    for ((i = 0; i < filler_len; i++)); do
        filler="${filler}${ch}"
    done

    printf "%s%s%s" "$filler" "$1" "$filler"
    [[ $(((TERM_COLS - str_len) % 2)) -ne 0 ]] && printf "%s" "${ch}"
    printf "\n"

    return 0
}
########################################################################
# FUNCIONES ASPECTO
########################################################################
cursor_off() {
    tput civis                  # cursor invisible
}
cursor_on() {
    tput cnorm                  # cursor normal
}
ColorVerde() {
    echo -ne $verde$1$claro
}
ColorAmarillo() {
    echo -ne $amarillo$1$claro
}
ColorAzul() {
    echo -ne $azul$1$claro
}
ColorAzulClaro() {
    echo -ne $azulclaro$1$claro
}
ColorRojo() {
    echo -ne $rojo$1$claro
}

########################################################################
# FUNCIONES APPS 
########################################################################
function script(){                            
    centrar " "
    centrar "  ____   ___  ____  __  ____  ____  "
    centrar " / ___) / __)(  _ \(  )(  _ \(_  _) "
    centrar " \___ \( (__  )   / )(  ) __/  )(   "
    centrar " (____/ \___)(__\_)(__)(__)   (__)  "
    centrar " "
}
function app_git(){                            
    centrar " "
    centrar "   ___  __  ____ "
    centrar "  / __)(  )(_  _)"
    centrar " ( (_ \ )(   )(  "
    centrar "  \___/(__) (__) "
    centrar " "
}
function app_jq(){                            
    centrar " "
    centrar "    __   __   "
    centrar "  _(  ) /  \  "
    centrar " / \) \(  O ) "
    centrar " \____/ \__\) "
    centrar " "
}
function descargando(){                            
    centrar " "
    centrar "  ____  ____  ____   ___   __   ____   ___   __   __ _  ____   __   "
    centrar " (    \(  __)/ ___) / __) / _\ (  _ \ / __) / _\ (  ( \(    \ /  \  "
    centrar "  ) D ( ) _) \___ \( (__ /    \ )   /( (_ \/    \/    / ) D ((  O ) "
    centrar " (____/(____)(____/ \___)\_/\_/(__\_) \___/\_/\_/\_)__)(____/ \__/  "
    centrar " "
    centrar " "
}
function descargado(){ 
    centrar " "                           
    centrar "  ____  ____  ____   ___   __   ____   ___   __   ____   __   "
    centrar " (    \(  __)/ ___) / __) / _\ (  _ \ / __) / _\ (    \ /  \  "
    centrar "  ) D ( ) _) \___ \( (__ /    \ )   /( (_ \/    \ ) D ((  O ) "
    centrar " (____/(____)(____/ \___)\_/\_/(__\_) \___/\_/\_/(____/ \__/  "
    centrar " "
}
function directorio(){ 
    centrar " "                           
    centrar "  ____  __ _    _  _   __   _  _  ____    _  ____  __    _  _  _   __  " 
    centrar " (  __)(  ( \  / )( \ /  \ ( \/ )(  __)  / )(  _ \(  )  / )/ )( \ /  \ " 
    centrar "  ) _) /    /  ) __ ((  O )/ \/ \ ) _)  / /  ) __/ )(  / / \ \/ /(  0 )" 
    centrar " (____)\_)__)  \_)(_/ \__/ \_)(_/(____)(_/  (__)  (__)(_/   \__/  \__/ " 
    centrar " "
}
function yainstalado(){ 
    centrar " "                           
    centrar "  _  _  __     __  __ _  ____  ____  __   __     __   ____   __   "
    centrar " ( \/ )/ _\   (  )(  ( \/ ___)(_  _)/ _\ (  )   / _\ (    \ /  \  "
    centrar "  )  //    \   )( /    /\___ \  )( /    \/ (_/\/    \ ) D ((  O ) "
    centrar " (__/ \_/\_/  (__)\_)__)(____/ (__)\_/\_/\____/\_/\_/(____/ \__/  "
    centrar " "
}
function instalando(){ 
    centrar " "                           
    centrar "  __  __ _  ____  ____  __   __     __   __ _  ____   __   "
    centrar " (  )(  ( \/ ___)(_  _)/ _\ (  )   / _\ (  ( \(    \ /  \  "
    centrar "  )( /    /\___ \  )( /    \/ (_/\/    \/    / ) D ((  O ) "
    centrar " (__)\_)__)(____/ (__)\_/\_/\____/\_/\_/\_)__)(____/ \__/  "
    centrar " "
}
function des_ok(){ 
    centrar " " 
    centrar "  ____  ____  ____  __  __ _  ____  ____  __   __     __   ____   __      __  __ _  "
    centrar " (    \(  __)/ ___)(  )(  ( \/ ___)(_  _)/ _\ (  )   / _\ (    \ /  \    /  \(  / ) "
    centrar "  ) D ( ) _) \___ \ )( /    /\___ \  )( /    \/ (_/\/    \ ) D ((  O )  (  O ))  (  "
    centrar " (____/(____)(____/(__)\_)__)(____/ (__)\_/\_/\____/\_/\_/(____/ \__/    \__/(__\_) "
    centrar " "
}

function ins_ok(){ 
    centrar " "                           
    centrar "  __  __ _  ____  ____  __   __     __    ___  __  __   __ _     __  __ _  "
    centrar " (  )(  ( \/ ___)(_  _)/ _\ (  )   / _\  / __)(  )/  \ (  ( \   /  \(  / ) "
    centrar "  )( /    /\___ \  )( /    \/ (_/\/    \( (__  )((  O )/    /  (  O ))  (  "
    centrar " (__)\_)__)(____/ (__)\_/\_/\____/\_/\_/ \___)(__)\__/ \_)__)   \__/(__\_) "
    centrar " "
}
function configurar(){ 
    centrar " "                           
    centrar "        ___  __   __ _  ____  __  ___  _  _  ____   __   ____        "  
    centrar "       / __)/  \ (  ( \(  __)(  )/ __)/ )( \(  _ \ / _\ (  _ \       "  
    centrar "  _  _( (__(  O )/    / ) _)  )(( (_ \) \/ ( )   //    \ )   / _  _  "  
    centrar " (_)(_)\___)\__/ \_)__)(__)  (__)\___/\____/(__\_)\_/\_/(__\_)(_)(_) "  
    centrar " "
}
function permisos(){ 
    centrar " "                           
    centrar "        ____  ____  ____  _  _  __  ____   __   ____        "  
    centrar "       (  _ \(  __)(  _ \( \/ )(  )/ ___) /  \ / ___)       "  
    centrar "  _  _  ) __/ ) _)  )   // \/ \ )( \___ \(  O )\___ \ _  _  "  
    centrar " (_)(_)(__)  (____)(__\_)\_)(_/(__)(____/ \__/ (____/(_)(_) "   
    centrar " "
}
function ejecutar(){ 
    centrar " "                           
    centrar "        ____    __  ____  ___  _  _  ____  __   ____       "  
    centrar "       (  __) _(  )(  __)/ __)/ )( \(_  _)/ _\ (  _ \      "  
    centrar "  _  _  ) _) / \) \ ) _)( (__ ) \/ (  )( /    \ )   / _  _ "  
    centrar " (_)(_)(____)\____/(____)\___)\____/ (__)\_/\_/(__\_)(_)(_)"  
    centrar " "
}
function mantener(){ 
    centrar " "                           
    centrar "            _  _   __   __ _  ____  ____  __ _  ____  ____          "
    centrar "           ( \/ ) / _\ (  ( \(_  _)(  __)(  ( \(  __)(  _ \         "
    centrar "           / \/ \/    \/    /  )(   ) _) /    / ) _)  )   /         "
    centrar "           \_)(_/\_/\_/\_)__) (__) (____)\_)__)(____)(__\_)         "
    centrar "   __   ____  __    __  ___   __    ___  __  __   __ _  ____  ____  "
    centrar "  / _\ (  _ \(  )  (  )/ __) / _\  / __)(  )/  \ (  ( \(  __)/ ___) "
    centrar " /    \ ) __// (_/\ )(( (__ /    \( (__  )((  O )/    / ) _) \___ \ "
    centrar " \_/\_/(__)  \____/(__)\___)\_/\_/ \___)(__)\__/ \_)__)(____)(____/ "
    centrar " "
}
function espere(){
    centrar " "
    centrar "           ____  ____  ____  ____  ____  ____           "  
    centrar "          (  __)/ ___)(  _ \(  __)(  _ \(  __)          "  
    centrar "  _  _  _  ) _) \___ \ ) __/ ) _)  )   / ) _)  _  _  _  "  
    centrar " (_)(_)(_)(____)(____/(__)  (____)(__\_)(____)(_)(_)(_) "  
}   
########################################################################
# FUNCIONES QUE REALIZA
########################################################################
function comprueba() {
    if [ -d "$DIRECTCLONAR" ]
        then
            clear
            cursor_off
            descargado
            script
            directorio
            sleep 2
            clear
            cursor_on
            if dpkg-query -W -f'${db:Status-Abbrev}\n' git 2>/dev/null \ | grep -q '^.i $';
            then
            uninstall_apps
            else
            clear
            continue_install
            fi
        else
            clear
            install_git
            sleep 2
            clear
            install_jq
            sleep 2
            clear
            clone_repo
            sleep 2
            clear
            uninstall_apps
            sleep 2
            clear
            continue_install

        fi
}
########################################################################
# INSTALAR GIT PARA PODER CLONAR EL REPOSITORIO
########################################################################
# INSTALAR GIT Y JQ PARA PODER CLONAR EL REPOSITORIO
########################################################################
function install_git() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' git 2>/dev/null \ | grep -q '^.i $';
    then
    cursor_off
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
    if dpkg-query -W -f'${db:Status-Abbrev}\n' jq 2>/dev/null \ | grep -q '^.i $';
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
########################################################################
# CLONAR EL REPOSITORIO
########################################################################
function clone_repo() {
    cursor_off
    descargando
    git clone https://github.com/proyectopy/V0.git &>/dev/null
    sleep 2 
    descargado
    sleep 2
    directorio
    sleep 4
    cursor_on
}
########################################################################
# OPCION DESINSTALAR 
########################################################################
function uninstall_apps() {
    default="SI"
    mantener

    echo ""
    echo -ne " ${F_VDOBLE}Quieres Mantener GIT y JQ (Recomendado) [Si/No]: [$default] "
    read uninstall
    uninstall="${uninstall:-$default}"

    echo ""
    echo -ne " ${F_VDOBLE}Has elegido que $uninstall quieres mantener las aplicaciones"
    sleep 3
    if [ $uninstall != $default ]
        then
        cursor_off
        sleep 3
        espere
        sudo apt-get purge git -y &>/dev/null
        sudo apt-get purge jq -y &>/dev/null
        des_ok
        cursor_on
        else
        sleep 3
        continue_install
    fi

}
########################################################################
# EJECUTA SCRIPT DESCARGADO
########################################################################
function continue_install (){
    
    # configurar
    # sleep 6
    cursor_off
    sudo chmod -x /home/pi/V0/CONFIG/conf.sh
    source /home/pi/V0/CONFIG/conf.sh
    cursor_on
}
########################################################################
# INICIAR SCRIPT
########################################################################
comprueba
#clone_repo
