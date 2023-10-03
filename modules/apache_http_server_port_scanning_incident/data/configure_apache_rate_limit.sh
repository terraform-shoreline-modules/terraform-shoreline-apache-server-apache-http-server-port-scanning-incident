

#!/bin/bash



# Set variables

APACHE_CONFIG_FILE="${PATH_TO_APACHE_CONFIG_FILE}"

MAX_CONNECTIONS="${MAX_CONNECTIONS_PER_IP}"

TIME_INTERVAL="${TIME_INTERVAL}"



# Backup config file

cp $APACHE_CONFIG_FILE "$APACHE_CONFIG_FILE.bak"



# Add rate limiting configuration to Apache config file

echo "LimitRequestBody 102400" >> $APACHE_CONFIG_FILE

echo "LimitRequestFields 50" >> $APACHE_CONFIG_FILE

echo "LimitRequestFieldSize 8190" >> $APACHE_CONFIG_FILE

echo "LimitRequestLine 8190" >> $APACHE_CONFIG_FILE

echo "LimitXMLRequestBody 102400" >> $APACHE_CONFIG_FILE

echo "MaxConnPerIP $MAX_CONNECTIONS" >> $APACHE_CONFIG_FILE

echo "TimeOut $TIME_INTERVAL" >> $APACHE_CONFIG_FILE



# Restart Apache

systemctl restart apache2.service