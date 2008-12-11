From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 12/19] m68knommu: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:50 +0000
Message-ID: <c89dc10c8a51d3f0f014dcdd86b70ef253b22710.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
 <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
 <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
 <ebb6a4d1c4dccd59884bfca0b42f8ffa9dbb849c.1228966585.git.kyle@mcmartin.ca>
 <f484338a15e1ccd69743b39cf1df7d778644b9ed.1228966585.git.kyle@mcmartin.ca>
 <9a5b7775c30315d101d24b7979d43e8018d83bfd.1228966585.git.kyle@mcmartin.ca>
 <03f8f28b93a00552becc1acff88cda27b158c9ee.1228966585.git.kyle@mcmartin.ca>
 <1e07f124e694d9c5dcbd022e5e339649eedc4fd5.1228966585.git.kyle@mcmartin.ca>
 <14045ea83a7a5b2b4b151547da92270b1976e86d.1228966585.git.kyle@mcmartin.ca>
 <7344e6bfc18e61a2409f75a59b3492c48127b946.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57756 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbYLKDxm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:42 -0500
In-Reply-To: <7344e6bfc18e61a2409f75a59b3492c48127b946.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, gerg@uclinux.org, Kyle McMartin <kyle@redhat.com>

Cc: gerg@uclinux.org
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/m68knommu/Kconfig            |    1 -
 arch/m68knommu/kernel/Makefile    |    2 +-
 arch/m68knommu/kernel/init_task.c |   42 -------------------------------------
 3 files changed, 1 insertions(+), 44 deletions(-)
 delete mode 100644 arch/m68knommu/kernel/init_task.c

diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 4019e0b..76b66fe 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -9,7 +9,6 @@ config M68K
 	bool
 	default y
 	select HAVE_IDE
-	select HAVE_ARCH_INIT_TASK
 
 config MMU
 	bool
diff --git a/arch/m68knommu/kernel/Makefile b/arch/m68knommu/kernel/Makefile
index f0eab3d..02a2c83 100644
--- a/arch/m68knommu/kernel/Makefile
+++ b/arch/m68knommu/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y := vmlinux.lds
 
-obj-y += dma.o entry.o init_task.o irq.o m68k_ksyms.o process.o ptrace.o \
+obj-y += dma.o entry.o irq.o m68k_ksyms.o process.o ptrace.o \
 	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o
 
 obj-$(CONFIG_MODULES)	+= module.o
diff --git a/arch/m68knommu/kernel/init_task.c b/arch/m68knommu/kernel/init_task.c
deleted file mode 100644
index 344c01a..0000000
--- a/arch/m68knommu/kernel/init_task.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- *  linux/arch/m68knommu/kernel/init_task.c
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
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-
-EXPORT_SYMBOL(init_mm);
-
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
-union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
-
-- 
1.6.0.4
