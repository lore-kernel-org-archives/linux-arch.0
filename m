From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 13/16] net/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
Date: Thu,  6 Mar 2014 16:51:20 +0100
Message-ID: <1394121083-2507-14-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:44237 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbaCFPvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:38 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DF7A6219004D
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:30 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpMfk46989404
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:22 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpWnT017656
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:33 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

In order to allow the COMPAT_SYSCALL_DEFINE macro generate code that
performs proper zero and sign extension convert all 64 bit parameters
to their corresponding 32 bit compat counterparts.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/compat.h | 4 ++--
 net/compat.c           | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f670e591aff8..8e636211f334 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -569,9 +569,9 @@ asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags);
 asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 				   unsigned int flags);
-asmlinkage long compat_sys_recv(int fd, void __user *buf, size_t len,
+asmlinkage long compat_sys_recv(int fd, void __user *buf, compat_size_t len,
 				unsigned flags);
-asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, size_t len,
+asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
 			    unsigned flags, struct sockaddr __user *addr,
 			    int __user *addrlen);
 asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
diff --git a/net/compat.c b/net/compat.c
index 706b78be9a23..9a76eaf63184 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -758,14 +758,14 @@ COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, uns
 	return __sys_recvmsg(fd, (struct msghdr __user *)msg, flags | MSG_CMSG_COMPAT);
 }
 
-asmlinkage long compat_sys_recv(int fd, void __user *buf, size_t len, unsigned int flags)
+COMPAT_SYSCALL_DEFINE4(recv, int, fd, void __user *, buf, compat_size_t, len, unsigned int, flags)
 {
 	return sys_recv(fd, buf, len, flags | MSG_CMSG_COMPAT);
 }
 
-asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, size_t len,
-				    unsigned int flags, struct sockaddr __user *addr,
-				    int __user *addrlen)
+COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len,
+		       unsigned int, flags, struct sockaddr __user *, addr,
+		       int __user *, addrlen)
 {
 	return sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr, addrlen);
 }
-- 
1.8.4.5
