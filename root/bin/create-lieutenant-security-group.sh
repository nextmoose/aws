#!/bin/sh

aws ec2 create-security-group --group-name ${LIEUTENANT_SECURITY_GROUP} --description "security group for the lieutenant environment in EC2" &&
    aws ec2 authorize-security-group-ingress --group-name devenv-sg --protocol tcp --port 22 --cidr 0.0.0.0/0 