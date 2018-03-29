From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 024/109] net: socket: replace call to sys_recv() with __sys_recvfrom()
Date: Thu, 29 Mar 2018 13:23:01 +0200
Message-ID: <20180329112426.23043-25-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

sys_recv() merely expands the parameters to __sys_recvfrom() by NULL and
NULL. Open-code this in the two places which used sys_recv() as a wrapper
to __sys_recvfrom().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 3 ++-
 net/socket.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index d55982ff5c59..9e0d030063ad 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -755,7 +755,8 @@ COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, uns
 
 COMPAT_SYSCALL_DEFINE4(recv, int, fd, void __user *, buf, compat_size_t, len, unsigned int, flags)
 {
-	return sys_recv(fd, buf, len, flags | MSG_CMSG_COMPAT);
+	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, NULL,
+			      NULL);
 }
 
 COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len,
diff --git a/net/socket.c b/net/socket.c
index 92de21bb1a2e..03702f08aa62 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2566,7 +2566,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				   (struct sockaddr __user *)a[4], a[5]);
 		break;
 	case SYS_RECV:
-		err = sys_recv(a0, (void __user *)a1, a[2], a[3]);
+		err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
+				     NULL, NULL);
 		break;
 	case SYS_RECVFROM:
 		err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
-- 
2.16.3
