From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 02/19] add generic kernel/init_task.c
Date: Thu, 11 Dec 2008 03:52:40 +0000
Message-ID: <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57637 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbYLKDxS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:18 -0500
In-Reply-To: <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, Kyle McMartin <kyle@redhat.com>

Add a generic kernel/init_task.c, since it is basically identical across
all the architectures Linux supports.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 kernel/Makefile    |    4 ++++
 kernel/init_task.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 kernel/init_task.c

diff --git a/kernel/Makefile b/kernel/Makefile
index 19fad00..b370dec 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -11,6 +11,10 @@ obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    hrtimer.o rwsem.o nsproxy.o srcu.o semaphore.o \
 	    notifier.o ksysfs.o pm_qos_params.o sched_clock.o
 
+ifneq ($(CONFIG_HAVE_ARCH_INIT_TASK),y)
+obj-y	+= init_task.o
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace debug files and internal ftrace files
 CFLAGS_REMOVE_lockdep.o = -pg
diff --git a/kernel/init_task.c b/kernel/init_task.c
new file mode 100644
index 0000000..2ebfa81
--- /dev/null
+++ b/kernel/init_task.c
@@ -0,0 +1,36 @@
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/fs.h>
+#include <linux/mqueue.h>
+
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+
+static struct fs_struct init_fs = INIT_FS;
+static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
+static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
+struct mm_struct init_mm = INIT_MM(init_mm);
+EXPORT_UNUSED_SYMBOL(init_mm); /* will be removed in 2.6.26 */
+
+/*
+ * Initial thread structure.
+ *
+ * We need to make sure that this is THREAD_SIZE aligned due to the
+ * way process stacks are handled. This is done by having a special
+ * "init_task" linker map entry..
+ */
+union thread_union init_thread_union
+	__attribute__((__section__(".data.init_task"))) =
+		{ INIT_THREAD_INFO(init_task) };
+
+/*
+ * Initial task structure.
+ *
+ * All other task structs will be allocated on slabs in fork.c
+ */
+struct task_struct init_task = INIT_TASK(init_task);
+EXPORT_SYMBOL(init_task);
+
-- 
1.6.0.4
