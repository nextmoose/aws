#!/bin/sh

aws ec2 import-key-pair --key-name ${VOLUMES_BACKUP_KEYPAIR} --public-key-material "${VOLUMES_BACKUP_PUBLIC_KEY}"