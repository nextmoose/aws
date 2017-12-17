#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes python2-pip &&
    apk add --no-cache py-pip bash docker sudo groff &&
    dnf clean all