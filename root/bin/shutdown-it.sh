#!/bin/sh

aws ec2 stop-instances --instance-ids i-0ddc5522fba86edbb &&
    aws ec2 terminate-instances --instance-ids i-0ddc5522fba86edbb 