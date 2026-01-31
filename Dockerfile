FROM alpine:3.19

# prepare everything
RUN apk add --no-cache \
    vim \
    lsof \
    tar \
    bind-tools \
    iptables \
    iproute2

WORKDIR /opt/udp2raw
ENV PATH="/opt/udp2raw:${PATH}"
ENV UDP2RAW_VERSION=20230206.0

# download udp2raw
RUN wget https://github.com/wangyu-/udp2raw-tunnel/releases/download/${UDP2RAW_VERSION}/udp2raw_binaries.tar.gz
RUN tar xzvf udp2raw_binaries.tar.gz
RUN rm udp2raw_binaries.tar.gz

# copy pre-setting to workspace
COPY script script

### next need to excute in host
## enable ip_forward
# RUN sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/' /etc/sysctl.conf

## keep this code for set sysctl.conf for bbr kernel
# RUN echo 'net.core.default_qdisc = fq' >> /etc/sysctl.conf
# RUN echo 'net.ipv4.tcp_congestion_control = bbr' >> /etc/sysctl.conf

## active setting
# RUN sysctl -p

# ENTRYPOINT ["udp2raw_amd64"]
ENTRYPOINT [ "./script/start.sh" ]
CMD ["udp2raw_amd64", "-s", "-l","0.0.0.0:1234", "-r", "127.0.0.1:7777", "--raw-mode", "faketcp", "-a", "--wait-lock", "-k", "passwd"]
