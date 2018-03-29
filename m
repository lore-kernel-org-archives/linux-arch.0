From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 090/109] kernel: add ksys_unshare() helper; remove in-kernel calls to sys_unshare()
Date: Thu, 29 Mar 2018 13:24:07 +0200
Message-ID: <20180329112426.23043-91-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_unshare() syscall. The ksys_ prefix denotes that this function is meant
as a drop-in replacement for the syscall. In particular, it uses the same
calling convention as sys_unshare().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  | 2 +-
 include/linux/syscalls.h | 1 +
 init/do_mounts_initrd.c  | 2 +-
 kernel/fork.c            | 7 ++++++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 3f7ee954fd2c..f7768077e817 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -380,7 +380,7 @@ static int devtmpfsd(void *p)
 {
 	char options[] = "mode=0755";
 	int *err = p;
-	*err = sys_unshare(CLONE_NEWNS);
+	*err = ksys_unshare(CLONE_NEWNS);
 	if (*err)
 		goto out;
 	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0a9942b3e718..e724dda509e0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -961,6 +961,7 @@ int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
+int ksys_unshare(unsigned long unshare_flags);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 03ec0c1b7553..d1d3e53bdeef 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -36,7 +36,7 @@ __setup("noinitrd", no_initrd);
 
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
-	sys_unshare(CLONE_FS | CLONE_FILES);
+	ksys_unshare(CLONE_FS | CLONE_FILES);
 	/* stdin/stdout/stderr for /linuxrc */
 	ksys_open("/dev/console", O_RDWR, 0);
 	ksys_dup(0);
diff --git a/kernel/fork.c b/kernel/fork.c
index b1e031aac9db..f71b67dc156d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2354,7 +2354,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
  * constructed. Here we are modifying the current, active,
  * task_struct.
  */
-SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
+int ksys_unshare(unsigned long unshare_flags)
 {
 	struct fs_struct *fs, *new_fs = NULL;
 	struct files_struct *fd, *new_fd = NULL;
@@ -2470,6 +2470,11 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
 	return err;
 }
 
+SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
+{
+	return ksys_unshare(unshare_flags);
+}
+
 /*
  *	Helper to unshare the files of the current task.
  *	We don't want to expose copy_files internals to
-- 
2.16.3
