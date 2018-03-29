From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 080/109] fs: add do_faccessat() helper and ksys_access() wrapper; remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:23:57 +0200
Message-ID: <20180329112426.23043-81-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_faccessat() helper allows us to get rid of
fs-internal calls to the sys_faccessat() syscall.

Introducing the ksys_access() wrapper allows us to avoid the in-kernel
calls to the sys_access() syscall. The ksys_ prefix denotes that this
function is meant as a drop-in replacement for the syscall. In
particular, it uses the same calling convention as sys_access().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            | 1 +
 fs/open.c                | 9 +++++++--
 include/linux/syscalls.h | 7 +++++++
 init/main.c              | 3 ++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 2474bf460f96..26f4f05b52ef 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -119,6 +119,7 @@ extern struct file *do_filp_open(int dfd, struct filename *pathname,
 extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 		const char *, const struct open_flags *);
 
+long do_faccessat(int dfd, const char __user *filename, int mode);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 
 extern int open_check_o_direct(struct file *f);
diff --git a/fs/open.c b/fs/open.c
index 6037f2bf418c..0fc8188be31a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -350,7 +350,7 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
  */
-SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
+long do_faccessat(int dfd, const char __user *filename, int mode)
 {
 	const struct cred *old_cred;
 	struct cred *override_cred;
@@ -426,9 +426,14 @@ SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 	return res;
 }
 
+SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
+{
+	return do_faccessat(dfd, filename, mode);
+}
+
 SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 {
-	return sys_faccessat(AT_FDCWD, filename, mode);
+	return do_faccessat(AT_FDCWD, filename, mode);
 }
 
 int ksys_chdir(const char __user *filename)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index dd6c306f4f00..33f06de090ea 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1014,4 +1014,11 @@ static inline int ksys_chmod(const char __user *filename, umode_t mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
+extern long do_faccessat(int dfd, const char __user *filename, int mode);
+
+static inline long ksys_access(const char __user *filename, int mode)
+{
+	return do_faccessat(AT_FDCWD, filename, mode);
+}
+
 #endif
diff --git a/init/main.c b/init/main.c
index b8649d1466e1..d0ded4322c6b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1087,7 +1087,8 @@ static noinline void __init kernel_init_freeable(void)
 	if (!ramdisk_execute_command)
 		ramdisk_execute_command = "/init";
 
-	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
+	if (ksys_access((const char __user *)
+			ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.16.3
