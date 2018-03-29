From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 078/109] fs: add do_linkat() helper and ksys_link() wrapper; remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:23:55 +0200
Message-ID: <20180329112426.23043-79-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_linkat() helper allows us to get rid of
fs-internal calls to the sys_linkat() syscall.

Introducing the ksys_link() wrapper allows us to avoid the in-kernel
calls to sys_link() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it uses
the same calling convention as sys_link().

In the near future, the only fs-external user of ksys_link() should be
converted to use vfs_link() instead.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            |  2 ++
 fs/namei.c               | 12 +++++++++---
 include/linux/syscalls.h |  9 +++++++++
 init/initramfs.c         |  2 +-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 4f0b67054c54..91e6fc93fcb5 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -62,6 +62,8 @@ long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
 long do_symlinkat(const char __user *oldname, int newdfd,
 		  const char __user *newname);
+int do_linkat(int olddfd, const char __user *oldname, int newdfd,
+	      const char __user *newname, int flags);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index 8459a18cdd18..10148235829f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4250,8 +4250,8 @@ EXPORT_SYMBOL(vfs_link);
  * with linux 2.0, and to avoid hard-linking to directories
  * and other special files.  --ADM
  */
-SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
-		int, newdfd, const char __user *, newname, int, flags)
+int do_linkat(int olddfd, const char __user *oldname, int newdfd,
+	      const char __user *newname, int flags)
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
@@ -4315,9 +4315,15 @@ SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
 	return error;
 }
 
+SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
+		int, newdfd, const char __user *, newname, int, flags)
+{
+	return do_linkat(olddfd, oldname, newdfd, newname, flags);
+}
+
 SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname)
 {
-	return sys_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
+	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
 /**
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0b4fd684f0f1..827ed917630c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -997,4 +997,13 @@ static inline long ksys_mknod(const char __user *filename, umode_t mode,
 	return do_mknodat(AT_FDCWD, filename, mode, dev);
 }
 
+extern int do_linkat(int olddfd, const char __user *oldname, int newdfd,
+		     const char __user *newname, int flags);
+
+static inline long ksys_link(const char __user *oldname,
+			     const char __user *newname)
+{
+	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 2972ed0ab399..5855ab632b4e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -306,7 +306,7 @@ static int __init maybe_link(void)
 	if (nlink >= 2) {
 		char *old = find_link(major, minor, ino, mode, collected);
 		if (old)
-			return (sys_link(old, collected) < 0) ? -1 : 1;
+			return (ksys_link(old, collected) < 0) ? -1 : 1;
 	}
 	return 0;
 }
-- 
2.16.3
