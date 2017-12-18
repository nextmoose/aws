#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes python2-pip jq &&
    dnf clean all