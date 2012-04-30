Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35753 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716Ab2D3UQA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:16:00 -0400
Message-ID: <20120430194846.411165846@linutronix.de>
Date: Mon, 30 Apr 2012 20:15:58 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 14/29] microblaze: Use generic init_task
References: <20120430194725.763322463@linutronix.de>
Content-Disposition: inline; filename=microblaze-use-generic-init-task.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Message-ID: <20120430201558.AWnCblCl8kY3GHQgRIpGdQj4LDl32Z1Z7BewmLlo_Q0@z>

Same code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/Kconfig            |    1 +
 arch/microblaze/kernel/Makefile    |    2 +-
 arch/microblaze/kernel/init_task.c |   26 --------------------------
 3 files changed, 2 insertions(+), 27 deletions(-)

Index: tip/arch/microblaze/Kconfig
===================================================================
--- tip.orig/arch/microblaze/Kconfig
+++ tip/arch/microblaze/Kconfig
@@ -22,6 +22,7 @@ config MICROBLAZE
 	select GENERIC_PCI_IOMAP
 	select GENERIC_CPU_DEVICES
 	select GENERIC_ATOMIC64
+	select HAVE_GENERIC_INIT_TASK
 
 config SWAP
 	def_bool n
Index: tip/arch/microblaze/kernel/Makefile
===================================================================
--- tip.orig/arch/microblaze/kernel/Makefile
+++ tip/arch/microblaze/kernel/Makefile
@@ -16,7 +16,7 @@ endif
 extra-y := head.o vmlinux.lds
 
 obj-y += dma.o exceptions.o \
-	hw_exception_handler.o init_task.o intc.o irq.o \
+	hw_exception_handler.o intc.o irq.o \
 	process.o prom.o prom_parse.o ptrace.o \
 	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
 
Index: tip/arch/microblaze/kernel/init_task.c
===================================================================
--- tip.orig/arch/microblaze/kernel/init_task.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright (C) 2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init_task.h>
-#include <linux/fs.h>
-#include <linux/mqueue.h>
-
-#include <asm/pgtable.h>
-
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-
-union thread_union init_thread_union __init_task_data =
-	{ INIT_THREAD_INFO(init_task) };
-
-struct task_struct init_task = INIT_TASK(init_task);
-EXPORT_SYMBOL(init_task);


