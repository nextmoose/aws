#!/bin/sh

aws \
    ec2 \
    wait \
    instance-running \
        --instance-id \
        $(aws \
            ec2 \
            run-instances \
            --image-id ami-c998b6b2 \
            --security-group-ids $(aws ec2 create-security-group --group-name $(uuidgen) --description "security group for the lieutenant environment in EC2" --query "GroupId" --output text) \
            --count 1 \
            --instance-type t2.micro \
            --key-name $(aws ec2 import-key-pair --key-name $(uuidgen) --public-key-material "${LIEUTENANT_PUBLIC_KEY}" --query "KeyName" --output text) \
            --tag-specifications "ResourceType=instance,Tags=[{Key=moniker,Value=lieutenant}]" \
            --query "Instances[0].InstanceId" \
            --output text \
            ) &&
    aws ec2 authorize-security-group-ingress --group-id $(aws ec2 describe-instances --filter Name=tag:moniker,Values=lieutenant Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].SecurityGroups[*].GroupId" --output text) --protocol tcp --port 22 --cidr 0.0.0.0/0 &&
    DOT_SSH=$(mktemp -d) &&
    chmod 0700 ${DOT_SSH} &&
    echo "${LIEUTENANT_PRIVATE_KEY}" > ${DOT_SSH}/id_rsa &&
    (cat > ${DOT_SSH}/config <<EOF
Host lieutenant
HostName $(aws ec2 describe-instances --filter Name=tag:moniker,Values=lieutenant Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].PublicIpAddress" --output text)
User ec2-user
IdentityFile ${DOT_SSH}/id_rsa
UserKnownHostsFile ${DOT_SSH}/known_hosts
EOF
    ) &&
    chmod 0600 ${DOT_SSH}/config ${DOT_SSH}/id_rsa &&
    ssh-keyscan $(aws ec2 describe-instances --filter Name=tag:moniker,Values=lieutenant Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].PublicIpAddress" --output text) > ${DOT_SSH}/known_hosts &&
    chmod 0644 ${DOT_SSH}/known_hosts &&
    echo ${DOT_SSH} &&
    ssh -F ${DOT_SSH}/config lieutenant
    