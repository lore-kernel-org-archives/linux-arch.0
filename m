From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 063/109] fanotify: add do_fanotify_mark() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:23:40 +0200
Message-ID: <20180329112426.23043-64-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_fanotify_mark() helper allows us to get rid of
the fs-internal call to the sys_fanotify_mark() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Acked-by: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
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
2.16.3
