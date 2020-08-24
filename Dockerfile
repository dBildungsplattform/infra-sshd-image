ARG DEBIAN_IMAGE_TAG="stable-20200803-slim"

# --- stage:release ------------------------------------------------------------
FROM debian:${DEBIAN_IMAGE_TAG} as release

ARG BUILD_BRANCH
ARG BUILD_HASH

LABEL build.stage="release"
LABEL build.branch="${BUILD_BRANCH}"
LABEL build.hash="${BUILD_HASH}"

RUN set -x \
    && apt-get -y update \
    # && apt-get -y install \
    #     curl \
    && rm -rf /var/lib/apt/lists/*

