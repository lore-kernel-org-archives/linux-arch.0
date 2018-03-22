From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 12/45] fs: add do_compat_fcntl64() helper; remove in-kernel call to comapt syscall
Date: Thu, 22 Mar 2018 10:00:26 +0100
Message-ID: <20180322090059.19361-13-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_compat_fcntl64() helper allows us to get rid of
the fs-internal call to the compat_sys_fcntl64() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/fcntl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 1e97f1fda90c..d737ff082472 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -607,8 +607,8 @@ static int fixup_compat_flock(struct flock *flock)
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
-		       compat_ulong_t, arg)
+static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
+			     compat_ulong_t arg)
 {
 	struct fd f = fdget_raw(fd);
 	struct flock flock;
@@ -672,6 +672,12 @@ COMPAT_SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 	return err;
 }
 
+COMPAT_SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
+		       compat_ulong_t, arg)
+{
+	return do_compat_fcntl64(fd, cmd, arg);
+}
+
 COMPAT_SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd,
 		       compat_ulong_t, arg)
 {
@@ -684,7 +690,7 @@ COMPAT_SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd,
 	case F_OFD_SETLKW:
 		return -EINVAL;
 	}
-	return compat_sys_fcntl64(fd, cmd, arg);
+	return do_compat_fcntl64(fd, cmd, arg);
 }
 #endif
 
-- 
2.16.2
