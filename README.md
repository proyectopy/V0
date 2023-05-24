<p align="center"><img src="https://i.ibb.co/2k80X7C/logo-sync.png" alt="Logo" width="200"/></p>

# Proyecto Py

_Proyecto de creación de un servidor privado en una raspberry pi._

_He creado unos scripts en bash que pretende facilitar ese proceso. Y despues de un arduo trabajo estoy consiguiendo que este proceso está ahora completamente automatizado._ 
_Hay un script principal que mas que nada controla las versiones y cuatro carpetas que alojan las funciones los templates de emails, las apps que se instalan, los menus del script y la última carpeta los scripts para desinstalacion de aplicaciones._


## El Script 📋


_El script se llama ConfigPi._

_Esta realizado en bash script y se ejecuta desde la linea de comandos a través de SSH._


## Que hacemos ahora y como lo hacemos ❓

  
_En primer lugar hay que descargar el script a tu raspberry_

_copia y pega en tu terminal lo siguiente y descargarás el script a tu equipo_

```
sudo wget https://raw.githubusercontent.com/proyectopy/V0/main/ConfigPi.sh
```

_le das permisos de ejecución_

```
sudo chmod +x ConfigPi.sh
```

_y ya puedes ejecutarlo escribiendo en tu termial lo siguiente:_

```
./ConfigPi.sh
```
_La orden anterior clonara el repositorio de Raspyserver en una carpeta llamada V0 y cpmenzara con el script de configuración que originara algunas carpetas en el directorio donde descargues el script inicial._

# ....Continuará