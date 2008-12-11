From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 09/19] frv: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:47 +0000
Message-ID: <1e07f124e694d9c5dcbd022e5e339649eedc4fd5.1228966585.git.kyle@mcmartin.ca>
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
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57699 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477AbYLKDxe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:34 -0500
In-Reply-To: <03f8f28b93a00552becc1acff88cda27b158c9ee.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, dhowells@redhat.com, Kyle McMartin <kye@mcmartin.ca>

Cc: dhowells@redhat.com
Signed-off-by: Kyle McMartin <kye@mcmartin.ca>
---
 arch/frv/Kconfig            |    1 -
 arch/frv/kernel/Makefile    |    2 +-
 arch/frv/kernel/init_task.c |   38 --------------------------------------
 3 files changed, 1 insertions(+), 40 deletions(-)
 delete mode 100644 arch/frv/kernel/init_task.c

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index f251d82..9d1552a 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -6,7 +6,6 @@ config FRV
 	bool
 	default y
 	select HAVE_IDE
-	select HAVE_ARCH_INIT_TASK
 
 config ZONE_DMA
 	bool
diff --git a/arch/frv/kernel/Makefile b/arch/frv/kernel/Makefile
index c36f70b..ad4087b 100644
--- a/arch/frv/kernel/Makefile
+++ b/arch/frv/kernel/Makefile
@@ -5,7 +5,7 @@
 heads-y				:= head-uc-fr401.o head-uc-fr451.o head-uc-fr555.o
 heads-$(CONFIG_MMU)		:= head-mmu-fr451.o
 
-extra-y:= head.o init_task.o vmlinux.lds
+extra-y:= head.o vmlinux.lds
 
 obj-y := $(heads-y) entry.o entry-table.o break.o switch_to.o kernel_thread.o \
 	 kernel_execve.o process.o traps.o ptrace.o signal.o dma.o \
diff --git a/arch/frv/kernel/init_task.c b/arch/frv/kernel/init_task.c
deleted file mode 100644
index e219881..0000000
--- a/arch/frv/kernel/init_task.c
+++ /dev/null
@@ -1,38 +0,0 @@
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
- * We need to make sure that this is THREAD_SIZE aligned due to the
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
