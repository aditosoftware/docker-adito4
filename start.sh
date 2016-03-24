cp -f /a/config/ADITO4server.vmoptions /opt/ADITO4/bin/ADITO4server.vmoptions
cp -f /a/config/serverconfig.xml /opt/ADITO4/config/serverconfig.xml


if [ -f /opt/ADITO4/webroot/webstart/config/client_copy.jnlp ]
then
cp -f /opt/ADITO4/webroot/webstart/config/client_copy.jnlp /opt/ADITO4/webroot/webstart/config/client.jnlp
else
cp -f /opt/ADITO4/webroot/webstart/config/client.jnlp /opt/ADITO4/webroot/webstart/config/client_copy.jnlp
fi

#Replacement for Webstart
sed -i s^http://{WEBSTART_URL}/webstart/config^"${WEBSTART_URL}"^g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s/{WEBSTART_HOST}/"${WEBSTART_HOST}"/g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s/64999/"${WEBSTART_PORT}"/g /opt/ADITO4/webroot/webstart/config/client.jnlp

#Replacement for serverconfig.xm.
sed -i s/{WEBSTART_HOST}/"${WEBSTART_HOST}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{WEBSTART_URL}/"${WEBSTART_URL}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{WEBSTART_PORT}/"${WEBSTART_PORT}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_DATABASE}/"${SRVCONF_DATABASE}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_DATABASETYP}/"${SRVCONF_DATABASETYP}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_HOST}/"${SRVCONF_HOST}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_PASSWORD}/"${SRVCONF_PASSWORD}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_PORT}/"${SRVCONF_PORT}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_USER}/"${SRVCONF_USER}"/g /opt/ADITO4/config/serverconfig.xml
sed -i s/{SRVCONF_SERVER_ID}/"${SRVCONF_SERVER_ID}"/g /opt/ADITO4/config/serverconfig.xml

#Replacement for ADITO4-Server vmoptions
sed -i s/{JVM_XMX}/"${JVM_XMX:-1024M}"/g /opt/ADITO4/bin/ADITO4server.vmoptions


echo 000000000000000000000000000000000000000000000000000000000000000000000000
cat /opt/ADITO4/webroot/webstart/config/client.jnlp
echo 000000000000000000000000000000000000000000000000000000000000000000000000
echo 000000000000000000000000000000000000000000000000000000000000000000000000
cat /opt/ADITO4/config/serverconfig.xml
echo 000000000000000000000000000000000000000000000000000000000000000000000000
echo 000000000000000000000000000000000000000000000000000000000000000000000000
cat /opt/ADITO4/bin/ADITO4server.vmoptions
echo 000000000000000000000000000000000000000000000000000000000000000000000000
echo "$WEBSTART_URL"



#Start the Server
/opt/ADITO4/bin/ADITO4server