#!/bin/bash
set -e -u

if [ "$#" -ne 2 ]; then
  cat <<zzzEOLzzz
Restore the Docker volume files.

Usage:
  $0 <volume_name> <backup_file>
zzzEOLzzz

  exit 1
fi

VOLUME=$1
DUMPFILE=$2

if [[ ! -e "${DUMPFILE}" ]]; then
  echo "File not found: ${DUMPFILE}"
  exit 2
fi

volume_exists=1
docker volume inspect "${VOLUME}" >& /dev/null || volume_exists=0
if [[ ${volume_exists} != 0 ]]; then
  1>&2 echo "Failing restore as $VOLUME already exists";
  exit 1
fi

docker volume create ${VOLUME}
docker run --rm -i -v ${VOLUME}:/data alpine ash -c \
   "tar xpz -C /data" < "${DUMPFILE}"
