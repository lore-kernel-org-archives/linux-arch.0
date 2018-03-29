From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 076/109] fs: add do_symlinkat() helper and ksys_symlink() wrapper; remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:23:53 +0200
Message-ID: <20180329112426.23043-77-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_symlinkat() helper allows us to get rid of
fs-internal calls to the sys_symlinkat() syscall.

Introducing the ksys_symlink() wrapper allows us to avoid the in-kernel
calls to the sys_symlink() syscall. The ksys_ prefix denotes that this
function is meant as a drop-in replacement for the syscall. In particular,
it uses the same calling convention as sys_symlink().

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
index 53846bd4d9d7..a3f04ca2a08b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,6 +58,8 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
+long do_symlinkat(const char __user *oldname, int newdfd,
+		  const char __user *newname);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index dcf506227509..e15da92209d5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4113,8 +4113,8 @@ int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 }
 EXPORT_SYMBOL(vfs_symlink);
 
-SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
-		int, newdfd, const char __user *, newname)
+long do_symlinkat(const char __user *oldname, int newdfd,
+		  const char __user *newname)
 {
 	int error;
 	struct filename *from;
@@ -4144,9 +4144,15 @@ SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
 	return error;
 }
 
+SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
+		int, newdfd, const char __user *, newname)
+{
+	return do_symlinkat(oldname, newdfd, newname);
+}
+
 SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newname)
 {
-	return sys_symlinkat(oldname, AT_FDCWD, newname);
+	return do_symlinkat(oldname, AT_FDCWD, newname);
 }
 
 /**
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c982cb5f4e50..39c5cef86a10 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -979,4 +979,13 @@ static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
 	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
+extern long do_symlinkat(const char __user *oldname, int newdfd,
+			 const char __user *newname);
+
+static inline long ksys_symlink(const char __user *oldname,
+				const char __user *newname)
+{
+	return do_symlinkat(oldname, AT_FDCWD, newname);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index ca538a5f9fa9..cd9571a113b6 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -392,7 +392,7 @@ static int __init do_symlink(void)
 {
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
-	sys_symlink(collected + N_ALIGN(name_len), collected);
+	ksys_symlink(collected + N_ALIGN(name_len), collected);
 	sys_lchown(collected, uid, gid);
 	do_utime(collected, mtime);
 	state = SkipIt;
-- 
2.16.3
