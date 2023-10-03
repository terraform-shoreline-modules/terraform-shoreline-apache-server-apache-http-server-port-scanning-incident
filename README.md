
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache HTTP Server Port Scanning Incident
---

An Apache HTTP Server Port Scanning Incident refers to a situation where an unauthorized individual or system is attempting to scan the open ports on a server running Apache HTTP software. This type of incident is typically seen as a security threat and could be an attempt to exploit vulnerabilities in the server or steal sensitive information. It is crucial to detect and address these incidents swiftly to prevent potential harm to the system and its users.

### Parameters
```shell

export DOCUMENT_ROOT_DIRECTORY="PLACEHOLDER"

export APACHE_ACCESS_LOG_PATH="PLACEHOLDER"

export APACHE_ERROR_LOG_PATH="PLACEHOLDER"

```

## Debug

### Check if Apache HTTP server is running
```shell
systemctl status apache2
```

### Check if Apache HTTP server is listening on the expected port
```shell
sudo netstat -tuln | grep 443
```

### Check if there are any suspicious processes running on the system
```shell
ps aux 
```

### Check if there are any suspicious files in the Apache document root directory
```shell
sudo find ${DOCUMENT_ROOT_DIRECTORY} -type f -name "*.php" -o -name "*.sh"
```

### Check Apache access logs for any suspicious activity
```shell
sudo tail -1000f ${APACHE_ACCESS_LOG_PATH}
```

### Check Apache error logs for any suspicious activity
```shell
sudo tail -1000f ${APACHE_ERROR_LOG_PATH}
```

## Repair

### Block the IP address or range that initiated the port scanning activity using a firewall or network security device to prevent further scanning attempts.
```shell


#!/bin/bash



# Set the IP address or range to be blocked

IP_ADDRESS=${IP_ADDRESS_OR_RANGE}



# Block the IP address or range using iptables

iptables -A INPUT -s $IP_ADDRESS -j DROP



# Save the iptables configuration

iptables-save > /etc/sysconfig/iptables



# Restart the iptables service to apply the changes

systemctl restart iptables


```

### Implementing rate limiting in Apache HTTP Server
```shell


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


```