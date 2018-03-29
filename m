From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 016/109] net: socket: add __sys_getpeername() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:53 +0200
Message-ID: <20180329112426.23043-17-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_getpeername() allows us to avoid the
internal calls to the sys_getpeername() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  2 ++
 net/compat.c           |  2 +-
 net/socket.c           | 14 ++++++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ef0226a61b03..9ba003e92fea 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -370,5 +370,7 @@ extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 extern int __sys_listen(int fd, int backlog);
 extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 			     int __user *usockaddr_len);
+extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
+			     int __user *usockaddr_len);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index efd28d02608c..74017f618eb1 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -829,7 +829,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_GETPEERNAME:
-		ret = sys_getpeername(a0, compat_ptr(a1), compat_ptr(a[2]));
+		ret = __sys_getpeername(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_SOCKETPAIR:
 		ret = sys_socketpair(a0, a1, a[2], compat_ptr(a[3]));
diff --git a/net/socket.c b/net/socket.c
index b61e0d20f37b..007fb9483279 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1712,8 +1712,8 @@ SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
  *	name to user space.
  */
 
-SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
-		int __user *, usockaddr_len)
+int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
+		      int __user *usockaddr_len)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1738,6 +1738,12 @@ SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
 	return err;
 }
 
+SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
+		int __user *, usockaddr_len)
+{
+	return __sys_getpeername(fd, usockaddr, usockaddr_len);
+}
+
 /*
  *	Send a datagram to a given address. We move the address into kernel
  *	space and check the user space data area is readable before invoking
@@ -2511,8 +2517,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_GETPEERNAME:
 		err =
-		    sys_getpeername(a0, (struct sockaddr __user *)a1,
-				    (int __user *)a[2]);
+		    __sys_getpeername(a0, (struct sockaddr __user *)a1,
+				      (int __user *)a[2]);
 		break;
 	case SYS_SOCKETPAIR:
 		err = sys_socketpair(a0, a1, a[2], (int __user *)a[3]);
-- 
2.16.3
