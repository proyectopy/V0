#!/bin/bash
#Original author Ivan Tichy - Original http://blog.ivantichy.cz/blogpost/view/74 -- Updated for Ubooquity by Salty
#Please modify these values according to your environment
certdir=/etc/letsencrypt/live/proyectopy.duckdns.org/ #just replace the domain name after /live/
keytooldir=/usr/lib/jvm/java-11-openjdk-arm64/bin/java #java keytool located in jre/bin (see this post if you need help finding this dir http://ubuntuforums.org/showthread.php?t=1054731&p=6643281#post6643281 )
letsencryptdir=/etc/letsencrypt #letsencrypt directory here
mydomain=proyectopy.duckdns.org #put your domain name here
myemail=proyectopy@gmx.es #your email
networkdevice=eth0 #your network device  (run ifconfig to get the name)
keystoredir=/home/pi/.keystore #located in home dir of user running Ubooquity
keystorepass=Ant4vi4n4 #the password for your keystore
 
 
#the script itself:
#cd /etc/letsencrypt #the location of your letsencrypt install
#git pull origin master #update letsencrypt with the latest files
 
 
#this temporarily reroutes your traffic to port 443 to port 9999 for the domain ownership test letsencrypt does.  
#it keeps you from having to shut down Ubooq service
iptables -I INPUT -p tcp -m tcp --dport 9999 -j ACCEPT
 
 
iptables -t nat -I PREROUTING -i $networkdevice -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 9999
 
 
#Leave the top one uncommented for testing, it creates fake certs and won't count against the certificate limit from letsencrypt.  
#Comment out top one and uncomment second command when ready to generate real cert
 
 
$letsencryptdir/letsencrypt-auto certonly --verbose --standalone --test-cert --break-my-certs -d $mydomain --standalone-supported-challenges tls-sni-01 --tls-sni-01-port 9999 --renew-by-default --email $myemail --agree-tos
#$letsencryptdir/letsencrypt-auto certonly --standalone -d $mydomain --standalone-supported-challenges tls-sni-01 --tls-sni-01-port 9999 --renew-by-default --email $myemail --agree-tos
 
 
#deletes rerouting rule
iptables -t nat -D PREROUTING -i $networkdevice -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 9999
iptables -D INPUT -p tcp -m tcp --dport 9999 -j ACCEPT
 
 
#deletes any previous JKS keys
$keytooldir/keytool -delete -alias root -storepass $keystorepass -keystore $keystoredir/ubooq_key.jks
$keytooldir/keytool -delete -alias ubooq_key -storepass $keystorepass -keystore $keystoredir/ubooq_key.jks
 
 
#builds a usable keystore from the CA provided by letsencrypt
openssl pkcs12 -export -in $certdir/fullchain.pem -inkey $certdir/privkey.pem -out $certdir/cert_and_key.p12 -name ubooq_key -CAfile $certdir/chain.pem -caname root -password pass:aaa
$keytooldir/keytool -importkeystore -srcstorepass aaa -deststorepass $keystorepass -destkeypass $keystorepass -srckeystore $certdir/cert_and_key.p12 -srcstoretype PKCS12 -alias ubooq_key -keystore $keystoredir/ubooq_key.jks
$keytooldir/keytool -import -trustcacerts -alias root -deststorepass $keystorepass -file $certdir/chain.pem -noprompt -keystore $keystoredir/ubooq_key.jks