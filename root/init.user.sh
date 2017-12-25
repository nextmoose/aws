#!/bin/sh

source ${HOME}/.bashrc &&
    (cat <<EOF
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_DEFAULT_REGION}

EOF
    ) | aws configure &&
    mkdir /home/user/.ssh &&
    chmod 0700 /home/user/.ssh &&
    cp /opt/docker/extension/config /home/user/.ssh/config &&
    touch /home/user/.ssh/volumes_backup_id_rsa &&
    chmod 0600 /home/user/.ssh/config /home/user/.ssh/volumes_backup_id_rsa