#!/bin/sh

apt-get install -y python-setuptools

easy_install supervisor
mkdir -p /etc/supervisor
echo_supervisord_conf > /etc/supervisor/supervisord.conf
echo "\n[include]\nfiles = /etc/supervisor/conf.d/*" >> /etc/supervisor/supervisord.conf

SUPERVISOR_DIR=$(dirname $(find / | grep /supervisor/supervisord.pyc))
ln -s ${SUPERVISOR_DIR} /opt/supervisor
ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf
