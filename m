From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 07/19] avr32: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:45 +0000
Message-ID: <9a5b7775c30315d101d24b7979d43e8018d83bfd.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
 <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
 <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
 <ebb6a4d1c4dccd59884bfca0b42f8ffa9dbb849c.1228966585.git.kyle@mcmartin.ca>
 <f484338a15e1ccd69743b39cf1df7d778644b9ed.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57691 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbYLKDxc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:32 -0500
In-Reply-To: <f484338a15e1ccd69743b39cf1df7d778644b9ed.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, hskinnemoen@atmel.com, Kyle McMartin <kyle@redhat.com>

Cc: hskinnemoen@atmel.com
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/avr32/Kconfig            |    1 -
 arch/avr32/kernel/Makefile    |    2 +-
 arch/avr32/kernel/init_task.c |   37 -------------------------------------
 3 files changed, 1 insertions(+), 39 deletions(-)
 delete mode 100644 arch/avr32/kernel/init_task.c

diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index a69ad8d..26eca87 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -13,7 +13,6 @@ config AVR32
 	select HAVE_CLK
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
-	select HAVE_ARCH_INIT_TASK
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
diff --git a/arch/avr32/kernel/Makefile b/arch/avr32/kernel/Makefile
index 18229d0..9e2c465 100644
--- a/arch/avr32/kernel/Makefile
+++ b/arch/avr32/kernel/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_SUBARCH_AVR32B)	+= entry-avr32b.o
 obj-y				+= syscall_table.o syscall-stubs.o irq.o
 obj-y				+= setup.o traps.o ocd.o ptrace.o
 obj-y				+= signal.o sys_avr32.o process.o time.o
-obj-y				+= init_task.o switch_to.o cpu.o
+obj-y				+= switch_to.o cpu.o
 obj-$(CONFIG_MODULES)		+= module.o avr32_ksyms.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/avr32/kernel/init_task.c b/arch/avr32/kernel/init_task.c
deleted file mode 100644
index 4405846..0000000
--- a/arch/avr32/kernel/init_task.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2004-2006 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/sched.h>
-#include <linux/init_task.h>
-#include <linux/mqueue.h>
-
-#include <asm/pgtable.h>
-
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-
-EXPORT_SYMBOL(init_mm);
-
-/*
- * Initial thread structure. Must be aligned on an 8192-byte boundary.
- */
-union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_task);
-- 
1.6.0.4
