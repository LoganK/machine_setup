#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
  cat <<zzzEOLzzz
Upgrades the Docker volume data for a Postgres database.

Usage:
  $0 <volume_old> <volume_new>
zzzEOLzzz

  exit 1
fi

VOLUME_OLD=$1
VOLUME_NEW=$2

VOLUME_BACKUP=${VOLUME_OLD}_backup
POSTGRES_OLD=postgres:10
POSTGRES_NEW=postgres:11

# Get POSTGRES_{DB,USER,PASSWORD}
source db.env

# Optional
docker volume create --name ${VOLUME_BACKUP}
docker run --rm -it -v ${VOLUME_OLD}:/from -v ${VOLUME_BACKUP}:/to alpine ash -c "cd /from ; cp -a . /to"

# Dump the old database
DBC=$(docker run --rm -d -v ${VOLUME_OLD}:/var/lib/postgresql/data ${POSTGRES_OLD})
echo -n "Wait for old startup"
docker exec $DBC bash -c "while ! psql -U ${POSTGRES_USER} -c '\\dt' >& /dev/null; do echo -n .; sleep .2; done"
echo ""
DUMPFILE=${VOLUME_OLD}.sql.gz
echo "Creating ${DUMPFILE}..."
docker exec $DBC pg_dumpall -U ${POSTGRES_USER} | gzip > ${DUMPFILE}
docker stop $DBC

docker volume create --name ${VOLUME_NEW}
DBD=$(docker run --rm -d --env-file ./db.env -v ${VOLUME_NEW}:/var/lib/postgresql/data ${POSTGRES_NEW})
echo -n "Wait for old startup"
docker exec $DBD bash -c "while ! psql -U ${POSTGRES_USER} -c '\\dt' >& /dev/null; do echo -n .; sleep .2; done"
echo ""
gzip -dc ${DUMPFILE} | docker exec $DBD psql -U ${POSTGRES_USER}
docker stop $DBD

# Force 
# Update volume mapping in docker-compose.yml and force it to be picked up.
#docker-compose stop db
#docker-compose rm db

echo "To clean up the old volumes: docker volume rm ${VOLUME_BACKUP} ${VOLUME_OLD}"
