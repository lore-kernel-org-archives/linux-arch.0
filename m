From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 11/29] ia64: Use generic init_task
Date: Mon, 30 Apr 2012 20:15:57 -0000
Message-ID: <20120430194846.223956746@linutronix.de>
References: <20120430194725.763322463@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35739 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab2D3UP6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:15:58 -0400
Content-Disposition: inline; filename=ia64-use-generic-idle-task.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>

IA64 has a special crafted version of init_task, but I could not
figure out why it couldn't work with the generic one.

The special Makefile treatment is pointless as init_task.o contains
only data which is handled by the linker script. So no point on being
treated like head text.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/ia64/Kconfig            |    1 +
 arch/ia64/Makefile           |    2 +-
 arch/ia64/kernel/Makefile    |    2 +-
 arch/ia64/kernel/init_task.c |   42 ------------------------------------------
 4 files changed, 3 insertions(+), 44 deletions(-)

Index: tip/arch/ia64/Kconfig
===================================================================
--- tip.orig/arch/ia64/Kconfig
+++ tip/arch/ia64/Kconfig
@@ -34,6 +34,7 @@ config IA64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD
+	select HAVE_GENERIC_INIT_TASK
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
Index: tip/arch/ia64/Makefile
===================================================================
--- tip.orig/arch/ia64/Makefile
+++ tip/arch/ia64/Makefile
@@ -42,7 +42,7 @@ $(error Sorry, you need a newer version 
 endif
 
 KBUILD_CFLAGS += $(cflags-y)
-head-y := arch/ia64/kernel/head.o arch/ia64/kernel/init_task.o
+head-y := arch/ia64/kernel/head.o
 
 libs-y				+= arch/ia64/lib/
 core-y				+= arch/ia64/kernel/ arch/ia64/mm/
Index: tip/arch/ia64/kernel/Makefile
===================================================================
--- tip.orig/arch/ia64/kernel/Makefile
+++ tip/arch/ia64/kernel/Makefile
@@ -6,7 +6,7 @@ ifdef CONFIG_DYNAMIC_FTRACE
 CFLAGS_REMOVE_ftrace.o = -pg
 endif
 
-extra-y	:= head.o init_task.o vmlinux.lds
+extra-y	:= head.o vmlinux.lds
 
 obj-y := entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o paravirt_patchlist.o patch.o process.o perfmon.o ptrace.o sal.o		\
Index: tip/arch/ia64/kernel/init_task.c
===================================================================
--- tip.orig/arch/ia64/kernel/init_task.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * This is where we statically allocate and initialize the initial
- * task.
- *
- * Copyright (C) 1999, 2002-2003 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- */
-
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init_task.h>
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
- * We need to make sure that this is properly aligned due to the way process stacks are
- * handled. This is done by having a special ".data..init_task" section...
- */
-#define init_thread_info	init_task_mem.s.thread_info
-
-union {
-	struct {
-		struct task_struct task;
-		struct thread_info thread_info;
-	} s;
-	unsigned long stack[KERNEL_STACK_SIZE/sizeof (unsigned long)];
-} init_task_mem asm ("init_task") __init_task_data =
-	{{
-	.task =		INIT_TASK(init_task_mem.s.task),
-	.thread_info =	INIT_THREAD_INFO(init_task_mem.s.task)
-}};
-
-EXPORT_SYMBOL(init_task);
