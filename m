From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 010/109] net: socket: add __sys_accept4() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:47 +0200
Message-ID: <20180329112426.23043-11-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_accept4() allows us to avoid the
internal calls to the sys_accept4() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  2 ++
 net/compat.c           |  4 ++--
 net/socket.c           | 20 +++++++++++++-------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 54b85abc7265..6a9840271676 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -361,5 +361,7 @@ extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 extern int __sys_sendto(int fd, void __user *buff, size_t len,
 			unsigned int flags, struct sockaddr __user *addr,
 			int addr_len);
+extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
+			 int __user *upeer_addrlen, int flags);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index fc82982d9b84..0ff9f7451b6f 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -823,7 +823,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
-		ret = sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), 0);
+		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), 0);
 		break;
 	case SYS_GETSOCKNAME:
 		ret = sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
@@ -873,7 +873,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 					  compat_ptr(a[4]));
 		break;
 	case SYS_ACCEPT4:
-		ret = sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), a[3]);
+		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), a[3]);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/net/socket.c b/net/socket.c
index 3f037a21ba5e..45f6ea0d57a5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1519,8 +1519,8 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
  *	clean when we restucture accept also.
  */
 
-SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
-		int __user *, upeer_addrlen, int, flags)
+int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
+		  int __user *upeer_addrlen, int flags)
 {
 	struct socket *sock, *newsock;
 	struct file *newfile;
@@ -1599,10 +1599,16 @@ SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
 	goto out_put;
 }
 
+SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
+		int __user *, upeer_addrlen, int, flags)
+{
+	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, flags);
+}
+
 SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
 		int __user *, upeer_addrlen)
 {
-	return sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
+	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
 }
 
 /*
@@ -2469,8 +2475,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
-		err = sys_accept4(a0, (struct sockaddr __user *)a1,
-				  (int __user *)a[2], 0);
+		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
+				    (int __user *)a[2], 0);
 		break;
 	case SYS_GETSOCKNAME:
 		err =
@@ -2525,8 +2531,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				   (struct timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
-		err = sys_accept4(a0, (struct sockaddr __user *)a1,
-				  (int __user *)a[2], a[3]);
+		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
+				    (int __user *)a[2], a[3]);
 		break;
 	default:
 		err = -EINVAL;
-- 
2.16.3
