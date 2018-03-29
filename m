Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59720 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbeC2L0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:09 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 015/109] net: socket: add __sys_getsockname() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:52 +0200
Message-ID: <20180329112426.23043-16-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <20180329112252.V0_A-dK4_lHzaHRF5S8Z-1sEjUTR9I0T7WXq5vGuSVM@z>

Using the net-internal helper __sys_getsockname() allows us to avoid the
internal calls to the sys_getsockname() syscall.

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
index 7e37af25509d..ef0226a61b03 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -368,5 +368,7 @@ extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
 extern int __sys_listen(int fd, int backlog);
+extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
+			     int __user *usockaddr_len);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index c80cb973f383..efd28d02608c 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -826,7 +826,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), 0);
 		break;
 	case SYS_GETSOCKNAME:
-		ret = sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
+		ret = __sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_GETPEERNAME:
 		ret = sys_getpeername(a0, compat_ptr(a1), compat_ptr(a[2]));
diff --git a/net/socket.c b/net/socket.c
index 67d9d70a4734..b61e0d20f37b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1675,8 +1675,8 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
  *	name to user space.
  */
 
-SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
-		int __user *, usockaddr_len)
+int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
+		      int __user *usockaddr_len)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1701,6 +1701,12 @@ SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
 	return err;
 }
 
+SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
+		int __user *, usockaddr_len)
+{
+	return __sys_getsockname(fd, usockaddr, usockaddr_len);
+}
+
 /*
  *	Get the remote address ('name') of a socket object. Move the obtained
  *	name to user space.
@@ -2500,8 +2506,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_GETSOCKNAME:
 		err =
-		    sys_getsockname(a0, (struct sockaddr __user *)a1,
-				    (int __user *)a[2]);
+		    __sys_getsockname(a0, (struct sockaddr __user *)a1,
+				      (int __user *)a[2]);
 		break;
 	case SYS_GETPEERNAME:
 		err =
-- 
2.16.3
