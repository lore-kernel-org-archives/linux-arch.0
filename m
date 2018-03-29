From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 017/109] net: socket: add __sys_socketpair() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:54 +0200
Message-ID: <20180329112426.23043-18-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_socketpair() allows us to avoid the
internal calls to the sys_socketpair() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  2 ++
 net/compat.c           |  2 +-
 net/socket.c           | 11 ++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 9ba003e92fea..dbdddf0d079e 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -372,5 +372,7 @@ extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 			     int __user *usockaddr_len);
 extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
 			     int __user *usockaddr_len);
+extern int __sys_socketpair(int family, int type, int protocol,
+			    int __user *usockvec);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 74017f618eb1..04db26316438 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -832,7 +832,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_getpeername(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_SOCKETPAIR:
-		ret = sys_socketpair(a0, a1, a[2], compat_ptr(a[3]));
+		ret = __sys_socketpair(a0, a1, a[2], compat_ptr(a[3]));
 		break;
 	case SYS_SEND:
 		ret = sys_send(a0, compat_ptr(a1), a[2], a[3]);
diff --git a/net/socket.c b/net/socket.c
index 007fb9483279..5861821f46f5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1368,8 +1368,7 @@ SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
  *	Create a pair of connected sockets.
  */
 
-SYSCALL_DEFINE4(socketpair, int, family, int, type, int, protocol,
-		int __user *, usockvec)
+int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 {
 	struct socket *sock1, *sock2;
 	int fd1, fd2, err;
@@ -1454,6 +1453,12 @@ SYSCALL_DEFINE4(socketpair, int, family, int, type, int, protocol,
 	return err;
 }
 
+SYSCALL_DEFINE4(socketpair, int, family, int, type, int, protocol,
+		int __user *, usockvec)
+{
+	return __sys_socketpair(family, type, protocol, usockvec);
+}
+
 /*
  *	Bind a name to a socket. Nothing much to do here since it's
  *	the protocol's responsibility to handle the local address.
@@ -2521,7 +2526,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				      (int __user *)a[2]);
 		break;
 	case SYS_SOCKETPAIR:
-		err = sys_socketpair(a0, a1, a[2], (int __user *)a[3]);
+		err = __sys_socketpair(a0, a1, a[2], (int __user *)a[3]);
 		break;
 	case SYS_SEND:
 		err = sys_send(a0, (void __user *)a1, a[2], a[3]);
-- 
2.16.3
