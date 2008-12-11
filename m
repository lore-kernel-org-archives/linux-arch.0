From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 06/19] arm: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:44 +0000
Message-ID: <f484338a15e1ccd69743b39cf1df7d778644b9ed.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
 <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
 <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
 <ebb6a4d1c4dccd59884bfca0b42f8ffa9dbb849c.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57717 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbYLKDxi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:38 -0500
In-Reply-To: <ebb6a4d1c4dccd59884bfca0b42f8ffa9dbb849c.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, rmk@arm.linux.org.uk, Kyle McMartin <kyle@redhat.com>

Cc: rmk@arm.linux.org.uk
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/arm/Kconfig            |    1 -
 arch/arm/kernel/Makefile    |    2 +-
 arch/arm/kernel/init_task.c |   43 -------------------------------------------
 3 files changed, 1 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/kernel/init_task.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8f13edb..9722f8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,7 +18,6 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
-	select HAVE_ARCH_INIT_TASK
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 4305345..b3671bd 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -45,4 +45,4 @@ endif
 head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
-extra-y := $(head-y) init_task.o vmlinux.lds
+extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/init_task.c b/arch/arm/kernel/init_task.c
deleted file mode 100644
index 0bbf806..0000000
--- a/arch/arm/kernel/init_task.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  linux/arch/arm/kernel/init_task.c
- */
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/init_task.h>
-#include <linux/mqueue.h>
-#include <linux/uaccess.h>
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
- * Initial thread structure.
- *
- * We need to make sure that this is 8192-byte aligned due to the
- * way process stacks are handled. This is done by making sure
- * the linker maps this in the .text segment right after head.S,
- * and making head.S ensure the proper alignment.
- *
- * The things we do for performance..
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
