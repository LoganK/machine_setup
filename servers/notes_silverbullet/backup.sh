#!/bin/bash
set -e -u

export BACKUP_DIR=../../backup/${PWD##*/}

../../notes/backup_all_volumes.sh

