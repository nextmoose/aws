#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --aws-access-key-id)
            AWS_ACCESS_KEY_ID="${2}" &&
                shift 2
        ;;
        --aws-secret-access-key)
            AWS_SECRET_ACCESS_KEY="${2}" &&
                shift 2
        ;;
        --aws-default-region)
            AWS_DEFAULT_REGION="${2}" &&
                shift 2
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    (cat <<EOF
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_DEFAULT_REGION}

EOF
    ) | aws configure