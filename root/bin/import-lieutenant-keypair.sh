#!/bin/sh

aws ec2 import-key-pair --key-name ${LIEUTENANT_KEYPAIR} --public-key-material "${LIEUTENANT_PUBLIC_KEY}"