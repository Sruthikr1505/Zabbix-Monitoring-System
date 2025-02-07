#!/bin/bash


postconf -e "relayhost = [smtp.gmail.com]:587"
postconf -e "smtp_sasl_auth_enable = yes"
postconf -e "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd"
postconf -e "smtp_sasl_security_options = noanonymous"
postconf -e "smtp_tls_security_level = encrypt"

cp templates/slack_media.yaml /usr/lib/zabbix/alertscripts/
chmod +x /usr/lib/zabbix/alertscripts/slack.sh