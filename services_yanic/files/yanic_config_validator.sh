#!/bin/bash
for bat in `ifconfig | grep bat | cut -d ' ' -f 1`; do
    echo "config file for $bat is: "
    ls /etc/yanic/yanic_$bat.conf
    address=`ifconfig $bat | grep fe80 | awk  '{print $2}' | cut -d '/' -f 1`
    echo "configured ip_adress is: $address"
    echo "writing $address to config file..."
    sed -i 's/^\(ip_address\s*=\s*\).*$/\1"'$address'"/' /etc/yanic/yanic_$bat.conf
    echo "restarting yanic_$bat service"
    systemctl restart yanic_$bat
done


