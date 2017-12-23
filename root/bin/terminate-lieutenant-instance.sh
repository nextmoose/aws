#!/bin/sh

aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --filters Name=tag:rand,Values=6920 --query "Reservations[0].Instances[0].InstanceId" --output text)