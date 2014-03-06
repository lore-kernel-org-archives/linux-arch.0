From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 06/16] net/compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:13 +0100
Message-ID: <1394121083-2507-7-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:54624 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbaCFPve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:34 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0851E1B08040
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:15 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpIcf57147556
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:18 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpSfF017426
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:29 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Convert all compat system call functions where all parameter types
have a size of four or less than four bytes, or are pointer types
to COMPAT_SYSCALL_DEFINE.
The implicit casts within COMPAT_SYSCALL_DEFINE will perform proper
zero and sign extension to 64 bit of all parameters if needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 net/compat.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index f50161fb812e..706b78be9a23 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -384,8 +384,8 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 	return sock_setsockopt(sock, level, optname, optval, optlen);
 }
 
-asmlinkage long compat_sys_setsockopt(int fd, int level, int optname,
-				char __user *optval, unsigned int optlen)
+COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
+		       char __user *, optval, unsigned int, optlen)
 {
 	int err;
 	struct socket *sock = sockfd_lookup(fd, &err);
@@ -504,8 +504,8 @@ int compat_sock_get_timestampns(struct sock *sk, struct timespec __user *usersta
 }
 EXPORT_SYMBOL(compat_sock_get_timestampns);
 
-asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
-				char __user *optval, int __user *optlen)
+COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
+		       char __user *, optval, int __user *, optlen)
 {
 	int err;
 	struct socket *sock = sockfd_lookup(fd, &err);
@@ -735,15 +735,15 @@ static unsigned char nas[21] = {
 };
 #undef AL
 
-asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg, unsigned int flags)
+COMPAT_SYSCALL_DEFINE3(sendmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
 {
 	if (flags & MSG_CMSG_COMPAT)
 		return -EINVAL;
 	return __sys_sendmsg(fd, (struct msghdr __user *)msg, flags | MSG_CMSG_COMPAT);
 }
 
-asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
-				    unsigned int vlen, unsigned int flags)
+COMPAT_SYSCALL_DEFINE4(sendmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags)
 {
 	if (flags & MSG_CMSG_COMPAT)
 		return -EINVAL;
@@ -751,7 +751,7 @@ asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 			      flags | MSG_CMSG_COMPAT);
 }
 
-asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg, unsigned int flags)
+COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
 {
 	if (flags & MSG_CMSG_COMPAT)
 		return -EINVAL;
@@ -770,9 +770,9 @@ asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, size_t len,
 	return sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr, addrlen);
 }
 
-asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
-				    unsigned int vlen, unsigned int flags,
-				    struct compat_timespec __user *timeout)
+COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags,
+		       struct compat_timespec __user *, timeout)
 {
 	int datagrams;
 	struct timespec ktspec;
@@ -795,7 +795,7 @@ asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 	return datagrams;
 }
 
-asmlinkage long compat_sys_socketcall(int call, u32 __user *args)
+COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 {
 	int ret;
 	u32 a[6];
-- 
1.8.4.5
