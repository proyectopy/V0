#!/bin/bash

sudo apt -y install expect &>/dev/null

#Not required in actual script
MYSQL_ROOT_PASSWORD="Ant4vi4n4"

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$MYSQL\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

sudo echo "$SECURE_MYSQL"

sudo apt -y purge expect

source /home/pi/conf.sh