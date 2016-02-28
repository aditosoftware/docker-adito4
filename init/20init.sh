#!/bin/sh


# create run directories for supervisord to cd in.
mkdir -p /a/data/adito

# copy default logo
if [ ! -f /a/data/linking/logo.png ]; then
  cp /opt/ADITO4/logo.png /a/data/linking/logo.png
fi


# Setup Webstart
SYSTEM_NAME=${SYSTEM_NAME:-ADITO4}
WEBSTART_HOST_NAME=${WEBSTART_HOST_NAME:-localhost}

sed -i s/{{SYSTEM_NAME}}/${SYSTEM_NAME}/g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s/{{WEBSTART_HOST_NAME}}/${WEBSTART_HOST_NAME}/g /opt/ADITO4/webroot/webstart/config/client.jnlp
sed -i s/{{SYSTEM_NAME}}/${SYSTEM_NAME}/g /opt/ADITO4/webroot/webstart/config/test.jnlp
sed -i s/{{WEBSTART_HOST_NAME}}/${WEBSTART_HOST_NAME}/g /opt/ADITO4/webroot/webstart/config/test.jnlp

