Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59716 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeC2L0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:09 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 021/109] net: socket: add do_sys_recvmmsg() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:22:58 +0200
Message-ID: <20180329112426.23043-22-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <20180329112258.li-tp5HEshpGx9cmJCUP1fxTXRBvZpXZa05aSBtmjNc@z>

Using the net-internal helper do_sys_recvmmsg() allows us to avoid the
internal calls to the sys_getsockopt() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/socket.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index a05289b1f863..54d19b0edab1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2445,9 +2445,9 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 	return datagrams;
 }
 
-SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
-		unsigned int, vlen, unsigned int, flags,
-		struct timespec __user *, timeout)
+static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
+			   unsigned int vlen, unsigned int flags,
+			   struct timespec __user *timeout)
 {
 	int datagrams;
 	struct timespec timeout_sys;
@@ -2470,6 +2470,13 @@ SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
 	return datagrams;
 }
 
+SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
+		unsigned int, vlen, unsigned int, flags,
+		struct timespec __user *, timeout)
+{
+	return do_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
+}
+
 #ifdef __ARCH_WANT_SYS_SOCKETCALL
 /* Argument list sizes for sys_socketcall */
 #define AL(x) ((x) * sizeof(unsigned long))
@@ -2582,8 +2589,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = sys_recvmsg(a0, (struct user_msghdr __user *)a1, a[2]);
 		break;
 	case SYS_RECVMMSG:
-		err = sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2], a[3],
-				   (struct timespec __user *)a[4]);
+		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
+				      a[3], (struct timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.16.3
