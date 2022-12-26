#!/bin/bash
set -e -u

export BACKUP_SKIP_VOLUME_RE=".*(log|mysql)"
../../notes/backup_all_volumes.sh

export DBC=app
../../notes/backup_mysql.sh

