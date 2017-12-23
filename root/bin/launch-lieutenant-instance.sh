#!/bin/sh

aws ec2 run-instances --image-id ami-c998b6b2 --security-groups ${LIEUTENANT_SECURITY_GROUP} --count 1 --instance-type t2.micro --key-name ${LIEUTENANT_KEYPAIR} --tag-specifications "ResourceType=instance,Tags=[{Key=rand,Value=6920}]" &&
    sleep 1m &&
    aws ec2 describe-instances --filters Name=tag:rand,Values=6920 --query "Reservations[0].Instances[0].PublicIpAddress"