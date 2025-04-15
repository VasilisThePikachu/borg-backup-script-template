#!/bin/sh

. ./vars.sh

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Start backup"

#Here the backup is created, adjust it the way you would like to have it.
borg create                    \
    --stats                    \
    --progress \
    --compression auto,zstd,9          \
    --exclude-caches \
    --exclude-from ./exclude.txt \
    ::'Auto-Backup-{now}'        \
    $TO_BACKUP

backup_exit=$?

info "Deleting old backups"
# Automatic deletion of old backups
borg prune                          \
--glob-archives 'Auto-Backup-*'              \
    --keep-daily    7              \
    --keep-weekly  4                \
    --keep-monthly  6

prune_exit=$?

# Information on whether the backup worked.
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
