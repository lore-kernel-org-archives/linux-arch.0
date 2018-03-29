From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 012/109] net: socket: add __sys_bind() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:49 +0200
Message-ID: <20180329112426.23043-13-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_bind() allows us to avoid the
internal calls to the sys_bind() syscall.

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
index f8d040434a13..e9cee272da13 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -364,5 +364,6 @@ extern int __sys_sendto(int fd, void __user *buff, size_t len,
 extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 			 int __user *upeer_addrlen, int flags);
 extern int __sys_socket(int family, int type, int protocol);
+extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 5b3b74c5812e..bba555b1d863 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -814,7 +814,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_socket(a0, a1, a[2]);
 		break;
 	case SYS_BIND:
-		ret = sys_bind(a0, compat_ptr(a1), a[2]);
+		ret = __sys_bind(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_CONNECT:
 		ret = sys_connect(a0, compat_ptr(a1), a[2]);
diff --git a/net/socket.c b/net/socket.c
index 07f379e50def..291cdae97341 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1462,7 +1462,7 @@ SYSCALL_DEFINE4(socketpair, int, family, int, type, int, protocol,
  *	the protocol layer (having also checked the address is ok).
  */
 
-SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
+int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1485,6 +1485,11 @@ SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
 	return err;
 }
 
+SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
+{
+	return __sys_bind(fd, umyaddr, addrlen);
+}
+
 /*
  *	Perform a listen. Basically, we allow the protocol to do anything
  *	necessary for a listen, and if that works, we mark the socket as
@@ -2471,7 +2476,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = __sys_socket(a0, a1, a[2]);
 		break;
 	case SYS_BIND:
-		err = sys_bind(a0, (struct sockaddr __user *)a1, a[2]);
+		err = __sys_bind(a0, (struct sockaddr __user *)a1, a[2]);
 		break;
 	case SYS_CONNECT:
 		err = sys_connect(a0, (struct sockaddr __user *)a1, a[2]);
-- 
2.16.3
