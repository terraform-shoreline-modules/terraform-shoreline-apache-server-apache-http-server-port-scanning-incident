

#!/bin/bash



# Set the IP address or range to be blocked

IP_ADDRESS=${IP_ADDRESS_OR_RANGE}



# Block the IP address or range using iptables

iptables -A INPUT -s $IP_ADDRESS -j DROP



# Save the iptables configuration

iptables-save > /etc/sysconfig/iptables



# Restart the iptables service to apply the changes

systemctl restart iptables