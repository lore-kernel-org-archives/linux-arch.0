From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/29] h8300: Use generic init_task
Date: Mon, 30 Apr 2012 20:15:56 -0000
Message-ID: <20120430194846.102079052@linutronix.de>
References: <20120430194725.763322463@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=h8300-use-generic-idle-task.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Same code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/Kconfig            |    1 +
 arch/h8300/kernel/Makefile    |    2 +-
 arch/h8300/kernel/init_task.c |   36 ------------------------------------
 3 files changed, 2 insertions(+), 37 deletions(-)

Index: tip/arch/h8300/Kconfig
===================================================================
--- tip.orig/arch/h8300/Kconfig
+++ tip/arch/h8300/Kconfig
@@ -5,6 +5,7 @@ config H8300
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
+	select HAVE_GENERIC_INIT_TASK
 
 config SYMBOL_PREFIX
 	string
Index: tip/arch/h8300/kernel/Makefile
===================================================================
--- tip.orig/arch/h8300/kernel/Makefile
+++ tip/arch/h8300/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y := vmlinux.lds
 
 obj-y := process.o traps.o ptrace.o irq.o \
 	 sys_h8300.o time.o signal.o \
-         setup.o gpio.o init_task.o syscalls.o \
+         setup.o gpio.o syscalls.o \
 	 entry.o timer/
 
 obj-$(CONFIG_MODULES) += module.o h8300_ksyms.o 
Index: tip/arch/h8300/kernel/init_task.c
===================================================================
--- tip.orig/arch/h8300/kernel/init_task.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- *  linux/arch/h8300/kernel/init_task.c
- */
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/init_task.h>
-#include <linux/fs.h>
-#include <linux/mqueue.h>
-
-#include <asm/uaccess.h>
-#include <asm/pgtable.h>
-
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-__asm__(".align 4");
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_task);
-
-/*
- * Initial thread structure.
- *
- * We need to make sure that this is 8192-byte aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry..
- */
-union thread_union init_thread_union __init_task_data =
-	{ INIT_THREAD_INFO(init_task) };
-
