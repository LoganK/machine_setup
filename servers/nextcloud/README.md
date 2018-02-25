# Setup

    $ sudo zfs set mountpoint=/var/lib/docker/volumes zpool-external/docker_volumes

# Launch

    $ docker-compose up -d

# Restore

Last resort! Should be backed up on ZFS as a whole.

    $ sudo rsync -AaP /zpool-external/nextcloud/data/ /var/lib/docker/volumes/nextcloud_nextcloud_data/
    $ docker-compose exec db psql -U nextcloud -d postgres -c "DROP DATABASE \"nextcloud\";"
    $ docker-compose exec db psql -U nextcloud -d postgres -c "CREATE DATABASE \"nextcloud\";"
    $ docker cp /zpool-external/backup/nextcloud-pgsqlbkp_20170827.bak "$(docker-compose ps -q db)":/backup.sql
    $ docker-compose exec db bash
        # psql -U nextcloud -d nextcloud --set ON_ERROR_STOP=on < /backup.sql
