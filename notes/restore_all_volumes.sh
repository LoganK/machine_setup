#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}

for volume in ${BACKUP_DIR}/vol.*; do
  volume_name=$(basename ${volume} | sed 's|vol.||');
  latest_file="${volume}/$(ls -1r ${volume}/ | head -n1)";

  echo "Restoring $latest_file to $volume_name";
  $(dirname "${BASH_SOURCE[0]}")/restore_volume.sh "$volume_name" "$latest_file"
done
