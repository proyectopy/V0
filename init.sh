#!/bin/bash

###################################################################
# init.sh
# Mensajes de telegram desde Raspberry
###################################################################
###################################################################
# VARIABLES
###################################################################
SENSOR="`/usr/bin/vcgencmd measure_temp | cut -d "=" -f2 | cut -d "'" -f1`"
# -gt only deals with whole numbers, so round it.
TEMP="`/usr/bin/printf "%.0f\n" ${SENSOR}`"
# How hot will we allow the SoC to get?
MAX="70"
TOKEN="5696349679:AAGx927n7rYAlVsc-ertHExp1wpnXreCWHE"
ID="5564671937"
ID_HUMAN="@RaspyServer"
TEMPERATURA="La raspberry de ProyectoPy Server se acaba de apagar por exceso de calor Su temperatura es de $TEMP ºC."
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
dt=`date +%d%m%Y_%H%M%S`
AUTOSHUT_TIT="#CRONTAB PARA AUTOSHUT Y AVISO POR TEMP ELEVADA"
AUTOSHUT_CONT="*/5 * * * * /home/pi/.configuracion/.telegram/autoshut.sh >/dev/null 2>&1"
AUTOREBOOT_TIT="#CRONTAB PARA AVISO A TELEGRAM DE REBOOT"
AUTOREBOOT_CONT="@reboot ( sleep 30 ; sh /home/pi/.configuracion/.telegram/reboot.sh >/dev/null 2>&1"
###################################################################
function carpetas(){                            
    # Creamos el directorio
    sudo mkdir -p /home/pi/.configuracion/.telegram/
    sudo mkdir -p /home/pi/.configuracion/.cron/
    sudo mkdir -p /home/pi/.configuracion/.cds/
}
function scr_temperaturas(){  

    # Creamos el archivo
    sudo touch /home/pi/.configuracion/.telegram/temperaturas
    # Permieos de escritura
    sudo chown pi:pi /home/pi/.configuracion/.telegram/temperaturas
    sudo chmod 777 /home/pi/.configuracion/.telegram/temperaturas

    # #  permisos de ejecucuin
    # sudo chmod +x /home/pi/.configuracion/.telegram/temperaturas

    #Escribe el archivo temperaturas
    sudo echo "#!/bin/bash" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "# Shell script: temp.sh" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "# Autor: Santiago Crespo - Modificado por Wild" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "#" >> /home/pi/.configuracion/.telegram/temperaturas
    # sudo echo "act=\`date +%d%m%Y\`" >> updater
    sudo echo "cpu=\$(cat /sys/class/thermal/thermal_zone0/temp)" >> /home/pi/.configuracion/.telegram/temperaturas
    # sudo echo "echo Script ejecutado el \$dt >> /home/pi/.configuracion/.scripts/.actualizaciones/.logs/ejecuciones_\$act.log ">> updater
    sudo echo "sudo echo \"Equipo => \$(hostname)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"\$(date)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"------------------------------"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"Temp.CPU => \$((cpu/1000))'Cº"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"Temp.GPU => \$(/usr/bin/vcgencmd measure_temp)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"------------------------------"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo\"CPU"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"\$(vcgencmd measure_clock arm)Hz"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"\$(vcgencmd measure_volts core)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"Mem. del Sistema \$(vcgencmd get_mem arm)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"Mem. de la \$(vcgencmd get_mem gpu)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"------------------------------"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"Consumo de memoria"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"$(egrep --color 'Mem|Cache|Swap' /proc/meminfo)"\" >> /home/pi/.configuracion/.telegram/temperaturas
    sudo echo "sudo echo \"------------------------------"\" >> /home/pi/.configuracion/.telegram/temperaturas
    # Permieos de escritura originales
    sudo chmod 644 /home/pi/.configuracion/.telegram/temperaturas
    # permisos de ejecucion
    sudo chmod +x /home/pi/.configuracion/.telegram/temperaturas
    # Creamos el simlink
    sudo ln -s /home/pi/.configuracion/.telegram/temperaturas /usr/bin

    # Ejecutamos el script
    #clear
    #source /home/pi/.configuracion/.telegram/temperaturas
}
function scr_autoshut(){   

    # Creamos el archivo
    sudo touch /home/pi/.configuracion/.telegram/autoshut.sh
    # Permieos de escritura
    sudo chown pi:pi /home/pi/.configuracion/.telegram/autoshut.sh
    sudo chmod 777 /home/pi/.configuracion/.telegram/autoshut.sh
    
    #Escribe el archivo autoshut.sh
    # sudo echo "cpu=\$(cat /sys/class/thermal/thermal_zone0/temp)" # EJEMPLO
    sudo echo "#!/bin/bash" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "###################################">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "#VARIABLES">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "###################################">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "SENSOR=\"\`/usr/bin/vcgencmd measure_temp | cut -d \"=\" -f2 | cut -d \"'\" -f1\`"\" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "TEMP=\"\`/usr/bin/printf \"%.0f\n\" \${SENSOR}\`"\">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "MAX=\"75\"" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "TOKEN=\"5696349679:AAGx927n7rYAlVsc-ertHExp1wpnXreCWHE"\" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "ID=\"@RaspyServer"\" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "MENSAJE=\"La raspberry de ProyectoPy Server se acaba de apagar por exceso de calor Su temperatura es de \$TEMP ºC. \\n Espera un tiempo prudencial para que se enfríe antes de encenderla de nuevo."\">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "URL=\"https://api.telegram.org/bot\$TOKEN/sendMessage"\" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "if [ \"\${TEMP}\" -gt \"\${MAX}\" ] ; then" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "###################################">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "#ENVIAMOS EL MENSAJE">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "###################################">> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "curl -s -X POST \$URL -d chat_id=\$ID -d text=\"\$MENSAJE"\" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "################################### " >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "#APAGAMOS EL EQUIPO" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "###################################" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "sudo /sbin/shutdown -h now " >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "else" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "     exit 0" >> /home/pi/.configuracion/.telegram/autoshut.sh
    sudo echo "fi" >> /home/pi/.configuracion/.telegram/autoshut.sh

    # Añadimos tarea al crontab
    crontab -l >> cron.original.$dt 
    (crontab -l -u pi; echo "$AUTOSHUT_TIT")  | crontab -u pi -
    (crontab -l -u pi; echo "$AUTOSHUT_CONT") | crontab -u pi -
    crontab -l >> cron.nuevo.$dt
    sudo mv cron* /home/pi/.configuracion/.cron/

    # Ejecutamos el script
    # clear
    # source /home/pi/.configuracion/.telegram/autoshut.sh
}
function scr_reboot(){                            
    
    # Creamos el archivo reboot.sh
    sudo touch /home/pi/.configuracion/.telegram/reboot.sh
    # Permieos de escritura
    sudo chown pi:pi /home/pi/.configuracion/.telegram/reboot.sh
    sudo chmod 777 /home/pi/.configuracion/.telegram/reboot.sh

    #  permisos de ejecucuin
    sudo chmod +x /home/pi/.configuracion/.telegram/reboot.sh

    #Escribe el archivo reboot.sh
    sudo echo "#!/bin/bash" >> /home/pi/.configuracion/.telegram/reboot.sh
    # sudo echo "cpu=\$(cat /sys/class/thermal/thermal_zone0/temp)"
    sudo echo "TOKEN=\"5696349679:AAGx927n7rYAlVsc-ertHExp1wpnXreCWHE"\" >> /home/pi/.configuracion/.telegram/reboot.sh
    sudo echo "ID=\"5564671937"\" >> /home/pi/.configuracion/.telegram/reboot.sh
    sudo echo "MENSAJE=\"La raspberry de ProyectoPy Server se acaba de encender."\">> /home/pi/.configuracion/.telegram/reboot.sh
    sudo echo "URL=\"https://api.telegram.org/bot\$TOKEN/sendMessage"\" >> /home/pi/.configuracion/.telegram/reboot.sh
    sudo echo "curl -s -X POST \$URL -d chat_id=\$ID -d text=\"\$MENSAJE"\" >> /home/pi/.configuracion/.telegram/reboot.sh
    
    # Añadimos tarea al crontab
    crontab -l >> cron.original.$dt 
    (crontab -l -u pi; echo "$AUTOREBOOT_TIT")  | crontab -u pi -
    (crontab -l -u pi; echo "$AUTOREBOOT_CONT") | crontab -u pi -
    crontab -l >> cron.nuevo.$dt
    sudo mv cron* /home/pi/.configuracion/.cron/

    
    # Ejecutamos el script
    # clear
    # source /home/pi/.configuracion/.telegram/reboot.sh
}
function scr_bashrc(){                            

    # Programando el bashrc para aviso por conexion ssh
    sudo sed -i '/curl -s/d' /home/pi/.bashrc
    sudo cp /home/pi/.bashrc /home/pi/.configuracion/.cds/.bashrc
    sudo echo "curl -s -X POST $URL -d chat_id=\"$ID_HUMAN\" -d text=\"Alguien se acaba de conectar a la Raspberry por ssh con la IP \$(echo \$SSH_CLIENT | awk '{ print \$1}'). ¿Serás tú?\">/dev/null 2>&1" >> /home/pi/.bashrc
}
########################################################################
# INSTALAR GIT PARA PODER CLONAR EL REPOSITORIO
########################################################################
# INSTALAR GIT Y JQ PARA PODER CLONAR EL REPOSITORIO
########################################################################
function install_git() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' git 2>/dev/null \ | grep -q '^.i $';
    then
    echo ".... GIT YA INSTALADO ...."
    sleep 3
    else
    echo ".... INSTALANDO ESPERE ...."
    sudo apt-get install git -y &>/dev/null
    sleep 3 
    echo ".... INSTALACION DE GIT OK ...."
    cursor_on
    sleep 3
    fi
}  
function install_jq() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' jq 2>/dev/null \ | grep -q '^.i $';
    then
    echo ".... JQ YA INSTALADO ...."
    sleep 3
    else
    # msg_instalando
    echo ".... INSTALANDO ESPERE ...."
    sudo apt-get install jq -y &>/dev/null
    sleep 3 
    echo ".... INSTALACION DE JQ OK ...."
    cursor_on 
    sleep 3
    fi
}
function install_setuptools() {
    if dpkg-query -W -f'${db:Status-Abbrev}\n' python-setuptools 2>/dev/null \ | grep -q '^.i $';
    then
    echo ".... PYTON SETUP TOOLS YA INSTALADO ...."
    sleep 3 
    echo " entramos en el setup " 
    sleep 3
    sudo python setup.py install
    else
    # msg_instalando
    echo ".... INSTALANDO ESPERE ...."
    sudo apt-get install python-setuptools -y &>/dev/null
    sleep 3 
    echo ".... INSTALACION DE PYTON SETUP TOOLS OK ...."
    cursor_on 
    sleep 3
    fi
}
function botapi_clone(){  

    install_git
    install_jq                          
    
    git clone https://github.com/eternnoir/pyTelegramBotAPI
    

    sudo mv pyTelegramBotAPI/   /home/pi/.configuracion/.telegram/BotApi

    sleep 5

    install_setuptools

    if dpkg-query -W -f'${db:Status-Abbrev}\n' python-setuptools 2>/dev/null \ | grep -q '^.i $'; 
        then
        echo " Ya esta instalado python-setuptools "
        sleep 3 
        echo " entramos en el setup " 
        sleep 3
        sudo python setup.py install

        cd /home/pi/.configuracion/.telegram/BotApi
        git checkout 3.6.6
        sudo touch bot_pihole.py
        sudo mv bot_pihole.py /home/pi/.configuracion/.telegram/BotApi
        

        else 
        echo " Instalaremos python-setuptools "
        sleep 3
        sudo apt-get install python-setuptools

    fi   
}
# carpetas
# scr_bashrc
# scr_temperaturas
# scr_autoshut
# scr_reboot
# scr_crontab
# botapi_clone
    



    
    

    

