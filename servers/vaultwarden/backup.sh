#!/bin/bash
set -e -u

export BACKUP_SKIP_VOLUME_RE=".*db[[:digit:]]+"
../../notes/backup_all_volumes.sh

../../notes/backup_postgres.sh

