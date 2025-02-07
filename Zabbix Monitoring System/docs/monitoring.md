Template Name: Basic System Monitoring
Items:
  - CPU Usage
  - Memory Usage
  - Disk Space
  - Network Traffic
  - System Load
Triggers:
  - CPU > 80% for 5m
  - Memory > 90%
  - Disk Space < 10% free
  - System Load > 5

  // Dashboard JSON Structure
{
  "name": "System Overview",
  "widgets": [
    {
      "type": "graph",
      "name": "CPU Usage",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 5,
      "view_mode": 0,
      "fields": {
        "itemid": "CPU Usage Item ID"
      }
    },
    // Add more widgets as needed
  ]
}

# Test Zabbix server
sudo zabbix_server -R diag_info

# Test agent
sudo zabbix_agentd -t system.cpu.load

# Test database connection
sudo -u zabbix psql -h localhost -d zabbix -U zabbix -c "SELECT VERSION();"

