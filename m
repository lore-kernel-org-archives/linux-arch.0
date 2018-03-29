From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 029/109] net: socket: add __compat_sys_...msg() helpers; remove in-kernel calls to compat syscalls
Date: Thu, 29 Mar 2018 13:23:06 +0200
Message-ID: <20180329112426.23043-30-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the net-internal helpers __compat_sys_...msg() allows us to avoid
the internal calls to the compat_sys_...msg() syscalls.
compat_sys_recvmmsg() is handled in a different patch.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 7b2ae42a1598..5ae7437d3853 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -747,25 +747,48 @@ static unsigned char nas[21] = {
 };
 #undef AL
 
-COMPAT_SYSCALL_DEFINE3(sendmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
+static inline long __compat_sys_sendmsg(int fd,
+					struct compat_msghdr __user *msg,
+					unsigned int flags)
 {
 	return __sys_sendmsg(fd, (struct user_msghdr __user *)msg,
 			     flags | MSG_CMSG_COMPAT, false);
 }
 
-COMPAT_SYSCALL_DEFINE4(sendmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
-		       unsigned int, vlen, unsigned int, flags)
+COMPAT_SYSCALL_DEFINE3(sendmsg, int, fd, struct compat_msghdr __user *, msg,
+		       unsigned int, flags)
+{
+	return __compat_sys_sendmsg(fd, msg, flags);
+}
+
+static inline long __compat_sys_sendmmsg(int fd,
+					 struct compat_mmsghdr __user *mmsg,
+					 unsigned int vlen, unsigned int flags)
 {
 	return __sys_sendmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 			      flags | MSG_CMSG_COMPAT, false);
 }
 
-COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
+COMPAT_SYSCALL_DEFINE4(sendmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags)
+{
+	return __compat_sys_sendmmsg(fd, mmsg, vlen, flags);
+}
+
+static inline long __compat_sys_recvmsg(int fd,
+					struct compat_msghdr __user *msg,
+					unsigned int flags)
 {
 	return __sys_recvmsg(fd, (struct user_msghdr __user *)msg,
 			     flags | MSG_CMSG_COMPAT, false);
 }
 
+COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg,
+		       unsigned int, flags)
+{
+	return __compat_sys_recvmsg(fd, msg, flags);
+}
+
 static inline long __compat_sys_recvfrom(int fd, void __user *buf,
 					 compat_size_t len, unsigned int flags,
 					 struct sockaddr __user *addr,
@@ -893,13 +916,13 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 					      compat_ptr(a[4]));
 		break;
 	case SYS_SENDMSG:
-		ret = compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
+		ret = __compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_SENDMMSG:
-		ret = compat_sys_sendmmsg(a0, compat_ptr(a1), a[2], a[3]);
+		ret = __compat_sys_sendmmsg(a0, compat_ptr(a1), a[2], a[3]);
 		break;
 	case SYS_RECVMSG:
-		ret = compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
+		ret = __compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_RECVMMSG:
 		ret = __compat_sys_recvmmsg(a0, compat_ptr(a1), a[2], a[3],
-- 
2.16.3
