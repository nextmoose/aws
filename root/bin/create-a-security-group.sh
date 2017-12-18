#!/bin/sh

echo SOURCE: http://docs.aws.amazon.com/cli/latest/userguide/tutorial-ec2-ubuntu.html &&
    echo First, create a new security group and add a rule that allows incoming traffic over port 22 for SSH. Note the security group ID for later use. &&
    aws ec2 create-security-group --group-name devenv-sg --description "security group for development environment in EC2" &&
    aws ec2 authorize-security-group-ingress --group-name devenv-sg --protocol tcp --port 22 --cidr 0.0.0.0/0 &&
    echo Replace the CIDR range in the above with the one that you will connect from for more security. You can use the aws ec2 describe-security-groups command to admire your handiwork. &&
    echo Next, create a key pair, which allows you to connect to the instance. &&
    aws ec2 create-key-pair --key-name devenv-key --query 'KeyMaterial' --output text > devenv-key.pem &&
    echo On Linux, you will also need to change the file mode so that only you have access to the key file. &&
    chmod 400 devenv-key.pem
    echo DONE