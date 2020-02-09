#!/bin/bash
set -e

BACKUP_SKIP_VOLUME_RE=${BACKUP_SKIP_VOLUME_RE:-}

for volume in $(docker-compose ps -q \
   | xargs docker container inspect -f "{{ range .Mounts }}{{ .Name }} {{ end }}"); do
  if echo $volume | grep -qE "^${BACKUP_SKIP_VOLUME_RE}$"; then
    continue
  fi
  $(dirname "${BASH_SOURCE[0]}")/backup_volume.sh $volume
done

