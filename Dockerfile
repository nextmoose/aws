FROM alpine:3.4
RUN \
    apk update && \
        apk upgrade && \
        apk add --no-cache py-pip bash docker sudo groff && \
        adduser -D user && \
        apk add --no-cache docker-bash-completion bash-completion && \
        echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
        chmod 0444 /etc/sudoers.d/user && \
        rm -rf /var/cache/apk/*
USER user
RUN \
    pip install awscli --upgrade --user && \
        echo "export PATH=\${HOME}/.local/bin:\${PATH}" >> ${HOME}/.bashrc
ENTRYPOINT ["bash"]
CMD []