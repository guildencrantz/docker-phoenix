#!/bin/sh

GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
STOP_COLOR='\033[0m'

function dkr {
  if [[ $1 == "compose" ]]; then
    shift
    local CMD="$(which docker-compose) $@"
  else
    local CMD="$(which docker) $@"
  fi

  $CMD 2>/dev/null
  if [ $? -ne 0 ]
  then
    echo -e "${YELLOW}'${CMD}' failed. If it's not because you need to run docker with root then don't enter your password and try this again after fixing your problem.${STOP_COLOR}" >&2
    sudo $CMD
  fi
}

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null
DOCKER_DIR=$( pwd )
DOCKER_PREFIX=$( echo ${DOCKER_DIR##*/} | tr -cd '[[:alnum:]]' )

dkr compose up -d

PHOENIX_CONTAINER="${DOCKER_PREFIX}_phoenix_1"

PHOENIX_IP=$( dkr inspect $PHOENIX_CONTAINER | sed -n 's/^\s\+"IPAddress": "\(.\+\)",/\1/p' )
if [[ "${PHOENIX_IP}Z" == "Z" ]]; then
  echo -e "${RED}Unable to get ip address of container ${PHOENIX_CONTAINER}${STOP_COLOR}"
  exit 1
fi

echo "Checking /etc/hosts for phoenix entry, and updating if found"
sudo sed -i "/^\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\} phoenix/{s/^\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\} phoenix/$PHOENIX_IP phoenix/; q1}" /etc/hosts
if [[ $? -eq 1 ]]; then
  echo "/etc/hosts updated with '$PHOENIX_IP phoenix'"
else
  echo "No phoenix entry found in /etc/hosts, appending '$PHOENIX_IP phoenix'"
  sudo bash -c "echo '$PHOENIX_IP phoenix' >> /etc/hosts"
fi

#vim: set ts=2 sw=2 sts=2 ai et :
