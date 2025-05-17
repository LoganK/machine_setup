#!/bin/bash
set -e -u

export BACKUP_DIR=../../backup/${PWD##*/}
export BACKUP_SKIP_VOLUME_RE="jellyfin_cache"

../../notes/backup_all_volumes.sh

