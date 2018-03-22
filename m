From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 15/45] fs: add do_compat_futimesat() helper; remove in-kernel call to comapt syscall
Date: Thu, 22 Mar 2018 10:00:29 +0100
Message-ID: <20180322090059.19361-16-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_compat_futimesat() helper allows us to get rid of
the fs-internal call to the compat_sys_futimesat() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/utimes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 5be035ed26c0..69d4b6ba1bfb 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -260,7 +260,8 @@ COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filena
 	return do_utimes(dfd, filename, t ? tv : NULL, flags);
 }
 
-COMPAT_SYSCALL_DEFINE3(futimesat, unsigned int, dfd, const char __user *, filename, struct compat_timeval __user *, t)
+static long do_compat_futimesat(unsigned int dfd, const char __user *filename,
+				struct compat_timeval __user *t)
 {
 	struct timespec64 tv[2];
 
@@ -279,8 +280,15 @@ COMPAT_SYSCALL_DEFINE3(futimesat, unsigned int, dfd, const char __user *, filena
 	return do_utimes(dfd, filename, t ? tv : NULL, 0);
 }
 
+COMPAT_SYSCALL_DEFINE3(futimesat, unsigned int, dfd,
+		       const char __user *, filename,
+		       struct compat_timeval __user *, t)
+{
+	return do_compat_futimesat(dfd, filename, t);
+}
+
 COMPAT_SYSCALL_DEFINE2(utimes, const char __user *, filename, struct compat_timeval __user *, t)
 {
-	return compat_sys_futimesat(AT_FDCWD, filename, t);
+	return do_compat_futimesat(AT_FDCWD, filename, t);
 }
 #endif
-- 
2.16.2
