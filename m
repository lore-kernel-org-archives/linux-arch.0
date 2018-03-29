From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 025/109] net: socket: add __compat_sys_recvfrom() helper; remove in-kernel call to compat syscall
Date: Thu, 29 Mar 2018 13:23:02 +0200
Message-ID: <20180329112426.23043-26-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helper __compat_sys_recvfrom() allows us to avoid
the internal calls to the compat_sys_recvfrom() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 9e0d030063ad..513adc8d0e0f 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -753,18 +753,25 @@ COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, uns
 			     flags | MSG_CMSG_COMPAT, false);
 }
 
+static inline long __compat_sys_recvfrom(int fd, void __user *buf,
+					 compat_size_t len, unsigned int flags,
+					 struct sockaddr __user *addr,
+					 int __user *addrlen)
+{
+	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr,
+			      addrlen);
+}
+
 COMPAT_SYSCALL_DEFINE4(recv, int, fd, void __user *, buf, compat_size_t, len, unsigned int, flags)
 {
-	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, NULL,
-			      NULL);
+	return __compat_sys_recvfrom(fd, buf, len, flags, NULL, NULL);
 }
 
 COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len,
 		       unsigned int, flags, struct sockaddr __user *, addr,
 		       int __user *, addrlen)
 {
-	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr,
-			      addrlen);
+	return __compat_sys_recvfrom(fd, buf, len, flags, addr, addrlen);
 }
 
 COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
@@ -845,11 +852,13 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 				   compat_ptr(a[4]), a[5]);
 		break;
 	case SYS_RECV:
-		ret = compat_sys_recv(a0, compat_ptr(a1), a[2], a[3]);
+		ret = __compat_sys_recvfrom(a0, compat_ptr(a1), a[2], a[3],
+					    NULL, NULL);
 		break;
 	case SYS_RECVFROM:
-		ret = compat_sys_recvfrom(a0, compat_ptr(a1), a[2], a[3],
-					  compat_ptr(a[4]), compat_ptr(a[5]));
+		ret = __compat_sys_recvfrom(a0, compat_ptr(a1), a[2], a[3],
+					    compat_ptr(a[4]),
+					    compat_ptr(a[5]));
 		break;
 	case SYS_SHUTDOWN:
 		ret = __sys_shutdown(a0, a1);
-- 
2.16.3
