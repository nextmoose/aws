FROM docker:17.11.0
RUN \
    TEMP=$(mktemp -d) && \
    cd ${TEMP} && \
    wget https://github.com/rancher/convoy/releases/download/v0.5.0/convoy.tar.gz && \
    tar xvzf convoy.tar.gz && \
    cp convoy/convoy convoy/convoy-pdata_tools /usr/local/bin/ && \
    sudo mkdir -p /etc/docker/plugins/ && \
    echo "unix:///var/run/convoy/convoy.sock" > /etc/docker/plugins/convoy.spec &&
    cd / && \
    rm -rf ${TEMP}
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD []
    