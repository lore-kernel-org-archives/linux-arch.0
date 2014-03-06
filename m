From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 15/16] mm/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
Date: Thu,  6 Mar 2014 16:51:22 +0100
Message-ID: <1394121083-2507-16-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:56765 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbaCFPvj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:39 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4CC512190061
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:32 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpOiL61079634
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:24 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpXIr017719
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:35 -0700
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
 include/linux/compat.h | 10 +++++-----
 kernel/compat.c        | 10 +++++-----
 mm/process_vm_access.c | 26 ++++++++++++--------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index ef4834c5bcab..7c765624b7ef 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -469,7 +469,7 @@ asmlinkage long compat_sys_timerfd_settime(int ufd, int flags,
 asmlinkage long compat_sys_timerfd_gettime(int ufd,
 				   struct compat_itimerspec __user *otmr);
 
-asmlinkage long compat_sys_move_pages(pid_t pid, unsigned long nr_page,
+asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
 				      __u32 __user *pages,
 				      const int __user *nodes,
 				      int __user *status,
@@ -674,12 +674,12 @@ extern void __user *compat_alloc_user_space(unsigned long len);
 
 asmlinkage ssize_t compat_sys_process_vm_readv(compat_pid_t pid,
 		const struct compat_iovec __user *lvec,
-		unsigned long liovcnt, const struct compat_iovec __user *rvec,
-		unsigned long riovcnt, unsigned long flags);
+		compat_ulong_t liovcnt, const struct compat_iovec __user *rvec,
+		compat_ulong_t riovcnt, compat_ulong_t flags);
 asmlinkage ssize_t compat_sys_process_vm_writev(compat_pid_t pid,
 		const struct compat_iovec __user *lvec,
-		unsigned long liovcnt, const struct compat_iovec __user *rvec,
-		unsigned long riovcnt, unsigned long flags);
+		compat_ulong_t liovcnt, const struct compat_iovec __user *rvec,
+		compat_ulong_t riovcnt, compat_ulong_t flags);
 
 asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
 				    compat_off_t __user *offset, compat_size_t count);
diff --git a/kernel/compat.c b/kernel/compat.c
index 2622011a44c9..488ff8c4cf48 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -1065,11 +1065,11 @@ COMPAT_SYSCALL_DEFINE1(adjtimex, struct compat_timex __user *, utp)
 }
 
 #ifdef CONFIG_NUMA
-asmlinkage long compat_sys_move_pages(pid_t pid, unsigned long nr_pages,
-		compat_uptr_t __user *pages32,
-		const int __user *nodes,
-		int __user *status,
-		int flags)
+COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
+		       compat_uptr_t __user *, pages32,
+		       const int __user *, nodes,
+		       int __user *, status,
+		       int, flags)
 {
 	const void __user * __user *pages;
 	int i;
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index fd26d0433509..3c5cf68566ec 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -456,25 +456,23 @@ free_iovecs:
 	return rc;
 }
 
-asmlinkage ssize_t
-compat_sys_process_vm_readv(compat_pid_t pid,
-			    const struct compat_iovec __user *lvec,
-			    unsigned long liovcnt,
-			    const struct compat_iovec __user *rvec,
-			    unsigned long riovcnt,
-			    unsigned long flags)
+COMPAT_SYSCALL_DEFINE6(process_vm_readv, compat_pid_t, pid,
+		       const struct compat_iovec __user *, lvec,
+		       compat_ulong_t, liovcnt,
+		       const struct compat_iovec __user *, rvec,
+		       compat_ulong_t, riovcnt,
+		       compat_ulong_t, flags)
 {
 	return compat_process_vm_rw(pid, lvec, liovcnt, rvec,
 				    riovcnt, flags, 0);
 }
 
-asmlinkage ssize_t
-compat_sys_process_vm_writev(compat_pid_t pid,
-			     const struct compat_iovec __user *lvec,
-			     unsigned long liovcnt,
-			     const struct compat_iovec __user *rvec,
-			     unsigned long riovcnt,
-			     unsigned long flags)
+COMPAT_SYSCALL_DEFINE6(process_vm_writev, compat_pid_t, pid,
+		       const struct compat_iovec __user *, lvec,
+		       compat_ulong_t, liovcnt,
+		       const struct compat_iovec __user *, rvec,
+		       compat_ulong_t, riovcnt,
+		       compat_ulong_t, flags)
 {
 	return compat_process_vm_rw(pid, lvec, liovcnt, rvec,
 				    riovcnt, flags, 1);
-- 
1.8.4.5
