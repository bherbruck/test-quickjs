# [Choice] Debian OS version: bullseye, buster
ARG VARIANT=bullseye
FROM --platform=linux/amd64 mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

COPY library-scripts /tmp/

ENV QUICKJS_INSTALL=/quickjs
RUN mkdir -p /quickjs \
    && sh /tmp/install-quickjs.sh \
    && chown -R vscode /quickjs

ENV PATH=${QUICKJS_INSTALL}/bin:${PATH} \
    QUICKJS_DIR=${QUICKJS_INSTALL}/.cache/quickjs

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#    && apt-get -y install --no-install-recommends <your-package-list-here>