#!/bin/sh

VERSION=$1
UUID_PATH=$2


cd /tmp
AO_FILE=ADITO4_${VERSION}_unix.sh
wget http://static.adito.de/common/${UUID_PATH}/${AO_FILE}
chmod 744 ${AO_FILE}

#workaround for "file is busy"

./${AO_FILE} -q -varfile /a/install/adito.varfile
rm -f ${AO_FILE}

#sed -i s/INSTALL4J_JAVA_PREFIX=\"\"/INSTALL4J_JAVA_PREFIX=\"exec\"/g /opt/ADITO4/bin/ADITO4server
cp /opt/ADITO4/bin/ADITO4server /opt/ADITO4/bin/ADITO4server_prod
cp /opt/ADITO4/bin/ADITO4server /opt/ADITO4/bin/ADITO4server_test


# license can be supplied at data
ln -s -f /a/data/linking/serverlicense.jar /opt/ADITO4/license/serverlicense.jar
# logo can be supplied at data
mv /opt/ADITO4/webroot/logo.png /opt/ADITO4/logo.png
ln -s -f /a/data/linking/logo.png /opt/ADITO4/webroot/logo.png
# Supervisor webpanel shall show the same logo as adito webstart
ln -s -f /opt/ADITO4/webroot/logo.png /opt/supervisor/ui/images/supervisor.gif
