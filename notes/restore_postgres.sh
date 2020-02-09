#!/bin/bash
set -e -u

if [ "$#" -ne 1 ]; then
  cat <<zzzEOLzzz
Restore a Docker Postgres DB.

Environment:
  DBC - The name of the Postgres database in your docker-compose file.

Usage:
  $0 <backup_file>
zzzEOLzzz

  exit 1
fi

DUMPFILE=$1

DBC=${DBC:-db}

# Get POSTGRES_{DB,USER,PASSWORD}
source db.env

echo -n "Starting database ${DBC} to restore ${DUMPFILE}"
docker-compose up -d ${DBC}
sleep 3
docker-compose exec ${DBC} bash -c "while ! psql -U ${POSTGRES_USER} -c '\\dt' >& /dev/null; do echo -n .; sleep .2; done"
echo ""

gzip -dc ${DUMPFILE} | docker-compose exec -T ${DBC} psql -U ${POSTGRES_USER} > /dev/null

echo "Stopping database"
docker-compose stop ${DBC}

