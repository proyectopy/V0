#!/bin/bash

########################################################################
# Script: updateraspy.sh
# Descripcion: Funcion para la actualizar el sistema del servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.1
# Author: Wildsouth
# Email: wildsout@gmail.com
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
# DIRECTORIO CONFIGURACION
DIRECTORIOCONF=/home/pi/.configuracion/.scripts/
# DIRECTORIO ACTUALIZACION
DIRECTORIOACT=/home/pi/.configuracion/.scripts/.actualizaciones
# TEXTO DEL CRONTAB
updater="00 15 * * * /bin/bash /home/pi/.configuracion/.scripts/.actualizaciones/updater"
########################################################################
# FUNCION ACTUALIZAR REVISADO (OK)
########################################################################
function actualizar() {
    if [ -d "$DIRECTORIOACT" ]
        then
            clear
            msg_error_actualizado
            # sleep 3
        else
            install_sendmail
            sleep 4
    fi
}

function install_sendmail() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' ssmtp 2>/dev/null \ | grep -q '^.i $';
    then
    echo "Sendmail ya esta instalado"
    existe
    else

    sudo chmod +x /home/pi/.configuracion/.scripts/.install/.apps/sendmail.sh
    source /home/pi/.configuracion/.scripts/.install/.apps/sendmail.sh
    sleep 4
    
    fi
} 
function existe() {
    actualizar=true
    cursor_off
        if [ "$actualizar" = true ]; 
            then
            echo "se ejecuta existe"
                clear

                msg_automatizando
                msg_espere

                sudo mkdir /home/pi/.configuracion/.scripts/.actualizaciones
                sudo chown pi:pi /home/pi/.configuracion/.scripts/.actualizaciones/
                sudo mkdir -p /home/pi/.configuracion/.scripts/.actualizaciones/.logs/
                sudo chown pi:pi /home/pi/.configuracion/.scripts/.actualizaciones/.logs/
                
                sudo touch updater
                sudo chown pi:pi updater
            
                sudo chmod +x updater
                #Escribe el archivo updater
                sudo echo "########################################################################" >> updater
                sudo echo "# SCRIPS NECESARIOS" >> updater
                sudo echo "########################################################################" >> updater
                sudo echo "source .configuracion/.scripts/.files/funciones.sh" >> updater
                sudo echo "########################################################################" >> updater
                sudo echo "########################################################################" >> updater
                sudo echo "# Script: updater                                                    " >> updater
                sudo echo "# Descripcion: Configuracion del cron para actualizaciones semanales    "  >> updater
                sudo echo "########################################################################" >> updater
                sudo echo "#" >> updater
                sudo echo "act=\`date +%d%m%Y\`" >> updater
                sudo echo "dt=\`date +'%A, %d del %m de %Y a las %H:%M ' \` " >> updater
                sudo echo "#" >> updater
                sudo echo "sudo apt-get update >/dev/null >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/update.log" >> updater
                sudo echo "sudo apt-get upgrade >/dev/null -y >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/upgrade.log" >> updater
                sudo echo "sudo apt-get autoremove >/dev/null -y >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/autoremove.log" >> updater
                sudo echo "sudo rpi-update -y >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/rpi-update.log" >> updater
                sudo echo "#" >> updater
                sudo echo "echo Script ejecutado el \$dt >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/ejecuciones_\$act.log ">> updater
                
                sudo echo "sudo sendmail -t < /home/pi/.configuracion/.scripts/.files/.mail_templates/update.html">> updater
        
                sudo echo "echo Hemos enviado un emal el \$dt >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/emails_\$act.log ">> updater
                
                #Situa en su directorio definitivo el archivo updater
                sudo mv updater /home/pi/.configuracion/.scripts/.actualizaciones

                #crea el crontab
                (crontab -u pi -l; echo "$updater" ) | crontab -u pi -

                #ejecuta por primera vez el archivo updater
                clear
                msg_espere
                source /home/pi/.configuracion/.scripts/.actualizaciones/updater
                
                
                # sleep 3
                # msg_actualizado
                # sleep 3
            else
            echo "Volvemos al menu"    
        fi
        cursor_on     
}

########################################################################
# FIN FUNCION ACTUALIZAR
########################################################################
actualizar