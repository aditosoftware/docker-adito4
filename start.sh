#!/bin/bash
cp -f /a/config/ADITO4server.vmoptions /opt/ADITO4/bin/ADITO4server.vmoptions
cp -f /a/config/serverconfig.xml /opt/ADITO4/config/serverconfig.xml

cp -f /opt/ADITO4/webroot/webstart/config/template_client.jnlp /opt/ADITO4/webroot/webstart/config/client.jnlp


sed -i s^http://host^"${WEBSTART_URL:-"http://${WEBSTART_HOST}"}"^g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s^'<argument>host</argument>'^'<argument>'"${WEBSTART_HOST}"'</argument>'^g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s^7779^"${ADITO_PORT:-7779}"^g /opt/ADITO4/webroot/webstart/config/client.jnlp

#Default Connection Type for Adito 4.4 is CLASSIC; Default Connection Type for Adito 4.5 is NETTY
sed -i s^CLASSIC^"${ADITO_CONNECTION_TYPE:-"NETTY"}"^g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s^NETTY^"${ADITO_CONNECTION_TYPE:-"NETTY"}"^g /opt/ADITO4/webroot/webstart/config/client.jnlp

sed -i s/{SRVCONF_DATABASE}/"${SRVCONF_DATABASE}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_DATABASETYP}/"${SRVCONF_DATABASETYP}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_HOST}/"${SRVCONF_HOST}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_PASSWORD}/"${SRVCONF_PASSWORD}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_PORT}/"${SRVCONF_PORT}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_USER}/"${SRVCONF_USER}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_SERVER_ID}/"${SRVCONF_SERVER_ID}"/g /opt/ADITO4/config/serverconfig.xml

#Replacement for ADITO4-Server vmoptions
sed -i s/{JVM_XMX}/"${JVM_XMX:-1024M}"/g /opt/ADITO4/bin/ADITO4server.vmoptions


/opt/ADITO4/bin/ADITO4server



<argument>host</argument>