#!/bin/bash

########################################################################
# Script:mounthdd.sh
# Descripcion: Configurar el montaje del Hdd externo
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
##########################
# MONTAR PARTICIONES (OK)
##########################
cursor_off
clear
msg_montando

sudo mkdir -p /mnt/RaspberryPi/
sudo mkdir -p /mnt/RaspberryPi/Emby
sudo mkdir -p /mnt/RaspberryPi/Samba
# sudo mkdir -p /mnt/4TB/
# sudo mkdir -p /mnt/4TB/DATOS
# sudo mkdir -p /mnt/4TB/MULTIMEDIA

#cambiar usuario y asignar permisos a todos los archivos de un directorio
sudo chown -R pi:pi /mnt/RaspberryPi
sudo chmod -R 770 /mnt/RaspberryPi

# sudo chown -R pi:pi /mnt/4TB
# sudo chmod -R 770 /mnt/4TB

sudo umount /dev/sda1 &>/dev/null
sudo umount /dev/sda2 &>/dev/null

# montar hdd formato mount -t type device destination_dir
# sudo mount /dev/sda1 /mnt/RaspberryPi/MULTIMEDIA 
# sudo mount /dev/sda2 /mnt/RaspberryPi/DATOS

# #CONFIGURAR AUTOMONTAJE


if [ -f /etc/fstab ];then
    msg_espere

    msg_fstab
    echo -ne "${F_VDOBLE}El fichero fstab existe y crearemos una copia de respaldo fstab.old" 
    echo -ne " "
    sleep 3
    sudo cp /etc/fstab /etc/fstab.old
elif [ -f /etc/fstab.old ];
then
    
    msg_espere

    msg_fstab
    echo -ne "${F_VDOBLE}Como tenemos una copia de respaldo vamos a restaurarla"
    
    echo -ne ""
    sleep 3
    sudo cp /etc/fstab.old /etc/fstab
    sudo chown -R pi:pi /etc/fstab
    sudo chmod -R 770 /etc/fstab
 
else
    msg_espere

    msg_fstab
    echo -ne "${F_VDOBLE}No tenemos copia de respaldo por lo que creamos y editamos un nuevo archivo fstab"
    sleep 3
    echo -ne ""
    sudo touch /etc/fstab
    sudo chown -R pi:pi /etc/fstab
    sudo chmod -R 770 /etc/fstab

    # Escribe el archivo fstab

    echo "proc            /proc           proc    defaults          0       0" >> /etc/fstab
    echo "PARTUUID=ba616027-01  /boot           vfat    defaults,flush    0       2" >> /etc/fstab
    echo "PARTUUID=ba616027-02  /               ext4    defaults,noatime  0       1" >> /etc/fstab
    echo " " >> /etc/fstab
    echo "UUID=3763f20c-1ddc-40ca-a03d-9a89f4db66e6 /mnt/RaspberryPi/Emby ext4 defaults,auto,users,rw,nofail 0 0" >> /etc/fstab
    echo "UUID=73928ae3-6f90-4f83-9ba0-05db513fec32 /mnt/RaspberryPi/Samba ext4 defaults,auto,users,rw,nofail 0 0" >> /etc/fstab
    
    sudo chown -R root:root /etc/fstab
    sudo chmod -R 644 /etc/fstab
    sudo cp /etc/fstab /etc/fstab.old
fi

# montar hdd formato mount -t type device destination_dir

#sudo mount /dev/sda1 /mnt/RaspberryPi/Emby &>/dev/null
#udo mount /dev/sda2 /mnt/RaspberryPi/Samba &>/dev/null

clear
msg_montadas
sleep 3
cursor_on
# sudo init 6











    
