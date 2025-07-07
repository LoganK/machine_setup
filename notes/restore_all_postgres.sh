#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}

for backup_dbc in ${BACKUP_DIR}/postgres.*; do
  DBC=$(basename ${backup_dbc} | sed 's|postgres\.\([^.]\+\)\..*|\1|');

  echo "Restoring $backup_dbc to $DBC";
  export DBC;
  $(dirname "${BASH_SOURCE[0]}")/restore_postgres.sh "$backup_dbc"
done
