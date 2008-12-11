From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 17/19] s390: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:55 +0000
Message-ID: <3079779dc9d85bd0fa806e05fe4c0199ca22c624.1228966585.git.kyle@mcmartin.ca>
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
 <f44a6af7a78f7e8a00e3752ffff91ca4efc8ab39.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57781 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569AbYLKDxy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:54 -0500
In-Reply-To: <f44a6af7a78f7e8a00e3752ffff91ca4efc8ab39.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, schwidefsky@de.ibm.com, Kyle McMartin <kyle@redhat.com>

Cc: schwidefsky@de.ibm.com
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/s390/Kconfig            |    1 -
 arch/s390/kernel/Makefile    |    2 +-
 arch/s390/kernel/init_task.c |   44 ------------------------------------------
 3 files changed, 1 insertions(+), 46 deletions(-)
 delete mode 100644 arch/s390/kernel/init_task.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4381302..8116a33 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -75,7 +75,6 @@ config S390
 	select HAVE_KRETPROBES
 	select HAVE_KVM if 64BIT
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_ARCH_INIT_TASK
 
 source "init/Kconfig"
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 50f657e..35331a2 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -19,7 +19,7 @@ obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
 
-extra-y				+= head.o init_task.o vmlinux.lds
+extra-y				+= head.o vmlinux.lds
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o topology.o
diff --git a/arch/s390/kernel/init_task.c b/arch/s390/kernel/init_task.c
deleted file mode 100644
index e807168..0000000
--- a/arch/s390/kernel/init_task.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- *  arch/s390/kernel/init_task.c
- *
- *  S390 version
- *
- *  Derived from "arch/i386/kernel/init_task.c"
- */
-
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
