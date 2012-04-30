Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35704 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2D3UPy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:15:54 -0400
Message-ID: <20120430194845.673400007@linutronix.de>
Date: Mon, 30 Apr 2012 20:15:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/29] alpha: Use generic init_task
References: <20120430194725.763322463@linutronix.de>
Content-Disposition: inline; filename=alpha-use-generic-init-task.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Matt Turner <mattst88@gmail.com>
Message-ID: <20120430201552.Vvc2xsZINIvA8o_L0-Xz1-07OJMPl_hpu3gTgSiBF0o@z>

Identical code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/Kconfig            |    1 +
 arch/alpha/kernel/Makefile    |    2 +-
 arch/alpha/kernel/init_task.c |   17 -----------------
 3 files changed, 2 insertions(+), 18 deletions(-)

Index: tip/arch/alpha/Kconfig
===================================================================
--- tip.orig/arch/alpha/Kconfig
+++ tip/arch/alpha/Kconfig
@@ -16,6 +16,7 @@ config ALPHA
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
+	select HAVE_GENERIC_INIT_TASK
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
Index: tip/arch/alpha/kernel/Makefile
===================================================================
--- tip.orig/arch/alpha/kernel/Makefile
+++ tip/arch/alpha/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y		:= head.o vmlinux.lds
 asflags-y	:= $(KBUILD_CFLAGS)
 ccflags-y	:= -Wno-sign-compare
 
-obj-y    := entry.o traps.o process.o init_task.o osf_sys.o irq.o \
+obj-y    := entry.o traps.o process.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o \
 	    alpha_ksyms.o systbls.o err_common.o io.o
 
Index: tip/arch/alpha/kernel/init_task.c
===================================================================
--- tip.orig/arch/alpha/kernel/init_task.c
+++ /dev/null
@@ -1,17 +0,0 @@
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/init_task.h>
-#include <linux/fs.h>
-#include <linux/mqueue.h>
-#include <asm/uaccess.h>
-
-
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct task_struct init_task = INIT_TASK(init_task);
-EXPORT_SYMBOL(init_task);
-
-union thread_union init_thread_union __init_task_data =
-	{ INIT_THREAD_INFO(init_task) };


