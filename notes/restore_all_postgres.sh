#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}

for backup_dbc in ${BACKUP_DIR}/postgres.*; do
  DBC=$(basename ${backup_dbc} | sed 's|postgres.||');
  latest_file="${backup_dbc}/$(ls -1r ${backup_dbc}/ | head -n1)";

  echo "Restoring $latest_file to $DBC";
  export DBC;
  $(dirname "${BASH_SOURCE[0]}")/restore_postgres.sh "$latest_file"
done
