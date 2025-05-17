#!/bin/bash
set -e

mapfile -t CONFIG_FILES < <(docker compose ls --format json | jq -r '.[].ConfigFiles')
for cf in ${CONFIG_FILES[@]}; do
	# Strip overrides
	cf=$(echo $cf | sed 's|,.*||')
	pushd "$(dirname $cf)"
	./backup.sh || true
	popd
done

