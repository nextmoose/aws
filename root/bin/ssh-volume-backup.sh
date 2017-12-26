#!/bin/sh

TEMP1=$(mktemp) &&
    TEMP2=$(mktemp) &&
    echo "${VOLUMES_BACKUP_PRIVATE_KEY}" > ${TEMP1} &&
    ssh-keyscan $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].PublicIpAddress" --output text) > ${TEMP2} &&
    ssh -i ${TEMP1} -l ec2-user -o UserKnownHostsFile=${TEMP2} $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].PublicIpAddress" --output text) &&
    rm -f ${TEMP1} ${TEMP2}