From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 16/19] powerpc: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:54 +0000
Message-ID: <f44a6af7a78f7e8a00e3752ffff91ca4efc8ab39.1228966585.git.kyle@mcmartin.ca>
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
 <c89dc10c8a51d3f0f014dcdd86b70ef253b22710.1228966585.git.kyle@mcmartin.ca>
 <e7880c938229e333f2c0dbe34eee62257c159a5e.1228966585.git.kyle@mcmartin.ca>
 <c69d1bb5f1e3ae73b0cf1fa9cede84033f996ca3.1228966585.git.kyle@mcmartin.ca>
 <8309dc46f45b9b653f23db3ea3865167f4b1d852.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57802 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbYLKDyK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:54:10 -0500
In-Reply-To: <8309dc46f45b9b653f23db3ea3865167f4b1d852.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, paulus@samba.org, Kyle McMartin <kyle@redhat.com>

Cc: paulus@samba.org
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/powerpc/Kconfig            |    1 -
 arch/powerpc/kernel/Makefile    |    2 +-
 arch/powerpc/kernel/init_task.c |   35 -----------------------------------
 3 files changed, 1 insertions(+), 37 deletions(-)
 delete mode 100644 arch/powerpc/kernel/init_task.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f1db45..525c13a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -121,7 +121,6 @@ config PPC
 	select HAVE_DMA_ATTRS if PPC64
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
-	select HAVE_ARCH_INIT_TASK
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 92673b4..b329ecb 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -27,7 +27,7 @@ endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   init_task.o process.o systbl.o idle.o \
+				   process.o systbl.o idle.o \
 				   signal.o sysfs.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
diff --git a/arch/powerpc/kernel/init_task.c b/arch/powerpc/kernel/init_task.c
deleted file mode 100644
index 4c85b8d..0000000
--- a/arch/powerpc/kernel/init_task.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/init_task.h>
-#include <linux/fs.h>
-#include <linux/mqueue.h>
-#include <asm/uaccess.h>
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
- * We need to make sure that this is 16384-byte aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry..
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
