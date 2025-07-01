#!/usr/bin/env bash
set -e

# 0. runtime dirs
mkdir -p /var/run/sshd /run/rpcbind /proc/fs/nfsd /var/run/samba

# 1. rpcbind for all ONC-RPC services
rpcbind -w

# 2. kernel NFS threads (v4)
rpc.nfsd -G 15

# 3. rpc.mountd (v3 export list – helps showmount)
rpc.mountd -F &

# 4. export table -> kernel
exportfs -r

# 5. dnsmasq (DHCP/TFTP/PXE)
if ! pgrep -x dnsmasq >/dev/null 2>&1; then
  dnsmasq -k --log-facility=- &
fi

# 6. Samba (SMB/CIFS)
nmbd -D            # NetBIOS name server
smbd -D            # SMB file server

# 7. hand off to CMD (default: sshd -D -p 2222)
exec "$@"
