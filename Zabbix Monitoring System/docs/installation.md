# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install apache2 postgresql php php-pgsql php-gd php-xml \
    php-bcmath php-mbstring php-ldap php-json curl wget gnupg2 -y

# Add Zabbix repository
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.0-1+ubuntu22.04_all.deb
sudo apt update

# Install Zabbix components
sudo apt install zabbix-server-pgsql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

# Import initial schema
sudo zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u postgres psql zabbix