FROM registry.access.redhat.com/ubi8/ubi:8.7-1054

USER root
LABEL maintainer="corbs"
LABEL name="merlin"
LABEL version="1.0"
LABEL summary="Merlin image manipulation with Imagemagick"
LABEL description="Merlin image manipulation with Imagemagick"

ARG JQ_VERSION="jq-1.6"
ARG YQ_VERSION="v4.30.8"

COPY ./src/bash /merlin

ENV PATH /merlin:${PATH}

RUN yum update -y && \
    yum install git make automake -y && \
    yum install gcc gcc-c++ -y && \
    yum install libtool-ltdl pkgconf -y && \
    yum install libxml2-devel fontconfig-devel freetype-devel -y && \
    yum install libjpeg libjpeg-devel libpng libpng-devel libtiff libtiff-devel libwebp libwebp-devel -y && \
    yum install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/LibRaw-0.19.5-3.el8.x86_64.rpm -y && \
    yum install --skip-broken http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/LibRaw-devel-0.19.5-3.el8.x86_64.rpm -y && \
    yum install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/libgs-9.27-5.el8.x86_64.rpm -y && \
    yum install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/ghostscript-9.27-5.el8.x86_64.rpm -y && \
    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y && \
    yum install jxrlib -y && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    curl -OL https://github.com/stedolan/jq/releases/download/${JQ_VERSION}/jq-linux64 && \
    mv jq-linux64 /usr/local/bin/jq && \
    chmod 755 /usr/local/bin/jq && \
    curl -OL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 && \
    mv yq_linux_amd64 /usr/local/bin/yq && \
    chmod 755 /usr/local/bin/yq && \
    chmod 755 /merlin/*.sh


