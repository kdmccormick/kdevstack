ARG IDA
ARG BASE_IMAGE_TAG=edxops/$IDA
FROM $BASE_IMAGE_TAG

ARG IDA
ARG REPO_SRC
ARG REPO_DEST=$IDA

WORKDIR /edx/app/$IDA
COPY $REPO_SRC $REPO_DEST
