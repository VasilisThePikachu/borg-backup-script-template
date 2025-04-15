#!/bin/sh

. ./vars.sh

borg init --encryption=keyfile-blake2 $BORG_REPO

borg key export $BORG_REPO "$SERVER_NAME-borg.borgkey"

echo "Keys have been copied to the current directory. BACK THEM UP along with your password"
