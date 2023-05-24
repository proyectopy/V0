#!/bin/bash

########################################################################
# Script: ereader.sh
# Descripcion: Instalar eReader ubooquity
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
export hostname="$(cat /etc/hostname)"
export PATH_UBOOQUITY="/opt/ubooquity"
export ja="default-jdk"
export un="unzip"
export ereader="true"
export eReader="@reboot sleep 180 && cd $PATH_UBOOQUITY && nohup /usr/bin/java -jar $PATH_UBOOQUITY/Ubooquity.jar /opt/ubooquity/Ubooquity.jar --remoteadmin --headless"

########################################################################
# FUNCION INSTALAR UBOOQUITY
########################################################################
####################################################
#       COMPROBAR INSTALACION DE JAVA       
####################################################
function install_java() {
    
    sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/java.sh
    source /home/pi/.configuracion/.scripts/.install/.apps/java.sh
    
}    
####################################################
#      COMPROBAR INSTALACION DE UFW        
####################################################
function install_ufw() {
    
    sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
    source /home/pi/.configuracion/.scripts/.install/.apps/ufw.sh
    
}    
####################################################
#       COMPROBAR INSTALACION DE UNZIP        
####################################################
function install_unzip() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' $un 2>/dev/null \ | grep -q '^.i $';
    then
    clear
    app_unzip
    msg_instalado
    sleep 3 

    else
    msg_instalando
    app_unzip
    msg_espere
     
    sudo apt-get install unzip -y &>/dev/null
    
    msg_instalado
    fi
}    
   
####################################################
#            INSTALACION DEL EREADER        
####################################################
function install_eReader() {
    cursor_off
    clear
    msg_instalar
    app_ereader
    msg_espere
    
    msg_instalando                
    
    
    sudo mkdir -p /opt/ubooquity
    cd /opt/ubooquity
    sudo wget "http://vaemendis.net/ubooquity/service/download.php" -O ubooquity.zip &>/dev/null
    sudo unzip ubooquity*.zip &>/dev/null
    sudo rm ubooquity*.zip
    sudo chown -R pi:pi /opt/ubooquity
    #Crea el servicio de Ubooquity y su archivo
    sudo touch /etc/systemd/system/eReader.service
    sudo chown $USER:$USER /etc/systemd/system/eReader.service

    clear
    configurando_msg
    sleep 3

    sudo echo "[Unit]" >> /etc/systemd/system/eReader.service
    sudo echo "Description=Servidor de Ebooks con Ubooquity" >> /etc/systemd/system/eReader.service
    sudo echo "After=network.target" >> /etc/systemd/system/eReader.service
    sudo echo " " >> /etc/systemd/system/eReader.service
    sudo echo "[Service]" >> /etc/systemd/system/eReader.service
    sudo echo "WorkingDirectory=/opt/ubooquity" >> /etc/systemd/system/eReader.service
    sudo echo "User=root" >> /etc/systemd/system/eReader.service
    sudo echo "Group=root" >> /etc/systemd/system/eReader.service
    sudo echo "ExecStart=/usr/bin/java -jar /opt/ubooquity/Ubooquity.jar --remoteadmin --headless" >> /etc/systemd/system/eReader.service
    sudo echo "TimeoutStopSec=20" >> /etc/systemd/system/eReader.service
    sudo echo "KillMode=process" >> /etc/systemd/system/eReader.service
    sudo echo "Restart=on-failure" >> /etc/systemd/system/eReader.service
    sudo echo " " >> /etc/systemd/system/eReader.service
    sudo echo "[Install]" >> /etc/systemd/system/eReader.service
    sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/eReader.service
    sudo echo " " >> /etc/systemd/system/eReader.service
    
    clear
    msg_activando
    sleep 3

    # sudo systemctl daemon-reload &>/dev/null
    sudo systemctl enable eReader.service &>/dev/null
    sudo systemctl start eReader.service &>/dev/null

    msg_instalado
    msg_crontab
    sleep 3

    (crontab -u pi -l; echo "$eReader" ) | crontab -u pi -
    
    msg_abrirpuertos
    sleep 3
    #Abrimos Puertos 2202 2203 5483 5488
    sudo ufw allow 2203 &>/dev/null
    sudo ufw allow 2202 &>/dev/null
    sudo ufw allow 5483 &>/dev/null
    sudo ufw allow 5488 &>/dev/null


    sleep 3
                    
    echo "" 
    echo -ne "${F_VDOBLE}*********************************************"
    echo ""
    echo -ne "${F_VDOBLE}         Visita en tu navegador              "
    echo ""
    echo -ne "${F_VDOBLE}   \e[31mhttp://$hostname.local:2202\e[0m    "
    echo ""
    echo -ne "${F_VDOBLE}         y comprueba que funciona            "
    echo ""
    echo -ne "${F_VDOBLE}         configuralo accediendo a            "
    echo ""
    echo -ne "${F_VDOBLE}\e[31mhttp://$hostname.local:2203/admin\e[0m "
    echo ""
    echo -ne "${F_VDOBLE}*********************************************"
    echo ""
    
    clear
    msg_instalado
    cursor_on
    sleep 3
                                                  
} 

########################################################################
#  COMPROBAR INSTALACION DEL EREADER
########################################################################
function eReader() {
    clear
    if [ "$ereader" = true ]; then
        if [ -d /opt/ubooquity/ ];
        then
        clear
        app_ereader
        msg_yaesta
        msg_instalado
        else
        install_java
        install_unzip
        install_ufw
        install_eReader 
        fi
        else
        clear
        msg_sincambios
    fi
}
eReader           
   
               
