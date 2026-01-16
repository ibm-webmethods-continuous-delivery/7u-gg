#!/bin/sh

## By default point to the 7u-aio template repo, but the user SHOULD provide their own

# This is used for the initial clone as it is a public epo and does not require authentication
GGQS_AIO_HTTPS_TEMPLATE_CLONE_URL=https://github.com/ibm-webmethods-continuous-delivery/7u-aio.git

# This should point to user's private repo, but may be set afterward2
GGQS_AIO_SSH_ORIGIN_URL="${GGQS_AIO_SSH_ORIGIN_URL:-none}"

if [ -d /gg/aio ]; then
  echo "ERROR: /gg/aio already exists, you should remove it before running this script!"
  exit 2
fi

git clone \
  "${GGQS_AIO_HTTPS_TEMPLATE_CLONE_URL}" \
  /gg/aio || exit 3

cd /gg/aio || exit 4

if [ "${GGQS_AIO_SSH_ORIGIN_URL}" = "none" ]; then
  echo "WARNING: Private AI Overwatch repository not provided!"
  echo "Using the public template: you will not be able to push commits!"
  echo "Eventually change the origin later with the following command!"
  echo "cd /gg/aio && git remote set-url origin <your-private-repo-ssh-url>"
else
  git remote set-url origin "${GGQS_AIO_SSH_ORIGIN_URL}" || exit 5
fi
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

