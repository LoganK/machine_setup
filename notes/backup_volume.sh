#!/bin/bash
set -e -u

if [ "$#" -ne 1 ]; then
  cat <<zzzEOLzzz
Backup the Docker volume files.

Variables:
  BACKUP_DIR - Directory to place the files. Will be created if necessary.

Usage:
  $0 <volume_name>
zzzEOLzzz

  exit 1
fi

VOLUME=$1
BACKUP_DIR=${BACKUP_DIR:-backup}

DUMPFILE="${BACKUP_DIR}/vol.${VOLUME}.$(date +%F_%H_%M).tar.gz"
echo "Creating ${DUMPFILE}..."
mkdir -p "${BACKUP_DIR}"
docker run --rm -v ${VOLUME}:/data alpine ash -c \
  "tar cpz -C /data ." > ${DUMPFILE}

