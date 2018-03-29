From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 091/109] kernel: add ksys_setsid() helper; remove in-kernel call to sys_setsid()
Date: Thu, 29 Mar 2018 13:24:08 +0200
Message-ID: <20180329112426.23043-92-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the
sys_setsid() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_setsid().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 1 +
 init/do_mounts_initrd.c  | 2 +-
 kernel/sys.c             | 7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e724dda509e0..4dd685ee425d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -962,6 +962,7 @@ off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
+int ksys_setsid(void);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d1d3e53bdeef..5a91aefa7305 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -45,7 +45,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	ksys_chdir("/root");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
-	sys_setsid();
+	ksys_setsid();
 	return 0;
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 550f47788ae4..ad692183dfe9 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1150,7 +1150,7 @@ static void set_special_pids(struct pid *pid)
 		change_pid(curr, PIDTYPE_PGID, pid);
 }
 
-SYSCALL_DEFINE0(setsid)
+int ksys_setsid(void)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1183,6 +1183,11 @@ SYSCALL_DEFINE0(setsid)
 	return err;
 }
 
+SYSCALL_DEFINE0(setsid)
+{
+	return ksys_setsid();
+}
+
 DECLARE_RWSEM(uts_sem);
 
 #ifdef COMPAT_UTS_MACHINE
-- 
2.16.3
