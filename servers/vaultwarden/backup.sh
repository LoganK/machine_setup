#!/bin/bash
set -e -u

export BACKUP_DIR=../../backup/${PWD##*/}/$(date +%F_%H_%M)

export BACKUP_SKIP_VOLUME_RE=".*db[[:digit:]]+"
../../notes/backup_all_volumes.sh

../../notes/backup_postgres.sh

