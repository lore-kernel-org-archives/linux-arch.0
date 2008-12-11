From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 05/19] alpha: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:43 +0000
Message-ID: <ebb6a4d1c4dccd59884bfca0b42f8ffa9dbb849c.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
 <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
 <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57674 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbYLKDx2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:28 -0500
In-Reply-To: <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, ink@jurassic.park.msu.ru, rth@twiddle.net, Kyle McMartin <kyle@redhat.com>

Cc: ink@jurassic.park.msu.ru
Cc: rth@twiddle.net
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/alpha/Kconfig            |    1 -
 arch/alpha/kernel/Makefile    |    2 +-
 arch/alpha/kernel/init_task.c |   22 ----------------------
 3 files changed, 1 insertions(+), 24 deletions(-)
 delete mode 100644 arch/alpha/kernel/init_task.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5752c74..6110197 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -8,7 +8,6 @@ config ALPHA
 	select HAVE_AOUT
 	select HAVE_IDE
 	select HAVE_OPROFILE
-	select HAVE_ARCH_INIT_TASK
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index ac706c1..4028f1a 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y		:= head.o vmlinux.lds
 EXTRA_AFLAGS	:= $(KBUILD_CFLAGS)
 EXTRA_CFLAGS	:= -Werror -Wno-sign-compare
 
-obj-y    := entry.o traps.o process.o init_task.o osf_sys.o irq.o \
+obj-y    := entry.o traps.o process.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o \
 	    alpha_ksyms.o systbls.o err_common.o io.o
 
diff --git a/arch/alpha/kernel/init_task.c b/arch/alpha/kernel/init_task.c
deleted file mode 100644
index 901a0e2..0000000
--- a/arch/alpha/kernel/init_task.c
+++ /dev/null
@@ -1,22 +0,0 @@
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
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_mm);
-EXPORT_SYMBOL(init_task);
-
-union thread_union init_thread_union
-	__attribute__((section(".data.init_task")))
-	= { INIT_THREAD_INFO(init_task) };
-- 
1.6.0.4
