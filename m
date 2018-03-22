From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 21/45] kernel: add ksys_setsid() helper; remove in-kernel call to sys_setsid()
Date: Thu, 22 Mar 2018 10:00:35 +0100
Message-ID: <20180322090059.19361-22-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the
sys_setsid() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_setsid().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 1 +
 init/do_mounts_initrd.c  | 2 +-
 kernel/sys.c             | 7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a3f42f5f3b08..c509459ce9d5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -981,6 +981,7 @@ ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		      size_t count, loff_t pos);
 int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len);
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
index ebb138b841c8..8eda25dcbbd4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1108,7 +1108,7 @@ static void set_special_pids(struct pid *pid)
 		change_pid(curr, PIDTYPE_PGID, pid);
 }
 
-SYSCALL_DEFINE0(setsid)
+int ksys_setsid(void)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1141,6 +1141,11 @@ SYSCALL_DEFINE0(setsid)
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
2.16.2
