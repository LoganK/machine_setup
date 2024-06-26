#!/bin/bash
set -e -u

export BACKUP_DIR=../../backup/${PWD##*/}

docker compose exec -u www-data app php occ maintenance:mode --on

export BACKUP_SKIP_VOLUME_RE=".*db[[:digit:]]+"
../../notes/backup_all_volumes.sh

../../notes/backup_postgres.sh

docker compose exec -u www-data app php occ maintenance:mode --off

