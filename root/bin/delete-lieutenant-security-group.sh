#!/bin/sh

aws ec2 delete-security-group --group-name ${LIEUTENANT_SECURITY_GROUP}