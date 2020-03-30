From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 24/25] um lkl: add UML block device driver (ubd) for lkl
Date: Mon, 30 Mar 2020 23:45:56 +0900
Message-ID: <5f1d48e40c4daf4ef3ddca3ca3207f11ef29739f.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3Oto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:49:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so8668106pfb.11
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:49:43 -0700 (PDT)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>

This commit adds a support to utilize exising UML drivers of block
devices for LKL.  The goal is similar to networking drivers, add minimum
amount of code and use drivers code as-is.

This commit also adds a test code with several filesystems (ext4, vfat,
btrfs at the moment) to exercise the basic operations of disk.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/ubd_kern.c              |  6 +++++-
 arch/um/lkl/Kconfig                     |  3 +++
 arch/um/lkl/include/uapi/asm/syscalls.h |  1 +
 arch/um/lkl/kernel/setup.c              |  5 +++++
 tools/lkl/include/lkl.h                 | 15 +++++++++++++++
 tools/lkl/lib/um/Build                  |  1 +
 tools/lkl/lib/um/um_block.c             | 17 +++++++++++++++++
 tools/lkl/lib/um/um_glue.c              | 24 +++++++++++++++++++++++-
 tools/lkl/tests/disk.c                  | 14 ++++++++++++++
 9 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 tools/lkl/lib/um/um_block.c

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index eae8c83364f7..248bac8e36b8 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -545,7 +545,7 @@ static irqreturn_t ubd_intr(int irq, void *dev)
 /* Only changed by ubd_init, which is an initcall. */
 static int io_pid = -1;
 
-static void kill_io_thread(void)
+void kill_io_thread(void)
 {
 	if(io_pid != -1)
 		os_kill_process(io_pid, 1);
@@ -819,6 +819,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	}
 	ubd_dev->fd = fd;
 
+#ifdef CONFIG_UMMODE_KERN
 	if(ubd_dev->cow.file != NULL){
 		blk_queue_max_hw_sectors(ubd_dev->queue, 8 * sizeof(long));
 
@@ -843,6 +844,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+#endif	/* CONFIG_UMMODE_KERN */
 	if (ubd_dev->no_trim == 0) {
 		ubd_dev->queue->limits.discard_granularity = SECTOR_SIZE;
 		ubd_dev->queue->limits.discard_alignment = SECTOR_SIZE;
@@ -852,9 +854,11 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	}
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
+#ifdef CONFIG_UMMODE_KERN
  error:
 	os_close_file(ubd_dev->fd);
 	return err;
+#endif
 }
 
 static void ubd_device_release(struct device *dev)
diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
index 2b6b4063045c..8e4e0a465fc8 100644
--- a/arch/um/lkl/Kconfig
+++ b/arch/um/lkl/Kconfig
@@ -48,6 +48,9 @@ config OUTPUT_FORMAT
 config ARCH_DMA_ADDR_T_64BIT
        def_bool 64BIT
 
+config BLK_DEV_UBD
+       def_bool y if "$(OUTPUT_FORMAT)" = "elf32-i386" || "$(OUTPUT_FORMAT)" = "elf64-x86-64"
+
 config X86_64
        def_bool y if "$(OUTPUT_FORMAT)" = "elf64-x86-64"
 
diff --git a/arch/um/lkl/include/uapi/asm/syscalls.h b/arch/um/lkl/include/uapi/asm/syscalls.h
index a81534ffccb7..1384c34137d6 100644
--- a/arch/um/lkl/include/uapi/asm/syscalls.h
+++ b/arch/um/lkl/include/uapi/asm/syscalls.h
@@ -164,6 +164,7 @@ struct sockaddr {
 #include <linux/virtio_ring.h>
 #include <linux/pkt_sched.h>
 #include <linux/io_uring.h>
+#include <linux/major.h>
 
 struct user_msghdr {
 	void		__user *msg_name;
diff --git a/arch/um/lkl/kernel/setup.c b/arch/um/lkl/kernel/setup.c
index 39b7b7c79581..daf55c216db9 100644
--- a/arch/um/lkl/kernel/setup.c
+++ b/arch/um/lkl/kernel/setup.c
@@ -126,6 +126,11 @@ long lkl_sys_halt(void)
 		LINUX_REBOOT_CMD_RESTART,
 	};
 
+#ifdef CONFIG_BLK_DEV_UBD
+void kill_io_thread(void);
+	kill_io_thread();
+#endif
+
 	err = lkl_syscall(__NR_reboot, params);
 	if (err < 0)
 		return err;
diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 952d11e30868..7d164e4dcad1 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -355,6 +355,10 @@ void lkl_perror(char *msg, int err);
  */
 struct lkl_dev_blk_ops;
 
+enum {
+	BLK_BACKEND_UM,
+};
+
 /**
  * lkl_disk - host disk handle
  *
@@ -368,6 +372,7 @@ struct lkl_disk {
 		int fd;
 		void *handle;
 	};
+	int backend;
 	struct lkl_dev_blk_ops *ops;
 };
 
@@ -403,6 +408,16 @@ int lkl_disk_remove(struct lkl_disk disk);
  */
 int lkl_encode_dev_from_sysfs(const char *sysfs_path, uint32_t *pdevid);
 
+
+#ifdef LKL_HOST_CONFIG_UML_DEV
+int lkl_disk_um_add(struct lkl_disk *disk, const char *blkparams);
+#else
+static inline int lkl_disk_um_add(struct lkl_disk *disk, const char *blkparams)
+{
+	return -LKL_ENOSYS;
+}
+#endif
+
 /**
  * lkl_mount_dev - mount a disk
  *
diff --git a/tools/lkl/lib/um/Build b/tools/lkl/lib/um/Build
index 09a60975ecd6..52573c05a797 100644
--- a/tools/lkl/lib/um/Build
+++ b/tools/lkl/lib/um/Build
@@ -1,2 +1,3 @@
 liblkl-y += um_glue.o
 liblkl-y += um_net.o
+liblkl-y += um_block.o
diff --git a/tools/lkl/lib/um/um_block.c b/tools/lkl/lib/um/um_block.c
new file mode 100644
index 000000000000..70dc624ec43c
--- /dev/null
+++ b/tools/lkl/lib/um/um_block.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <lkl_host.h>
+
+
+static int registered_blk_dev_idx;
+
+int lkl_disk_um_add(struct lkl_disk *disk, const char *blkparams)
+{
+	/* concat strings */
+	snprintf(lkl_um_devs + strlen(lkl_um_devs), sizeof(lkl_um_devs),
+		 " ubd%d=%s", registered_blk_dev_idx, blkparams);
+
+	return registered_blk_dev_idx++;
+}
diff --git a/tools/lkl/lib/um/um_glue.c b/tools/lkl/lib/um/um_glue.c
index f59e31a706de..fd5a338bcb9f 100644
--- a/tools/lkl/lib/um/um_glue.c
+++ b/tools/lkl/lib/um/um_glue.c
@@ -2,9 +2,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <signal.h>
 #include <unistd.h>
 #include <errno.h>
-
+#include <sys/wait.h>
 
 
 char lkl_um_devs[4096];
@@ -37,3 +38,24 @@ void *um_os_signal(int signum, void *handler)
 {
 	return signal(signum, handler);
 }
+
+/* from util.c */
+/*
+ * UML helper threads must not handle SIGWINCH/INT/TERM
+ */
+void os_fix_helper_signals(void)
+{
+	signal(SIGWINCH, SIG_IGN);
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
+}
+
+void os_kill_process(int pid, int reap_child)
+{
+	kill(pid, SIGKILL);
+	if (reap_child) {
+		while ((errno = 0, ((waitpid(pid, NULL, __WALL)) < 0))
+		       && (errno == EINTR))
+			;
+	}
+}
diff --git a/tools/lkl/tests/disk.c b/tools/lkl/tests/disk.c
index 0aa039876b54..f7801014d054 100644
--- a/tools/lkl/tests/disk.c
+++ b/tools/lkl/tests/disk.c
@@ -23,12 +23,17 @@ static struct {
 	const char *disk;
 	const char *fstype;
 	int partition;
+	int backend;
 } cla;
 
+const char *backends[] = { "um", NULL };
+
 struct cl_arg args[] = {
 	{"disk", 'd', "disk file to use", 1, CL_ARG_STR, &cla.disk},
 	{"partition", 'P', "partition to mount", 1, CL_ARG_INT, &cla.partition},
 	{"type", 't', "filesystem type", 1, CL_ARG_STR, &cla.fstype},
+	{"backend", 'b', "blockd evice backend type", 1, CL_ARG_STR_SET,
+	 &cla.backend, backends},
 	{0},
 };
 
@@ -50,6 +55,15 @@ int lkl_test_disk_add(void)
 
 	disk.ops = NULL;
 
+	disk.backend = cla.backend;
+
+	switch (disk.backend) {
+	case BLK_BACKEND_UM:
+		disk.dev = (char *)cla.disk;
+	default:
+		break;
+	}
+
 	disk_id = lkl_disk_add(&disk);
 	if (disk_id < 0)
 		goto out_close;
-- 
2.21.0 (Apple Git-122.2)
