#!/bin/bash
set -e -u

BACKUP_DIR=${BACKUP_DIR:-backup}
DBC=${DBC:-db}

# Get POSTGRES_{DB,USER,PASSWORD}
source db.env

# Dump the old database
DUMPFILE="${BACKUP_DIR}/postgres.${DBC}.$(date +%F_%R).sql.gz"
echo "Creating ${DUMPFILE}..."
mkdir -p "${BACKUP_DIR}"
# docker compose exec $DBC pg_dumpall -U ${POSTGRES_USER} | gzip > ${DUMPFILE}
docker compose exec $DBC pg_dump -U ${POSTGRES_USER} | gzip > ${DUMPFILE}

