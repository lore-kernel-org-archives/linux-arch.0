From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 022/109] net: socket: move check for forbid_cmsg_compat to __sys_...msg()
Date: Thu, 29 Mar 2018 13:22:59 +0200
Message-ID: <20180329112426.23043-23-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The non-compat codepaths for sys_...msg() verify that MSG_CMSG_COMPAT
is not set. By moving this check to the __sys_...msg() functions
(and making it dependent on a static flag passed to this function), we
can call the __sys...msg() functions instead of the syscall functions
in all cases. __sys_recvmmsg() does not need this trickery, as the
check is handled within the do_sys_recvmmsg() function internal to
net/socket.c.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h | 13 +++++++++----
 net/compat.c           |  8 +++++---
 net/socket.c           | 38 +++++++++++++++++++++++---------------
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index cad120e4ed4b..e2b6bd4fe977 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -346,13 +346,18 @@ extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
 struct timespec;
 
-/* The __sys_...msg variants allow MSG_CMSG_COMPAT */
-extern long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
-extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
+/* The __sys_...msg variants allow MSG_CMSG_COMPAT iff
+ * forbid_cmsg_compat==false
+ */
+extern long __sys_recvmsg(int fd, struct user_msghdr __user *msg,
+			  unsigned int flags, bool forbid_cmsg_compat);
+extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
+			  unsigned int flags, bool forbid_cmsg_compat);
 extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 			  unsigned int flags, struct timespec *timeout);
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
-			  unsigned int vlen, unsigned int flags);
+			  unsigned int vlen, unsigned int flags,
+			  bool forbid_cmsg_compat);
 
 /* helpers which do the actual work for syscalls */
 extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
diff --git a/net/compat.c b/net/compat.c
index f1ec23e9dfce..5caa48987bb2 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -736,19 +736,21 @@ static unsigned char nas[21] = {
 
 COMPAT_SYSCALL_DEFINE3(sendmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
 {
-	return __sys_sendmsg(fd, (struct user_msghdr __user *)msg, flags | MSG_CMSG_COMPAT);
+	return __sys_sendmsg(fd, (struct user_msghdr __user *)msg,
+			     flags | MSG_CMSG_COMPAT, false);
 }
 
 COMPAT_SYSCALL_DEFINE4(sendmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
 		       unsigned int, vlen, unsigned int, flags)
 {
 	return __sys_sendmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
-			      flags | MSG_CMSG_COMPAT);
+			      flags | MSG_CMSG_COMPAT, false);
 }
 
 COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
 {
-	return __sys_recvmsg(fd, (struct user_msghdr __user *)msg, flags | MSG_CMSG_COMPAT);
+	return __sys_recvmsg(fd, (struct user_msghdr __user *)msg,
+			     flags | MSG_CMSG_COMPAT, false);
 }
 
 COMPAT_SYSCALL_DEFINE4(recv, int, fd, void __user *, buf, compat_size_t, len, unsigned int, flags)
diff --git a/net/socket.c b/net/socket.c
index 54d19b0edab1..a70793a7ce78 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2137,12 +2137,16 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
  *	BSD sendmsg interface
  */
 
-long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags)
+long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
+		   bool forbid_cmsg_compat)
 {
 	int fput_needed, err;
 	struct msghdr msg_sys;
 	struct socket *sock;
 
+	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
+		return -EINVAL;
+
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		goto out;
@@ -2156,9 +2160,7 @@ long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags)
 
 SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int, flags)
 {
-	if (flags & MSG_CMSG_COMPAT)
-		return -EINVAL;
-	return __sys_sendmsg(fd, msg, flags);
+	return __sys_sendmsg(fd, msg, flags, true);
 }
 
 /*
@@ -2166,7 +2168,7 @@ SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int
  */
 
 int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-		   unsigned int flags)
+		   unsigned int flags, bool forbid_cmsg_compat)
 {
 	int fput_needed, err, datagrams;
 	struct socket *sock;
@@ -2176,6 +2178,9 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 	struct used_address used_address;
 	unsigned int oflags = flags;
 
+	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
+		return -EINVAL;
+
 	if (vlen > UIO_MAXIOV)
 		vlen = UIO_MAXIOV;
 
@@ -2232,9 +2237,7 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 SYSCALL_DEFINE4(sendmmsg, int, fd, struct mmsghdr __user *, mmsg,
 		unsigned int, vlen, unsigned int, flags)
 {
-	if (flags & MSG_CMSG_COMPAT)
-		return -EINVAL;
-	return __sys_sendmmsg(fd, mmsg, vlen, flags);
+	return __sys_sendmmsg(fd, mmsg, vlen, flags, true);
 }
 
 static int ___sys_recvmsg(struct socket *sock, struct user_msghdr __user *msg,
@@ -2307,12 +2310,16 @@ static int ___sys_recvmsg(struct socket *sock, struct user_msghdr __user *msg,
  *	BSD recvmsg interface
  */
 
-long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned flags)
+long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
+		   bool forbid_cmsg_compat)
 {
 	int fput_needed, err;
 	struct msghdr msg_sys;
 	struct socket *sock;
 
+	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
+		return -EINVAL;
+
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		goto out;
@@ -2327,9 +2334,7 @@ long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned flags)
 SYSCALL_DEFINE3(recvmsg, int, fd, struct user_msghdr __user *, msg,
 		unsigned int, flags)
 {
-	if (flags & MSG_CMSG_COMPAT)
-		return -EINVAL;
-	return __sys_recvmsg(fd, msg, flags);
+	return __sys_recvmsg(fd, msg, flags, true);
 }
 
 /*
@@ -2580,13 +2585,16 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				     (int __user *)a[4]);
 		break;
 	case SYS_SENDMSG:
-		err = sys_sendmsg(a0, (struct user_msghdr __user *)a1, a[2]);
+		err = __sys_sendmsg(a0, (struct user_msghdr __user *)a1,
+				    a[2], true);
 		break;
 	case SYS_SENDMMSG:
-		err = sys_sendmmsg(a0, (struct mmsghdr __user *)a1, a[2], a[3]);
+		err = __sys_sendmmsg(a0, (struct mmsghdr __user *)a1, a[2],
+				     a[3], true);
 		break;
 	case SYS_RECVMSG:
-		err = sys_recvmsg(a0, (struct user_msghdr __user *)a1, a[2]);
+		err = __sys_recvmsg(a0, (struct user_msghdr __user *)a1,
+				    a[2], true);
 		break;
 	case SYS_RECVMMSG:
 		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
-- 
2.16.3
