#!/bin/bash

ethDev=`ifconfig | grep flags | grep -v LOOPBACK | grep -v docker |  awk -F':' '{print $1}'`

if [ $# -eq 6 ]
then

echo "Configuring interface $ethDev"
#echo "Taking the backup and Changing the hostname from $(hostname) to $1 ..."

#sed -i.bk "s/$(hostname)/$1/g" /etc/sysconfig/network

echo ""
echo "Backing up & Assigning the Static IP ..."
echo ""

cp /etc/sysconfig/network-scripts/ifcfg-$ethDev /etc/sysconfig/network-scripts/$ethDev.bk

cat <<EOF > /etc/sysconfig/network-scripts/ifcfg-$ethDev

TYPE="Ethernet"
BOOTPROTO=none
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
NAME=$ethDev
DEVICE=$ethDev
ONBOOT="yes"
DNS1=$5
DOMAIN=$6
IPADDR=$2.$3
PREFIX=24
GATEWAY$2.$4
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes

EOF

echo "Changing the dns ..."
echo ""

sed -i.bk "s/nameserver.*/nameserver $5/" /etc/resolv.conf

echo "Restarting the Network Service, Please connect it using the new IP Address if you are using ssh ..."

#service network restart

else

echo "Usage: ip.sh <hostname> <baseip> <ipaddress> <gateway> <dns> <domain>"
echo "Example: ip.sh testname 192.168.200 41 1 192.168.200.100 inginialab.local"

fi
