From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 03/19] x86: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:41 +0000
Message-ID: <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57643 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbYLKDxU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:20 -0500
In-Reply-To: <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, Kyle McMartin <kyle@redhat.com>

Leave arch/x86/kernel/init_task.c hanging around with the INIT_TSS
definition in it, a later patch will move it to an appropriate place and
nuke the file.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/x86/Kconfig            |    1 -
 arch/x86/kernel/init_task.c |   25 -------------------------
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5b913d4..ac22bb7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,7 +34,6 @@ config X86
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_GENERIC_DMA_COHERENT if X86_32
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_ARCH_INIT_TASK
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/x86/kernel/init_task.c b/arch/x86/kernel/init_task.c
index a4f93b4..de8776d 100644
--- a/arch/x86/kernel/init_task.c
+++ b/arch/x86/kernel/init_task.c
@@ -10,31 +10,6 @@
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-EXPORT_UNUSED_SYMBOL(init_mm); /* will be removed in 2.6.26 */
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
-EXPORT_SYMBOL(init_task);
-
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
  * no more per-task TSS's. The TSS size is kept cacheline-aligned
-- 
1.6.0.4
