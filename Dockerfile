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

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 22
CMD ["/docker-entrypoint.sh"]
