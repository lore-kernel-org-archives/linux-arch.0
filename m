From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 014/109] net: socket: add __sys_listen() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:51 +0200
Message-ID: <20180329112426.23043-15-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_listen() allows us to avoid the
internal calls to the sys_listen() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h | 1 +
 net/compat.c           | 2 +-
 net/socket.c           | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7daa344d7320..7e37af25509d 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -367,5 +367,6 @@ extern int __sys_socket(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
+extern int __sys_listen(int fd, int backlog);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 7ab6352268f3..c80cb973f383 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -820,7 +820,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_connect(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_LISTEN:
-		ret = sys_listen(a0, a1);
+		ret = __sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
 		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), 0);
diff --git a/net/socket.c b/net/socket.c
index 64bdfdf6c6e7..67d9d70a4734 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1496,7 +1496,7 @@ SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
  *	ready for listening.
  */
 
-SYSCALL_DEFINE2(listen, int, fd, int, backlog)
+int __sys_listen(int fd, int backlog)
 {
 	struct socket *sock;
 	int err, fput_needed;
@@ -1517,6 +1517,11 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
 	return err;
 }
 
+SYSCALL_DEFINE2(listen, int, fd, int, backlog)
+{
+	return __sys_listen(fd, backlog);
+}
+
 /*
  *	For accept, we attempt to create a new socket, set up the link
  *	with the client, wake up the client, then return the new
@@ -2487,7 +2492,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = __sys_connect(a0, (struct sockaddr __user *)a1, a[2]);
 		break;
 	case SYS_LISTEN:
-		err = sys_listen(a0, a1);
+		err = __sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.16.3
