From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: sys_fanotify_mark (again)
Date: Sun, 22 Nov 2009 10:05:19 +0100
Message-ID: <20091122090519.GA3974@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.17.162]:55048 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZKVJFO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Nov 2009 04:05:14 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id nAM95Kbv017725
	for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2009 09:05:20 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id nAM95Kto311518
	for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2009 10:05:20 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id nAM95JcG011183
	for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2009 10:05:20 +0100
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Li Zefan <lizf@cn.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>

Hi Eric,

as I can see you changed the syscall interface for sys_fanotify_mark to:

asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
                                  __u64 mask, int dfd,
                                  const char  __user * pathname)

Please note that you need the patch below in addition, otherwise the
syscall wrapper stuff won't work on those 32 bit architectures which enable
the wrappers.

When enabled the syscall wrapper defines always take long parameters and then
cast them to whatever is needed. This approach doesn't work for the 32 bit
case where the original syscall takes a long long parameter, since we would
lose the upper 32 bits.
So syscalls with 64 bit arguments are special cases wrt to syscall wrappers
and enp up in the ugliness below (see also sys_fallocate). In addition these
special cased syscall wrappers have the drawback that ftrace syscall tracing
doesn't work on them, since they don't get defined by using the usual macros.

Considering that fanotify_mark doesn't look performance critical to the point
that one would start count instructions I would propose the following
interface:

asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
                                  int dfd, const char  __user * pathname,
				  u32 mask_high, u32 mask_low)

As already pointed out by Ralf this also has the advantage that no special
compat syscall handling is needed which otherwise would have to merge the
upper and lower 32 bits of the mask parameter in case of 32 bit userspace
and 64 bit kernel.

Alternatively you could also fix the syscall wrapper stuff to automatically
do the right thing for long long parameters. But I wouldn't how... except
with hpa's proposed automatic syscall wrapper creation engine :)

---
 fs/notify/fanotify/fanotify_user.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

Index: linux-next/fs/notify/fanotify/fanotify_user.c
===================================================================
--- linux-next.orig/fs/notify/fanotify/fanotify_user.c
+++ linux-next/fs/notify/fanotify/fanotify_user.c
@@ -473,8 +473,9 @@ out_put_group:
 	return fd;
 }
 
-SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
-		__u64, mask, int, dfd, const char  __user *, pathname)
+SYSCALL_DEFINE(fanotify_mark)(int fanotify_fd, unsigned int flags,
+			      __u64 mask, int dfd,
+			      const char  __user * pathname)
 {
 	struct inode *inode;
 	struct fsnotify_group *group;
@@ -518,6 +519,17 @@ fput_and_out:
 	return ret;
 }
 
+#ifdef CONFIG_HAVE_SYSCALL_WRAPPERS
+asmlinkage long SyS_fanotify_mark(long fanotify_fd, long flags, __u64 mask,
+				  long dfd, long pathname)
+{
+	return SYSC_fanotify_mark((int) fanotify_fd, (unsigned int) flags,
+				  mask, (int) dfd,
+				  (const char  __user *) pathname);
+}
+SYSCALL_ALIAS(sys_fanotify_mark, SyS_fanotify_mark);
+#endif
+
 /*
  * fanotify_user_setup - Our initialization function.  Note that we cannnot return
  * error because we have compiled-in VFS hooks.  So an (unlikely) failure here
