#!/bin/sh

aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].InstanceId" --output text) &&
    aws ec2 delete-key-pair --key-name ${VOLUMES_BACKUP_KEYPAIR} &&
    sleep 1m &&
    while [ ! -z "$(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query \"Reservations[0].Instances[0].InstanceId\" --output text)" ]
    do
        echo waiting for instance &&
            aws ec2 describe-instance-status --instance-id $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].InstanceId" --output text) --query "InstanceStatuses[0]" &&
            sleep 10s
    done &&
    aws ec2 delete-security-group --group-name ${VOLUMES_BACKUP_SECURITY_GROUP} &&
    aws ec2 delete-volume --volume-id $(aws ec2 describe-volumes --filters Name=tag:rand,Values=29105 --query "Volumes[0].VolumeId" --output text) &&
    true