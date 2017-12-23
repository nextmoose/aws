#!/bin/sh

aws ec2 delete-security-group --group-name devenv-sg &&
    aws ec2 delete-key-pair --key-name lieutenant-key