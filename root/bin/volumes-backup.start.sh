#!/bin/sh

aws \
    ec2 \
    wait \
    instance-running \
    --instance-ids \
        $(aws \
            ec2 \
            run-instances \
            --image-id ami-c998b6b2 \
            --security-group-ids $(aws ec2 create-security-group --group-name ${VOLUMES_BACKUP_SECURITY_GROUP} --description "security group for the volumes backup environment in EC2" --query "GroupId" --output text) \
            --count 1 \
            --instance-type t2.micro \
            --key-name $(aws ec2 import-key-pair --key-name ${VOLUMES_BACKUP_KEYPAIR} --public-key-material "${VOLUMES_BACKUP_PUBLIC_KEY}" --query "KeyName" --output text) \
            --tag-specifications "ResourceType=instance,Tags=[{Key=rand,Value=29105}]" \
            --query "Instances[0].InstanceId" \
            --output text) &&
    aws ec2 authorize-security-group-ingress --group-name ${VOLUMES_BACKUP_SECURITY_GROUP} --protocol tcp --port 22 --cidr 0.0.0.0/0 &&
    aws \
        ec2 \
        wait \
        volume-available \
        --volume-ids $(
            aws \
                ec2 \
                create-volume \
                --availability-zone $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 --query "Reservations[0].Instances[0].Placement.AvailabilityZone" --output text) \
                --no-encrypted \
                --size 465 \
                --tag-specifications "ResourceType=volume,Tags=[{Key=rand,Value=29105}]" \
                --query "VolumeId" \
                --output text
            ) &&
    aws \
        ec2 \
        attach-volume \
        --device /dev/sdh \
        --volume-id $(aws ec2 describe-volumes --filters Name=tag:rand,Values=29105 --query "Volumes[0].VolumeId" --output text) \
        --instance-id $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].InstanceId" --output text) &&
    TEMP1=$(mktemp) &&
    TEMP2=$(mktemp) &&
    echo "${VOLUMES_BACKUP_PRIVATE_KEY}" > ${TEMP1} &&
    ssh-keyscan $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].PublicIpAddress" --output text) > ${TEMP2} &&
    ssh -i ${TEMP1} -l ec2-user -o UserKnownHostsFile=${TEMP2} $(aws ec2 describe-instances --filters Name=tag:rand,Values=29105 Name=instance-state-name,Values=running --query "Reservations[0].Instances[0].PublicIpAddress" --output text) "sudo mkfs -t ext4 /dev/xvdh && sudo mount /dev/xvdh /data" &&
    rm -f ${TEMP1} ${TEMP2}