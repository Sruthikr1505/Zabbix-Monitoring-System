#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


print_status "Updating system..."
apt update && apt upgrade -y


print_status "Installing prerequisites..."
apt install apache2 postgresql php php-pgsql php-gd php-xml \
    php-bcmath php-mbstring php-ldap php-json curl wget gnupg2 -y


print_status "Installing Zabbix..."
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu22.04_all.deb
dpkg -i zabbix-release_6.0-1+ubuntu22.04_all.deb
apt update
apt install zabbix-server-pgsql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

print_status "Setting up database..."
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u postgres psql zabbix

print_status "Configuring Zabbix..."
cp config/zabbix_server.conf /etc/zabbix/
cp config/zabbix_agentd.conf /etc/zabbix/
cp config/postgresql.conf /etc/postgresql/14/main/

print_status "Starting services..."
systemctl restart postgresql apache2 zabbix-server zabbix-agent
systemctl enable postgresql apache2 zabbix-server zabbix-agent

print_status "Installation completed successfully"