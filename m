Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:37680 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbeCVJBt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:01:49 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 07/45] fs: add do_vmsplice() helper; remove in-kernel call to syscall
Date: Thu, 22 Mar 2018 10:00:21 +0100
Message-ID: <20180322090059.19361-8-linux@dominikbrodowski.net>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180322090021.tjhHKy-3lNb_IdliMpuGxhbYKGLelq-hX-0uoH_1yf8@z>

Using the fs-internal do_vmsplice() helper allows us to get rid of the
fs-internal call to the sys_vmsplice() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/splice.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 39e2dc01ac12..005d09cf3fa8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1331,8 +1331,8 @@ static long vmsplice_to_pipe(struct file *file, const struct iovec __user *uiov,
  * Currently we punt and implement it as a normal copy, see pipe_to_user().
  *
  */
-SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, iov,
-		unsigned long, nr_segs, unsigned int, flags)
+static long do_vmsplice(int fd, const struct iovec __user *iov,
+			unsigned long nr_segs, unsigned int flags)
 {
 	struct fd f;
 	long error;
@@ -1358,6 +1358,12 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, iov,
 	return error;
 }
 
+SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, iov,
+		unsigned long, nr_segs, unsigned int, flags)
+{
+	return do_vmsplice(fd, iov, nr_segs, flags);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, iov32,
 		    unsigned int, nr_segs, unsigned int, flags)
@@ -1375,7 +1381,7 @@ COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, io
 		    put_user(v.iov_len, &iov[i].iov_len))
 			return -EFAULT;
 	}
-	return sys_vmsplice(fd, iov, nr_segs, flags);
+	return do_vmsplice(fd, iov, nr_segs, flags);
 }
 #endif
 
-- 
2.16.2
