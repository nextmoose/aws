#!/bin/sh

aws ec2 describe-instances --filter Name=tag:moniker,Values=lieutenant Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].InstanceId" --output text | while read INSTANCE_ID
    do
        aws ec2 wait instance-terminated --instance-id $(aws ec2 terminate-instances --instance-ids ${INSTANCE_ID} --query "TerminatingInstances[0].InstanceId" --output text)
    done &&
    aws ec2 describe-instances --filter Name=tag:moniker,Values=lieutenant Name=instance-state-name,Values=terminated --query "Reservations[*].Instances[*].KeyName" --output text | while read KEY_NAME
    do
        aws ec2 delete-key-pair --key-name ${KEY_NAME}
    done &&
    aws ec2 describe-instances --filter Name=tag:moniker,Values=lieutenant Name=instance-state-name,Values=terminated --query "Reservations[*].Instances[*].SecurityGroups[*].GroupId" --output text | while read GROUP_ID
    do
        aws ec2 delete-security-group --group-id ${GROUP_ID}
    done