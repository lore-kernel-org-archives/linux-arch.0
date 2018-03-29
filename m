From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 027/109] net: socket: add __compat_sys_getsockopt() helper; remove in-kernel call to compat syscall
Date: Thu, 29 Mar 2018 13:23:04 +0200
Message-ID: <20180329112426.23043-28-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __compat_sys_getsockopt() allows us to avoid
the internal calls to the compat_sys_getsockopt() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 75bfcbbb2e3e..cdf5b0c1b962 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -509,8 +509,9 @@ int compat_sock_get_timestampns(struct sock *sk, struct timespec __user *usersta
 }
 EXPORT_SYMBOL(compat_sock_get_timestampns);
 
-COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
-		       char __user *, optval, int __user *, optlen)
+static int __compat_sys_getsockopt(int fd, int level, int optname,
+				   char __user *optval,
+				   int __user *optlen)
 {
 	int err;
 	struct socket *sock = sockfd_lookup(fd, &err);
@@ -536,6 +537,12 @@ COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 	return err;
 }
 
+COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
+		       char __user *, optval, int __user *, optlen)
+{
+	return __compat_sys_getsockopt(fd, level, optname, optval, optlen);
+}
+
 struct compat_group_req {
 	__u32				 gr_interface;
 	struct __kernel_sockaddr_storage gr_group
@@ -874,8 +881,9 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 					      compat_ptr(a[3]), a[4]);
 		break;
 	case SYS_GETSOCKOPT:
-		ret = compat_sys_getsockopt(a0, a1, a[2],
-				compat_ptr(a[3]), compat_ptr(a[4]));
+		ret = __compat_sys_getsockopt(a0, a1, a[2],
+					      compat_ptr(a[3]),
+					      compat_ptr(a[4]));
 		break;
 	case SYS_SENDMSG:
 		ret = compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
-- 
2.16.3
