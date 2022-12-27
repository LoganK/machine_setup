#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}
DBC=${DBC:-db}

# Dump the old database
DUMP_DIR="${BACKUP_DIR}/mysql.${DBC}"
DUMPFILE="${DUMP_DIR}/$(date +%F_%R).sql.gz"
echo "Creating ${DUMPFILE}..."
mkdir -p "${DUMP_DIR}"
docker compose exec $DBC mysqldump --all-databases | gzip > ${DUMPFILE}

