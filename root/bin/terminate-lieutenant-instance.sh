#!/bin/sh

aws ec2 describe-instances --filters rand=6920 --query 'Reservations[0].Instances[0].PublicIpAddress' &&
aws ec2 terminate-instances --instance-ids 