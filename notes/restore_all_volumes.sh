#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}

# Allow compose to create the volumes.
docker compose up --no-start

for volume in ${BACKUP_DIR}/vol.*; do
  volume_name=$(basename ${volume} | sed 's|vol\.\([^.]\+\)\..*|\1|');

  echo "Restoring $volume to $volume_name";
  $(dirname "${BASH_SOURCE[0]}")/restore_volume.sh "$volume_name" "$volume"
done
