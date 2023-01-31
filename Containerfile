ARG BASE_IMAGE=registry.access.redhat.com/ubi8-minimal:8.7-923
FROM ${BASE_IMAGE}

USER root
LABEL maintainer="corbs"
LABEL name="merlin"
LABEL version="1.0"
LABEL summary="Merlin image manipulation with Imagemagick"
LABEL description="Merlin image manipulation with Imagemagick"

ARG JQ_VERSION="jq-1.6"
ARG YQ_VERSION="v4.30.8"

COPY ./src /merlin

RUN microdnf update -y && \
    microdnf install which gzip tar git make -y && \
    microdnf install gcc -y && \
    microdnf install gcc-c++ -y && \
    microdnf remove tar && \
    microdnf clean all && \
    rm -rf /var/cache/yum && \
    curl -OL https://github.com/stedolan/jq/releases/download/${JQ_VERSION}/jq-linux64 && \
    mv jq-linux64 /usr/local/bin/jq && \
    chmod 755 /usr/local/bin/jq && \
    curl -OL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 && \
    mv yq_linux_amd64 /usr/local/bin/yq && \
    chmod 755 /usr/local/bin/yq && \
    chmod 755 /merlin/bash/*.sh


