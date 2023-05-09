#!/bin/bash

########################################################################
# Script: ereader.sh
# Descripcion: Instalar Samba
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
export smb="true"
export paquete="samba"
export uf="ufw"
export dirpi="/smb/WinServer"
export dirwin="//192.168.1.60/eBooks"
export nombre="Wild South"
export usuario="pi"
export usuariowin="Wild"
export clave="Ant4vi4n4"
# export clave="$5$hOAQShHbJd$H7XtdiWyLOCP2HsGq38zmVpPVjJ4rxF4OwziXMZEgX9"
export wgroup="workgroup = 1NF3RN0"
########################################################################
#                   INSTALAR SAMBA
########################################################################
function install_smb() {
    
    cursor_off

    clear    
    msg_instalando
    app_samba
    msg_tarda
    msg_espere
    sudo rm /var/lib/dpkg/lock-frontend &>/dev/null
    sudo dpkg --configure -a &>/dev/null

    #Instalamos Samba
    sudo apt install -y samba samba-common-bin 
    #&>/dev/null
    
    clear
    msg_espere
    msg_abrirpuertos

    sudo ufw allow 445 &>/dev/null
    sudo ufw allow 137/udp &>/dev/null
    sudo ufw allow 138/udp &>/dev/null
    sudo ufw allow 139 &>/dev/null

    sleep 3

    configurando_msg
    app_samba
    sleep 3
    msg_espere

    #Damos permisos al archivo
    sudo cp /etc/samba/smb.conf /etc/samba/smb.old
    sudo chmod 777 /etc/samba/smb.conf
    #modifica el archivo /etc/samba/smb.conf

    # recuerda cambiar la variable wgroup por el nombre de tu  
    # workgroup/NT-domain para que samba forme parte de el
    
    sudo sed -i "s/workgroup = WORKGROUP/ workgroup = 1NF3RN0/g" /etc/samba/smb.conf
    sudo sed -i "s/ map to guest = bad user/ map to guest = never/g" /etc/samba/smb.conf
    sudo sed -i "s/ read only = yes/ read only = no/g" /etc/samba/smb.conf
    sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/samba/smb.conf
    sudo echo "[WinINPy]" >> /etc/samba/smb.conf
    sudo echo "     comment = Carpetas compartidas de Windows en Raspberry Pi" >> /etc/samba/smb.conf
    sudo echo "     path = $dirpi" >> /etc/samba/smb.conf
    sudo echo "     writeable = Yes" >> /etc/samba/smb.conf
    sudo echo "     create mask = 0777" >> /etc/samba/smb.conf
    sudo echo "     directory mask = 0777" >> /etc/samba/smb.conf
    sudo echo "     browseable = Yes" >> /etc/samba/smb.conf
    sudo echo "     valid users @users" >> /etc/samba/smb.conf
    sudo echo "     force user = pi" >> /etc/samba/smb.conf

    #CREAR CARPETA Y MONTAR CIFS EN FSTAB
    sudo mkdir -p $dirpi 

    sudo cp /etc/fstab /etc/fstab.old
    #sudo touch /etc/fstab
    sudo chown -R pi:pi /etc/fstab
    sudo chmod -R 770 /etc/fstab

    # Escribe el archivo fstab
    
    echo "$dirpi    $dirwin cifs user=$usuariowin,password=$clave,noexec,user,rw,nounix,uid=1000,iocharset=utf8 0 0" >> /etc/fstab
    
    sudo chown -R root:root /etc/fstab
    sudo chmod -R 644 /etc/fstab
    #sudo mount -t cifs //192.168.1.60/eBooks -o username=Wild,password=Ant4vi4n4 /smb/WinServer
    sudo mount -t cifs $dirwin -o username=$usuariowin,password=$clave $dirpi 
    
#fi



    #Crear usuario desatendido
    # sudo su | echo "$clave"
    # sudo echo -e "$clave\n$clave" | smbpasswd -a - $usuario
    # sudo echo "exit"
    #Final Crear usuario desatendido


    #Crear usuario
    # if id $usuario >/dev/null 2>&1; 
    # then 
    # echo "El usuario $usuario ya existe"
    #Crear directorio compartido
    # sudo mkdir -p $dir
    # sudo chown $usuario:$usuario $dir
    # sudo chmod 750 $dir

    # else 
    # echo "Vamos a crear el usuario " 
    # fi
    # sudo useradd -c "$nombre" -s /sbin/nologin $usuario
    # sudo passwd $usuario
    sudo smbpasswd -a $usuario

    #Crear directorio compartido
    # sudo mkdir -p $dir
    # sudo chown $usuario:$usuario $dir
    # sudo chmod 750 $dir

    sudo systemctl restart smbd nmbd
    
    sudo chmod 644 /etc/samba/smb.conf 
    msg_instalado
    
    cursor_on
}
####################################################
#      COMPROBAR INSTALACION DE UFW        
####################################################
function install_ufw() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' ufw 2>/dev/null \ | grep -q '^.i $';
    then
    app_ufw
    msg_error_instalado
    sleep 3

    else
    # msg_instalando
    # "$uf"
    echo "cambia al script ufw" 
    sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
    source /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
    sleep 6
    
    fi
}    
########################################################################
# FUNCION COMPROBAR INSTALACION DE SAMBA
########################################################################
function smb() {
    clear
    if [ $smb = true ]; then
        
        if dpkg-query -W -f'${db:Status-Abbrev}\n' $paquete 2>/dev/null \ | grep -q '^.i $'; 
        then 
        clear
        app_samba
        msg_yaesta
        msg_instalado
        else
        install_ufw
        install_smb
        fi
        else
        clear
        msg_sincambios
    fi
}
smb           
   