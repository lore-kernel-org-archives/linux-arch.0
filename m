From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 072/109] fs: add ksys_unlink() wrapper; remove in-kernel calls to sys_unlink()
Date: Thu, 29 Mar 2018 13:23:49 +0200
Message-ID: <20180329112426.23043-73-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using this wrapper allows us to avoid the in-kernel calls to the
sys_unlink() syscall. The ksys_ prefix denotes that this function is meant
s a drop-in replacement for the syscall. In particular, it uses the same
calling convention as sys_unlink().

In the near future, all callers of ksys_unlink() should be converted to
call do_unlinkat() directly or, at least, to operate on regular kernel
pointers.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 11 +++++++++++
 init/do_mounts.h         |  2 +-
 init/do_mounts_initrd.c  |  4 ++--
 init/do_mounts_rd.c      |  2 +-
 init/initramfs.c         |  4 ++--
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 090645b48447..7cbfb41e666b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -954,4 +954,15 @@ int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
 
+/*
+ * The following kernel syscall equivalents are just wrappers to fs-internal
+ * functions. Therefore, provide stubs to be inlined at the callsites.
+ */
+extern long do_unlinkat(int dfd, struct filename *name);
+
+static inline long ksys_unlink(const char __user *pathname)
+{
+	return do_unlinkat(AT_FDCWD, getname(pathname));
+}
+
 #endif
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 5b05c8f93f47..401f90ee1eeb 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,7 +16,7 @@ extern int root_mountflags;
 
 static inline int create_dev(char *name, dev_t dev)
 {
-	sys_unlink(name);
+	ksys_unlink(name);
 	return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 83f396d30b9a..e9e9e1c67d31 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -128,11 +128,11 @@ bool __init initrd_load(void)
 		 * mounted in the normal path.
 		 */
 		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			sys_unlink("/initrd.image");
+			ksys_unlink("/initrd.image");
 			handle_initrd();
 			return true;
 		}
 	}
-	sys_unlink("/initrd.image");
+	ksys_unlink("/initrd.image");
 	return false;
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 2d365c398ccc..5b69056f610a 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -288,7 +288,7 @@ int __init rd_load_image(char *from)
 	sys_close(out_fd);
 out:
 	kfree(buf);
-	sys_unlink("/dev/ram");
+	ksys_unlink("/dev/ram");
 	return res;
 }
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 6f972df15bf2..08eb551168a8 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -319,7 +319,7 @@ static void __init clean_path(char *path, umode_t fmode)
 		if (S_ISDIR(st.mode))
 			sys_rmdir(path);
 		else
-			sys_unlink(path);
+			ksys_unlink(path);
 	}
 }
 
@@ -591,7 +591,7 @@ static void __init clean_rootfs(void)
 				if (S_ISDIR(st.mode))
 					sys_rmdir(dirp->d_name);
 				else
-					sys_unlink(dirp->d_name);
+					ksys_unlink(dirp->d_name);
 			}
 
 			num -= dirp->d_reclen;
-- 
2.16.3
