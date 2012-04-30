From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 19/29] powerpc: Use generic init_task
Date: Mon, 30 Apr 2012 20:16:01 -0000
Message-ID: <20120430194846.731265237@linutronix.de>
References: <20120430194725.763322463@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=powerpc-use-generic-init-task.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

Same code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig            |    1 +
 arch/powerpc/kernel/Makefile    |    2 +-
 arch/powerpc/kernel/init_task.c |   29 -----------------------------
 3 files changed, 2 insertions(+), 30 deletions(-)

Index: tip/arch/powerpc/Kconfig
===================================================================
--- tip.orig/arch/powerpc/Kconfig
+++ tip/arch/powerpc/Kconfig
@@ -145,6 +145,7 @@ config PPC
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
+	select HAVE_GENERIC_INIT_TASK
 
 config EARLY_PRINTK
 	bool
Index: tip/arch/powerpc/kernel/Makefile
===================================================================
--- tip.orig/arch/powerpc/kernel/Makefile
+++ tip/arch/powerpc/kernel/Makefile
@@ -28,7 +28,7 @@ endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   init_task.o process.o systbl.o idle.o \
+				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o dma.o \
Index: tip/arch/powerpc/kernel/init_task.c
===================================================================
--- tip.orig/arch/powerpc/kernel/init_task.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/mm.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/init_task.h>
-#include <linux/fs.h>
-#include <linux/mqueue.h>
-#include <asm/uaccess.h>
-
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-/*
- * Initial thread structure.
- *
- * We need to make sure that this is 16384-byte aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry..
- */
-union thread_union init_thread_union __init_task_data =
-	{ INIT_THREAD_INFO(init_task) };
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_task);
