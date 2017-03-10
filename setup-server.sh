#!/bin/bash

DROPLET_NAME=tenant
USER_NAME=root
DOMAIN_NAME=tenants.co
SUB_DOMAIN_NAME=test

echo "Create server "
doctl compute droplet create $DROPLET_NAME --size 512mb --image ubuntu-16-04-x64 --region ams2 --ssh-keys 35:54:ed:50:76:6f:0b:79:a3:6d:37:01:5d:55:2f:5d --enable-ipv6 --user-data-file userdata.sh

sleep 10

DROPLET_IP=$(echo `doctl compute droplet list $DROPLET_NAME --format PublicIPv4 --no-header`)

echo "Create domain name $SUB_DOMAIN_NAME.$DOMAIN_NAME folowing IP: $DOMAIN_IP"
doctl compute domain records create --record-type A --record-name $SUB_DOMAIN_NAME --record-data $DROPLET_IP $DOMAIN_NAME

status=$(ssh -o StrictHostKeyChecking=no -o BatchMode=yes $USER_NAME@$DROPLET_IP echo ok '2>&1')

while [[ $status != 'ok' ]] 
do
    echo -ne "."
    sleep 5
done

# Copy SSH key
echo "Copy SSH key to server"
scp -o  StrictHostKeyChecking=no ./id_rsa* $USER_NAME@$DROPLET_IP:/root/.ssh/

