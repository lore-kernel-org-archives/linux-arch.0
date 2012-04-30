From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/29] cris: Use generic init_task
Date: Mon, 30 Apr 2012 20:15:55 -0000
Message-ID: <20120430194845.972721401@linutronix.de>
References: <20120430194725.763322463@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=cris-use-generic-idle-task.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

Same code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
---
 arch/cris/Kconfig          |    1 +
 arch/cris/kernel/process.c |   28 ----------------------------
 2 files changed, 1 insertion(+), 28 deletions(-)

Index: tip/arch/cris/Kconfig
===================================================================
--- tip.orig/arch/cris/Kconfig
+++ tip/arch/cris/Kconfig
@@ -50,6 +50,7 @@ config CRIS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD if ETRAX_ARCH_V32
+	select HAVE_GENERIC_INIT_TASK
 
 config HZ
 	int
Index: tip/arch/cris/kernel/process.c
===================================================================
--- tip.orig/arch/cris/kernel/process.c
+++ tip/arch/cris/kernel/process.c
@@ -29,34 +29,6 @@
 //#define DEBUG
 
 /*
- * Initial task structure. Make this a per-architecture thing,
- * because different architectures tend to have different
- * alignment requirements and potentially different initial
- * setup.
- */
-
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
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
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_task);
-
-/*
  * The hlt_counter, disable_hlt and enable_hlt is just here as a hook if
  * there would ever be a halt sequence (for power save when idle) with
  * some largish delay when halting or resuming *and* a driver that can't
