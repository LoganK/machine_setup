#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}
DBC=${DBC:-db}

# Dump the old database
DUMPFILE="${BACKUP_DIR}/mysql.${DBC}.$(date +%F_%R).sql.gz"
echo "Creating ${DUMPFILE}..."
mkdir -p "${BACKUP_DIR}"
docker compose exec $DBC mysqldump --all-databases | gzip > ${DUMPFILE}

