#!/bin/bash
 
echo "<<< deploying sites"
cd {{wcs_installer_directory}}/Sites
rm out.log
touch out.log
nc -l 12345 | sh csInstall.sh -silent | tee out.log &
while ! tail -n 1 out.log | grep "press ENTER."
do sleep 1 ; echo ...deploying...
done
echo ">>> deploying sites"
 
echo "<<< starting tomcat"
/usr/share/tomcat/bin/startup.sh
while ! wget -q -O- http://{{wcs_install_webserver_address}}:{{wcs_install_webserver_port}}/cs/HelloCS | grep reason=Success
do echo "...starting..." ; sleep 1
done
echo ">>> started tomcat"
 
echo "<<< installing sites"
cd {{wcs_installer_directory}}/Sites
echo | nc localhost 12345
while ! tail -n 1 out.log | grep "Installation Finished Successfully"
do sleep 1 ; echo ...installing...
done
echo ">>> installed sites"