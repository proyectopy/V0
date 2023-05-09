#!/bin/bash

########################################################################
# Script: backupraspi.sh
# Descripcion: Funcion copia de seguridad SD servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
# Tareas; Descomentar reinicio linea 64
########################################################################
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/.configuracion/.scripts/.files/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
act=`date +%d%m%Y`
########################################################################
# FUNCION RESTAURAR REVISADO DESCOMENTAR REINICIO
########################################################################
function backup() {
    clear
    # Desmonta la tarjeta
    sudo umount /dev/mmcblk0p1
    # Si no existe crea el directorio de backups
    sudo mkdir -p /mnt/RaspberryPi/Samba/Backups
    # Realiza la copia de seguridad
    sudo dd if=/dev/mmcblk0 of=/mnt/RaspberryPi/Samba/Backups/cds_$act.dd bs=4M status=progress; sync

    cds=$(sha1sum /mnt/RaspberryPi/Samba/Backups/cds_$act.dd)
    dev=$(sha1sum /dev/mmcblk0)

    if [ "$cds" = "$dev" ]; then
        echo "Files are the same!"
    else
        echo "Files are different!"
    fi
}
# function backup() {
    # clear
    # # Desmonta la tarjeta
    # sudo umount /dev/mmcblk0p1
    # # Si no existe crea el directorio de backups
    # sudo mkdir -p /mnt/RaspberryPi/Samba/Backups
    # # Realiza la copia de seguridad
    # sudo dd if=/dev/mmcblk0 of=/mnt/RaspberryPi/Samba/Backups/cds_$act.dd bs=4M status=progress; sync
    # emails_$act.log 
    # sudo sha1sum cds_$act.dd >> resultado_cds.txt  #f64c68ddd592979aa5d944b02cd9aeab90e9d1a0  cds_20170714.dd
    
    # cds = sed '/ /s/ .*//' resultado_cds.txt

    # sudo sha1sum /dev/mmcblk0 >> resultado_dev.txt

    # dev = sed '/ /s/ .*//' resultado_dev.txt

    # if [[ $cds == $dev ]]
    # then
    #      sudo tar -czvf /mnt/RaspberryPi/Samba/Backups/cds_$act.tar.gz /mnt/RaspberryPi/Samba/Backups/cds_$act.dd
    # else
    #     sudo rm cds_$act.dd
    #     sudo dd if=/dev/mmcblk0 of=/mnt/RaspberryPi/Samba/Backups/cds_$act.dd bs=4M status=progress; sync
    #     sleep 3 

    # fi
    
# }
########################################################################
# FIN FUNCION RESTAURAR
########################################################################
backup