#!/bin/bash

########################################################################
# Script: PhpMyAdmin.sh
# Descripcion: Instalacion de PhpMyAdmin en el servidor ProyectoPy
# Argumentoss: N/A
# Creacion/Actualizacion: JUN2021/AGO2021
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################

# -------------------------------------------------------
# Instalar PhpMyAdmin REVISADO
# -------------------------------------------------------

echo "******************************************"
echo "           Instalando PhpMyAdmin          *"
echo "******************************************"

    sleep 3
    echo "******************************************" 
    echo "Instala modulos necesarios para phpMyAdmin"
    echo "******************************************" 

    sudo apt -y install php-bz2 php-mbstring php-xml php-zip php7.4-mysqli
    sleep 1

    echo "******************************************" 
    echo "  Recargando Apache para aplicar cambios  "
    echo "******************************************" 
    
    sudo systemctl reload apache2
    sleep 3

   echo "******************************************" 
    echo " Descargamos phpMyadmin (5.1.1 Jul 2021) "
    echo "*****************************************"

    wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.xz

    sleep 3
    echo "******************************************"
    echo "  Extraer  phpMyadmin a /var/www/html/    "
    echo "******************************************"

    sudo tar xf phpMyAdmin-5.2.1-all-languages.tar.xz -C /var/www/html/

    sleep 3

    echo "******************************************"    
    echo "        Renombramos como phpmyadmin       "
    echo "         y damos permisos www-data.       "
    echo "******************************************" 
    
    sudo mv /var/www/html/phpMyAdmin-5.2.1-all-languages/ /var/www/html/phpmyadmin
    sudo chown www-data /var/www/html/phpmyadmin/

    sleep 3
    echo "******************************************"
    echo "   Preparar todo para su funcionamiento   "
    echo "******************************************"

    sudo touch /home/pi/phpmyadmin.sql
    sudo chown $USER:$USER /home/pi/phpmyadmin.sql
    sudo echo "CREATE USER $user_pma IDENTIFIED BY '$clave_pma';" >> /home/pi/phpmyadmin.sql
    sudo echo "GRANT ALL PRIVILEGES ON $pma_db.* TO $user_pma;" >> /home/pi/phpmyadmin.sql
    sudo echo "FLUSH PRIVILEGES;" >> /home/pi/phpmyadmin.sql
    sudo echo "EXIT" >> /home/pi/phpmyadmin.sql
    sleep 3
    echo "******************************************"   
    echo "      Modificamos la base de datos.       "
    echo "         Usa la clave de root.            "
    echo "******************************************"

    mysql -u root -p < phpmyadmin.sql

    sleep 3

    echo "******************************************"     
    echo "     Creamos las tablas de PhpMyAdmin     "
    echo "  usa la clave elegida para pma@localhost "
    echo "******************************************" 

    cat /var/www/html/phpmyadmin/sql/create_tables.sql | mysql -u pma -p
    sudo rm /home/pi/phpmyadmin.sql
    sudo rm /home/pi/phpMyAdmin-5.1.1-all-languages.tar.xz
    sleep 3
    echo "****************************************************"  
    echo "           Configura a tu gusto phpMyAdmin          "
    sleep 3
    echo "               Visita en tu navegador               "
    sleep 3
    echo "    \e[31mhttp://$hostname.local/phpmyadmin\e[0m    "
    echo "****************************************************" 
    
