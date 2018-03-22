From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 14/45] fs: add do_compat_signalfd4() helper; remove in-kernel call to comapt syscall
Date: Thu, 22 Mar 2018 10:00:28 +0100
Message-ID: <20180322090059.19361-15-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_compat_signalfd4() helper allows us to get rid of
the fs-internal call to the compat_sys_signalfd4() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/signalfd.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 501c41f3351f..d2187a813376 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -323,10 +323,9 @@ SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *, user_mask,
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
-		     const compat_sigset_t __user *,sigmask,
-		     compat_size_t, sigsetsize,
-		     int, flags)
+static long do_compat_signalfd4(int ufd,
+			const compat_sigset_t __user *sigmask,
+			compat_size_t sigsetsize, int flags)
 {
 	sigset_t tmp;
 	sigset_t __user *ksigmask;
@@ -342,10 +341,18 @@ COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
 	return do_signalfd4(ufd, ksigmask, sizeof(sigset_t), flags);
 }
 
+COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
+		     const compat_sigset_t __user *, sigmask,
+		     compat_size_t, sigsetsize,
+		     int, flags)
+{
+	return do_compat_signalfd4(ufd, sigmask, sigsetsize, flags);
+}
+
 COMPAT_SYSCALL_DEFINE3(signalfd, int, ufd,
 		     const compat_sigset_t __user *,sigmask,
 		     compat_size_t, sigsetsize)
 {
-	return compat_sys_signalfd4(ufd, sigmask, sigsetsize, 0);
+	return do_compat_signalfd4(ufd, sigmask, sigsetsize, 0);
 }
 #endif
-- 
2.16.2
