# /etc/zabbix/zabbix_server.conf optimizations
StartPollers=5
StartPreprocessors=3
StartPollersUnreachable=1
StartPingers=1
StartDiscoverers=1
StartHTTPPollers=1
CacheSize=32M
HistoryCacheSize=16M
TrendCacheSize=4M
ValueCacheSize=8M

# Database Optimization
-- PostgreSQL performance settings
ALTER SYSTEM SET shared_buffers = '1GB';
ALTER SYSTEM SET effective_cache_size = '3GB';
ALTER SYSTEM SET maintenance_work_mem = '256MB';
ALTER SYSTEM SET work_mem = '32MB';

#!/bin/bash
# backup_config.sh

BACKUP_DIR="/backup/zabbix"
DATE=$(date +%Y%m%d)

# Backup database
pg_dump zabbix > $BACKUP_DIR/zabbix_db_$DATE.sql

# Backup configuration
tar -czf $BACKUP_DIR/zabbix_config_$DATE.tar.gz /etc/zabbix

# Cleanup old backups
find $BACKUP_DIR -type f -mtime +7 -delete

# Regular maintenance
VACUUM ANALYZE;
DELETE FROM history WHERE clock < UNIX_TIMESTAMP(NOW() - INTERVAL 30 DAY);
DELETE FROM trends WHERE clock < UNIX_TIMESTAMP(NOW() - INTERVAL 90 DAY);