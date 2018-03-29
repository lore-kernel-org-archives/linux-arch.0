From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 009/109] net: socket: add __sys_sendto() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:46 +0200
Message-ID: <20180329112426.23043-10-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_sendto() allows us to avoid the
internal calls to the sys_sendto() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  3 +++
 net/compat.c           |  3 ++-
 net/socket.c           | 19 ++++++++++++-------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 40cc93b91628..54b85abc7265 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -358,5 +358,8 @@ extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 			  unsigned int flags, struct sockaddr __user *addr,
 			  int __user *addr_len);
+extern int __sys_sendto(int fd, void __user *buff, size_t len,
+			unsigned int flags, struct sockaddr __user *addr,
+			int addr_len);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 2d8186c277b2..fc82982d9b84 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -838,7 +838,8 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = sys_send(a0, compat_ptr(a1), a[2], a[3]);
 		break;
 	case SYS_SENDTO:
-		ret = sys_sendto(a0, compat_ptr(a1), a[2], a[3], compat_ptr(a[4]), a[5]);
+		ret = __sys_sendto(a0, compat_ptr(a1), a[2], a[3],
+				   compat_ptr(a[4]), a[5]);
 		break;
 	case SYS_RECV:
 		ret = compat_sys_recv(a0, compat_ptr(a1), a[2], a[3]);
diff --git a/net/socket.c b/net/socket.c
index 712d99d8680f..3f037a21ba5e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1711,10 +1711,8 @@ SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
  *	space and check the user space data area is readable before invoking
  *	the protocol.
  */
-
-SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
-		unsigned int, flags, struct sockaddr __user *, addr,
-		int, addr_len)
+int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
+		 struct sockaddr __user *addr,  int addr_len)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1752,6 +1750,13 @@ SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
 	return err;
 }
 
+SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
+		unsigned int, flags, struct sockaddr __user *, addr,
+		int, addr_len)
+{
+	return __sys_sendto(fd, buff, len, flags, addr, addr_len);
+}
+
 /*
  *	Send a datagram down a socket.
  */
@@ -1759,7 +1764,7 @@ SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
 SYSCALL_DEFINE4(send, int, fd, void __user *, buff, size_t, len,
 		unsigned int, flags)
 {
-	return sys_sendto(fd, buff, len, flags, NULL, 0);
+	return __sys_sendto(fd, buff, len, flags, NULL, 0);
 }
 
 /*
@@ -2484,8 +2489,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = sys_send(a0, (void __user *)a1, a[2], a[3]);
 		break;
 	case SYS_SENDTO:
-		err = sys_sendto(a0, (void __user *)a1, a[2], a[3],
-				 (struct sockaddr __user *)a[4], a[5]);
+		err = __sys_sendto(a0, (void __user *)a1, a[2], a[3],
+				   (struct sockaddr __user *)a[4], a[5]);
 		break;
 	case SYS_RECV:
 		err = sys_recv(a0, (void __user *)a1, a[2], a[3]);
-- 
2.16.3
