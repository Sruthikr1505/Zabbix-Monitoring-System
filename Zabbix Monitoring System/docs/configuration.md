# Configure Zabbix server
sudo nano /etc/zabbix/zabbix_server.conf

# Add these lines:
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=your_secure_password
Timeout=4
LogFile=/var/log/zabbix/zabbix_server.log
PidFile=/var/run/zabbix/zabbix_server.pid

# Configure PHP for Zabbix
sudo nano /etc/php/8.1/apache2/php.ini

# Set these values:
memory_limit = 256M
post_max_size = 16M
upload_max_filesize = 2M
max_execution_time = 300
max_input_time = 300
date.timezone = UTC

# Initialize PostgreSQL
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix

# Set password
sudo -u postgres psql
postgres=# ALTER USER zabbix WITH PASSWORD 'your_secure_password';
postgres=# \q

# Start and enable services
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

# Install postfix
sudo apt install postfix -y

# Configure email settings in Zabbix web interface:
Administration → Media types → Email
- SMTP server: smtp.your-server.com
- SMTP port: 587
- Username: your-email@domain.com
- Password: your-email-password

# Slack webhook configuration
Name: Slack Alerts
Type: Webhook
Parameters:
  - channel: #monitoring
  - message: {TRIGGER.NAME}: {TRIGGER.STATUS}
URL: https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK
