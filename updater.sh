#!/usr/bin/env bash

VERSION="0.1.0"

WORKING_DIR="$(pwd)"

if [ "$(id -u)" != "0" ]; then
   echo "updater: You need to run this command as root." 1>&2

   exit 1
fi

help() {
  cat << EOF
Version: ${VERSION}

Usage: updater

Options:
  -v, --version     Show version number
  -h, --help        Show help
EOF

  exit 1
}

version() {
  help
}

if [ "${1}" == "-h" ] || [ "${1}" == "--help" ]; then
  help
fi

if [ "${1}" == "-v" ] || [ "${1}" == "--version" ]; then
  version
fi

apt-get update

apt-get -y install curl

curl -sSL https://get.docker.com/ | sh

curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

apt-get -y install wget

DRUPAL_COMPOSE_VERSION="$(wget https://raw.githubusercontent.com/dockerizedrupal/drupal-compose/master/VERSION.md -q -O -)"

TMP="$(mktemp -d)" \

git clone https://github.com/dockerizedrupal/drupal-compose.git "${TMP}" \

cd "${TMP}" \

git checkout "${DRUPAL_COMPOSE_VERSION}" \

cp "${TMP}/drupal-compose.sh" /usr/local/bin/drupal-compose \

chmod +x /usr/local/bin/drupal-compose \

CRUSH_VERSION="$(wget https://raw.githubusercontent.com/dockerizedrupal/crush/master/VERSION.md -q -O -)"

TMP="$(mktemp -d)"

git clone https://github.com/dockerizedrupal/crush.git "${TMP}" \

cd "${TMP}" \

git checkout "${CRUSH_VERSION}" \

cp "${TMP}/crush.sh" /usr/local/bin/crush \

chmod +x /usr/local/bin/crush \

rm -f /usr/local/bin/drush

ln -s /usr/local/bin/crush /usr/local/bin/drush \

cd "${WORKING_DIR}"
