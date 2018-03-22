Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:37166 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeCVJBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:01:38 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 17/45] fanotify: add do_fanotify_mark() helper; remove in-kernel call to syscall
Date: Thu, 22 Mar 2018 10:00:31 +0100
Message-ID: <20180322090059.19361-18-linux@dominikbrodowski.net>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Message-ID: <20180322090031.bx17W5_T00xSbXW-S80QRGvzPImbA9QhJB0FH_jI6K0@z>

Using the fs-internal do_fanotify_mark() helper allows us to get rid of
the fs-internal call to the sys_fanotify_mark() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/notify/fanotify/fanotify_user.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c07eb3d655ea..fa803a58a605 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -820,9 +820,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	return fd;
 }
 
-SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
-			      __u64, mask, int, dfd,
-			      const char  __user *, pathname)
+static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
+			    int dfd, const char  __user *pathname)
 {
 	struct inode *inode = NULL;
 	struct vfsmount *mnt = NULL;
@@ -928,13 +927,20 @@ SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 	return ret;
 }
 
+SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
+			      __u64, mask, int, dfd,
+			      const char  __user *, pathname)
+{
+	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE6(fanotify_mark,
 				int, fanotify_fd, unsigned int, flags,
 				__u32, mask0, __u32, mask1, int, dfd,
 				const char  __user *, pathname)
 {
-	return sys_fanotify_mark(fanotify_fd, flags,
+	return do_fanotify_mark(fanotify_fd, flags,
 #ifdef __BIG_ENDIAN
 				((__u64)mask0 << 32) | mask1,
 #else
-- 
2.16.2
