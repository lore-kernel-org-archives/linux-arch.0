From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 15/19] parisc: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:53 +0000
Message-ID: <8309dc46f45b9b653f23db3ea3865167f4b1d852.1228966585.git.kyle@mcmartin.ca>
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
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57716 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518AbYLKDxi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:38 -0500
In-Reply-To: <c69d1bb5f1e3ae73b0cf1fa9cede84033f996ca3.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, Kyle McMartin <kyle@redhat.com>

swapper page tables need to be moved before this file can be nuked...

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/parisc/Kconfig            |    1 -
 arch/parisc/kernel/init_task.c |   28 ----------------------------
 2 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fe0a9d3..644a70b 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -11,7 +11,6 @@ config PARISC
 	select HAVE_OPROFILE
 	select RTC_CLASS
 	select RTC_DRV_PARISC
-	select HAVE_ARCH_INIT_TASK
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
 	  in many of their workstations & servers (HP9000 700 and 800 series,
diff --git a/arch/parisc/kernel/init_task.c b/arch/parisc/kernel/init_task.c
index f5941c0..4bfa119 100644
--- a/arch/parisc/kernel/init_task.c
+++ b/arch/parisc/kernel/init_task.c
@@ -34,24 +34,6 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 
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
- * We need to make sure that this is 16384-byte aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry..
- */
-union thread_union init_thread_union
-	__attribute__((aligned(128))) __attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
-
 #if PT_NLEVELS == 3
 /* NOTE: This layout exactly conforms to the hybrid L2/L3 page table layout
  * with the first pmd adjacent to the pgd and below it. gcc doesn't actually
@@ -63,13 +45,3 @@ pmd_t pmd0[PTRS_PER_PMD] __attribute__ ((__section__ (".data.vm0.pmd"), aligned(
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__ ((__section__ (".data.vm0.pgd"), aligned(PAGE_SIZE)));
 pte_t pg0[PT_INITIAL * PTRS_PER_PTE] __attribute__ ((__section__ (".data.vm0.pte"), aligned(PAGE_SIZE)));
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-EXPORT_SYMBOL(init_task);
-
-__asm__(".data");
-struct task_struct init_task = INIT_TASK(init_task);
-- 
1.6.0.4
