#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Runtime directories
# ---------------------------------------------------------------------------
mkdir -p /var/run/sshd /run/rpcbind

# Ensure the nfsd pseudo–fs is mounted (needs SYS_ADMIN)
if ! mountpoint -q /proc/fs/nfsd; then
    mkdir -p /proc/fs/nfsd
    mount -t nfsd nfsd /proc/fs/nfsd || {
        echo "Cannot mount nfsd – start container with --privileged or SYS_ADMIN"
        exit 1
    }
fi

# 1. rpcbind (portmapper)
rpcbind -w

# 2. Export table
exportfs -ar          # read /etc/exports

# 3. Start NFSD kernel threads
rpc.nfsd 8            # add "-G 15" for grace period if you wish

# 4. mountd (for showmount/NFSv3)
rpc.mountd -F &

# 5. dnsmasq (PXE/DHCP/TFTP)
pgrep -x dnsmasq >/dev/null || dnsmasq -k --log-facility=- &

# 6. Samba
nmbd -D
smbd -D

# 7. Hand off to CMD (default sshd)
exec "$@"
