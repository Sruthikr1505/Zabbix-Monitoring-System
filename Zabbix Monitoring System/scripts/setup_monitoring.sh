#!/bin/bash

zabbix_server -c /etc/zabbix/zabbix_server.conf -R config_cache_reload

zbx_group_create() {
    curl -s -X POST -H 'Content-Type: application/json' -d '{
        "jsonrpc": "2.0",
        "method": "hostgroup.create",
        "params": {
            "name": "'$1'"
        },
        "auth": "'$AUTH_TOKEN'",
        "id": 1
    }' http://localhost/zabbix/api_jsonrpc.php
}

zbx_group_create "Servers"
zbx_group_create "Network Devices"
zbx_group_create "Applications"

cp templates/system_monitoring.yaml /usr/share/zabbix/conf/