#!/usr/bin/env bash

INSTANCE_TYPE="VC1S"
IMAGE="Docker"

if [[ -f inventory ]] ; then
  echo "Inventory already exists, exiting"
  exit 0
fi

echo "Creating instance.."

instance_id=$(scw create --commercial-type $INSTANCE_TYPE $IMAGE)

printf "Waiting for instance to start.."

scw start $instance_id > /dev/null

while [[ ! $(scw ps -q -f state=running | grep $instance_id) ]] ; do
  sleep 1
  printf "."
done

printf '\nDone!\n'

IP=$(scw inspect $instance_id |jq -r '.[0].public_ip.address')

echo "Instance running at ip: $IP"

echo "$IP ansible_ssh_user=root" > inventory

printf "Waiting SSH to become available.."

until ssh -o StrictHostKeyChecking=no root@$IP "echo" > /dev/null 2>&1 ; do
  printf "."
  sleep 2
done

printf '\nYay! Running ansible now!\n'

ansible-playbook -e 'host_key_checking=False' -v -i inventory playbook.yml
