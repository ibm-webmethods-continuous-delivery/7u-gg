#!/bin/sh

## By default point to the 7u-aio template repo, but the user SHOULD provide their own

GGQS_AIO_HTTPS_TEMPLATE_CLONE_URL=https://github.com/ibm-webmethods-continuous-delivery/7u-aio.git
GGQS_AIO_HTTPS_CLONE_URL="${GGQS_AIO_HTTPS_CLONE_URL:-${GGQS_AIO_HTTPS_TEMPLATE_CLONE_URL}}"

GGQS_AIO_SSH_TEMPLATE_CLONE_URL='git@github.com:ibm-webmethods-continuous-delivery/7u-aio.git'
GGQS_AIO_SSH_CLONE_URL="${GGQS_AIO_SSH_CLONE_URL:-${GGQS_AIO_SSH_TEMPLATE_CLONE_URL}}"

if [ "${GGQS_AIO_SSH_CLONE_URL}" = "${GGQS_AIO_SSH_TEMPLATE_CLONE_URL}" ]; then
  echo "WARNING: GGQS_AIO_SSH_CLONE_URL env var is incorrectly set, you should set your own repo, derived from the template!"
  printf 'Do you want to use the default (not recommended) [ Y to continue ] ?'
  read -r __use_default_aio_repo

  if [ "${__use_default_aio_repo}" != "Y" ]; then
    exit 1
  fi
fi

if [ -d /gg/aio ]; then
  echo "ERROR: /gg/aio already exists, you should remove it before running this script!"
  exit 2
fi

git clone \
  "${GGQS_AIO_HTTPS_CLONE_URL}" \
  /gg/aio || exit 3

cd /gg/aio || exit 4

git remote set-url origin "${GGQS_AIO_SSH_ORIGIN_URL}" || exit 5

mkdir -p /gg/aio/c/iwcd

git clone \
  'https://github.com/ibm-webmethods-continuous-delivery/7u-container-images.git' \
  /gg/aio/c/iwcd/7u-container-images || exit 5

cd /gg/aio/c/iwcd/7u-container-images || exit 6

git remote set-url origin 'git@github.com:ibm-webmethods-continuous-delivery/7u-container-images.git' || exit 7

cd /gg/aio/c/iwcd/7u-container-images/images/s/alpine/git-guardian || exit 8
docker buildx build -t 'git-guardian-s:alpine' . || exit 9

cd /gg/aio/c/iwcd/7u-container-images/images/t/alpine/git-guardian || exit 10
docker buildx build -t 'git-guardian-t:alpine' . || exit 11

cd /gg/aio/c/iwcd/7u-container-images/images/u/alpine/git-guardian || exit 12
docker buildx build -t 'git-guardian-u:alpine' . || exit 13

echo "Git Guardian quick start successfully executed!"
