From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 020/109] net: socket: add __sys_getsockopt() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:57 +0200
Message-ID: <20180329112426.23043-21-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __sys_getsockopt() allows us to avoid the
internal calls to the sys_getsockopt() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/socket.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 5dd2e39a6cd4..a05289b1f863 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1918,8 +1918,8 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
  *	to pass a user mode parameter for the protocols to sort out.
  */
 
-SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
-		char __user *, optval, int __user *, optlen)
+static int __sys_getsockopt(int fd, int level, int optname,
+			    char __user *optval, int __user *optlen)
 {
 	int err, fput_needed;
 	struct socket *sock;
@@ -1944,6 +1944,12 @@ SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 	return err;
 }
 
+SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
+		char __user *, optval, int __user *, optlen)
+{
+	return __sys_getsockopt(fd, level, optname, optval, optlen);
+}
+
 /*
  *	Shutdown a socket.
  */
@@ -2563,8 +2569,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_GETSOCKOPT:
 		err =
-		    sys_getsockopt(a0, a1, a[2], (char __user *)a[3],
-				   (int __user *)a[4]);
+		    __sys_getsockopt(a0, a1, a[2], (char __user *)a[3],
+				     (int __user *)a[4]);
 		break;
 	case SYS_SENDMSG:
 		err = sys_sendmsg(a0, (struct user_msghdr __user *)a1, a[2]);
-- 
2.16.3
