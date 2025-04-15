. ./vars.sh

echo "In case of failure, ensure python-pyfuse3 is installed"

mkdir /tmp/borg_mount
borg mount $BORG_REPO /tmp/borg_mount
cd /tmp/borg_mount

echo "Unmount using:"
echo "fusermount -u /tmp/borg_mount"
