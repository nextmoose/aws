#!/bin/sh

echo Source: http://docs.aws.amazon.com/cli/latest/userguide/tutorial-ec2-ubuntu.html &&
    echo Run the following command, replacing the security group ID output in the previous step. &&
    aws ec2 run-instances --image-id ami-c998b6b2 --security-groups devenv-sg --count 1 --instance-type t2.micro --key-name lieutenant-key --query 'Instances[0].InstanceId' &&
    echo The instance will take a few moments to launch. Once the instance is up and running, the following command will retrieve the public IP address that you will use to connect to the instance. &&
    echo DONE