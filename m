From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 013/109] net: socket: add __sys_connect() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:50 +0200
Message-ID: <20180329112426.23043-14-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_connect() allows us to avoid the
internal calls to the sys_connect() syscall.

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
index e9cee272da13..7daa344d7320 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -365,5 +365,7 @@ extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 			 int __user *upeer_addrlen, int flags);
 extern int __sys_socket(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
+extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
+			 int addrlen);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index bba555b1d863..7ab6352268f3 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -817,7 +817,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_bind(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_CONNECT:
-		ret = sys_connect(a0, compat_ptr(a1), a[2]);
+		ret = __sys_connect(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_LISTEN:
 		ret = sys_listen(a0, a1);
diff --git a/net/socket.c b/net/socket.c
index 291cdae97341..64bdfdf6c6e7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1633,8 +1633,7 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
  *	include the -EINPROGRESS status for such sockets.
  */
 
-SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
-		int, addrlen)
+int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1660,6 +1659,12 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
 	return err;
 }
 
+SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
+		int, addrlen)
+{
+	return __sys_connect(fd, uservaddr, addrlen);
+}
+
 /*
  *	Get the local address ('name') of a socket object. Move the obtained
  *	name to user space.
@@ -2479,7 +2484,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = __sys_bind(a0, (struct sockaddr __user *)a1, a[2]);
 		break;
 	case SYS_CONNECT:
-		err = sys_connect(a0, (struct sockaddr __user *)a1, a[2]);
+		err = __sys_connect(a0, (struct sockaddr __user *)a1, a[2]);
 		break;
 	case SYS_LISTEN:
 		err = sys_listen(a0, a1);
-- 
2.16.3
