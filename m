From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 05/45] fs: add ksys_sync() helper; remove in-kernel calls to sys_sync()
Date: Thu, 22 Mar 2018 10:00:19 +0100
Message-ID: <20180322090059.19361-6-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_sync() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_sync().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/sparc/kernel/setup_32.c | 2 +-
 drivers/tty/sysrq.c          | 2 +-
 fs/sync.c                    | 7 ++++++-
 include/linux/syscalls.h     | 1 +
 kernel/power/hibernate.c     | 2 +-
 kernel/power/suspend.c       | 2 +-
 kernel/power/user.c          | 2 +-
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 2e3a3e203061..13664c377196 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -86,7 +86,7 @@ static void prom_sync_me(void)
 	show_free_areas(0, NULL);
 	if (!is_idle_task(current)) {
 		local_irq_enable();
-		sys_sync();
+		ksys_sync();
 		local_irq_disable();
 	}
 	prom_printf("Returning to prom\n");
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b674793be478..6364890575ec 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -660,7 +660,7 @@ static void sysrq_do_reset(struct timer_list *t)
 
 	state->reset_requested = true;
 
-	sys_sync();
+	ksys_sync();
 	kernel_restart(NULL);
 }
 
diff --git a/fs/sync.c b/fs/sync.c
index ff947c30a6c0..9908a114d506 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -105,7 +105,7 @@ static void fdatawait_one_bdev(struct block_device *bdev, void *arg)
  * just write metadata (such as inodes or bitmaps) to block device page cache
  * and do not sync it on their own in ->sync_fs().
  */
-SYSCALL_DEFINE0(sync)
+void ksys_sync(void)
 {
 	int nowait = 0, wait = 1;
 
@@ -117,6 +117,11 @@ SYSCALL_DEFINE0(sync)
 	iterate_bdevs(fdatawait_one_bdev, NULL);
 	if (unlikely(laptop_mode))
 		laptop_sync_completion();
+}
+
+SYSCALL_DEFINE0(sync)
+{
+	ksys_sync();
 	return 0;
 }
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e3a52c0bbf52..1970c6817289 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -977,6 +977,7 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
+void ksys_sync(void);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a5c36e9c56a6..4710f1b142fc 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -701,7 +701,7 @@ int hibernate(void)
 	}
 
 	pr_info("Syncing filesystems ... \n");
-	sys_sync();
+	ksys_sync();
 	pr_info("done.\n");
 
 	error = freeze_processes();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0685c4499431..4c10be0f4843 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -560,7 +560,7 @@ static int enter_state(suspend_state_t state)
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 	pr_info("Syncing filesystems ... ");
-	sys_sync();
+	ksys_sync();
 	pr_cont("done.\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 22df9f7ff672..75c959de4b29 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -224,7 +224,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 
 		printk("Syncing filesystems ... ");
-		sys_sync();
+		ksys_sync();
 		printk("done.\n");
 
 		error = freeze_processes();
-- 
2.16.2
