#!/bin/bash

echo "================================================================"
echo Deploying elasticsarch...
echo "================================================================"
ansible-playbook -i ./hosts/elk-hosts es-vm.yml
echo "================================================================"
echo Deploying logstash...
echo "================================================================"
ansible-playbook -i ./hosts/elk-hosts log-vm.yml
echo "================================================================"
echo Deploying kibana...
echo "================================================================"
ansible-playbook -i ./hosts/elk-hosts kib-vm.yml
