#!/usr/bin/env bash
set -e

# 0. Runtime dirs
mkdir -p /var/run/sshd /run/rpcbind /proc/fs/nfsd

# 1. rpcbind
rpcbind -w

# 2. nfsd kernel threads
rpc.nfsd -G 15        # autoloads nfsd module
rpc.mountd -F --no-nfs-version 2 --no-nfs-version 3 &

# 3. Export table
exportfs -r

# 4. UID/GID mapper for NFSv4
rpc.idmapd -f &

# 5. dnsmasq (PXE/DHCP/TFTP) if not already running
if ! pgrep -x dnsmasq >/dev/null 2>&1; then
  dnsmasq -k --log-facility=- &
fi

# 6. Hand off to CMD (defaults to sshd -D)
exec "$@"
