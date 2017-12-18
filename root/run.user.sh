#!/bin/sh

dnf update &&
    pip install awscli --upgrade --user &&
    echo "export PATH=\${HOME}/.local/bin:\${PATH}" >> ${HOME}/.bashrc