Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59098 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeC2L03 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:29 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 028/109] net: socket: add __compat_sys_recvmmsg() helper; remove in-kernel call to compat syscall
Date: Thu, 29 Mar 2018 13:23:05 +0200
Message-ID: <20180329112426.23043-29-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <20180329112305.416g-dLviIickcm9BetfvFgmqTcUsk3lFCOzI7KXF-0@z>

Using the net-internal helper __compat_sys_recvmmsg() allows us to avoid
the internal calls to the compat_sys_recvmmsg() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index cdf5b0c1b962..7b2ae42a1598 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -787,9 +787,9 @@ COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len
 	return __compat_sys_recvfrom(fd, buf, len, flags, addr, addrlen);
 }
 
-COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
-		       unsigned int, vlen, unsigned int, flags,
-		       struct compat_timespec __user *, timeout)
+static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+				 unsigned int vlen, unsigned int flags,
+				 struct compat_timespec __user *timeout)
 {
 	int datagrams;
 	struct timespec ktspec;
@@ -809,6 +809,13 @@ COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
 	return datagrams;
 }
 
+COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags,
+		       struct compat_timespec __user *, timeout)
+{
+	return __compat_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
+}
+
 COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 {
 	u32 a[AUDITSC_ARGS];
@@ -895,8 +902,8 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_RECVMMSG:
-		ret = compat_sys_recvmmsg(a0, compat_ptr(a1), a[2], a[3],
-					  compat_ptr(a[4]));
+		ret = __compat_sys_recvmmsg(a0, compat_ptr(a1), a[2], a[3],
+					    compat_ptr(a[4]));
 		break;
 	case SYS_ACCEPT4:
 		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), a[3]);
-- 
2.16.3
