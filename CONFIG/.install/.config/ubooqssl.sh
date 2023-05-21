#!/bin/bash

########################################################################
# Script: ubooqssl.sh
# Descripcion: Funcion para la actualizar el sistema del servidor ProyectoPy
# Argumentoss: N/A
#BASADO EN UN SCRIPT ORIGINAL DE IVAN TICHY 
#Creacion/Actualizacion: DIC2021/SEPT2022
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
# DIRECTORIO CERTIFICADOS LETSENCRIPT
certdir=/etc/letsencrypt/archive/proyectopy.duckdns.org/ #CAMBIA EL DOMINIO POR EL TUYO
# DIRECTORIO A CREAR PARA LA KEY.JSK DE UBOOQUITY
certdirdestino=/opt/ubooquity/certis/
# CLAVE DE LOS CERTIFICADOS GENERADOS EN LETSENCRIPT 
keystorepass=Ant4vi4n4
# CLAVE PARA LA KEY JSK A GENERAR 
keypass=Ant4vi4n4
#VARIABLES A MODIFICAR CON SED
########################################################################
# FUNCION GENERAR LA CLAVE A PARTIR DE LOS CERTIFICADOS REVISADO (OK)
########################################################################

# CREA EL DIRECTORIO PARA LA KEY.JSK DE UBOOQUITY
sudo mkdir $certdirdestino

#GENERA LA CLAVE A PARTIR DE LOS CERTIFICADOS DE LETSENCRYPT EXISTENTES 
openssl pkcs12 -export -in $certdir/fullchain1.pem -inkey $certdir/privkey1.pem -out $certdir/cert_and_key.p12 -name ubooq_key -CAfile $certdir/chain1.pem -caname root -password pass:$keypass
keytool -importkeystore -srcstorepass $keypass -deststorepass $keystorepass -destkeypass $keystorepass -srckeystore $certdir/cert_and_key.p12 -srcstoretype PKCS12 -alias ubooq_key -keystore $certdirdestino/ubooq_key.jks
keytool -import -trustcacerts -alias root -deststorepass $keystorepass -file $certdir/chain1.pem -noprompt -keystore $certdirdestino/ubooq_key.jks

#PARA EL SERVICIO DE UBOOQUITY
sudo systemctl stop eReader.service &>/dev/null

sudo sed -i 's/\"keystorePath\" : \"\"/\"keystorePath\" : \"\/opt\/ubooquity\/certis\/ubooq_key.jks\"/g' /opt/ubooquity/preferences.json
sudo sed -i 's/\"keystorePassword\" : \"\"/\"keystorePassword\" : \"Ant4vi4n4\"/g' /opt/ubooquity/preferences.json

sudo systemctl start eReader.service &>/dev/null
