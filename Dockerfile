FROM ubuntu:20.04 as release

ARG BUILD_BRANCH
ARG BUILD_HASH

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

LABEL build.stage="release"
LABEL build.branch="${BUILD_BRANCH}"
LABEL build.hash="${BUILD_HASH}"

# Install sshd
RUN set -x \
    && apt-get -y update \
    && apt-get -y install \
        openssh-server\
    && rm -rf /var/lib/apt/lists/*

# Dir /var/run/sshd is required by daemon
RUN mkdir /var/run/sshd

# Set SSHD options for User support
RUN echo "\nMatch User support\n\
    \tAllowTcpForwarding yes\n\
    \tX11Forwarding no\n\
    \tAllowAgentForwarding no\n\
    \tForceCommand /bin/false"  >> /etc/ssh/sshd_config

# Add support user
RUN useradd -ms /bin/false support
RUN mkdir /home/support/.ssh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
