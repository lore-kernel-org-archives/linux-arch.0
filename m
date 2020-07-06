From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Mon,  6 Jul 2020 12:18:22 +1000
Message-ID: <20200706021822.1515189-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgGFCSg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 22:18:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698EC061794
        for <linux-arch@vger.kernel.org>; Sun,  5 Jul 2020 19:18:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so37643463wmh.4
        for <linux-arch@vger.kernel.org>; Sun, 05 Jul 2020 19:18:35 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-arch@vger.kernel.org

powerpc return from interrupt and return from system call sequences are
context synchronising.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../features/sched/membarrier-sync-core/arch-support.txt      | 4 ++--
 arch/powerpc/Kconfig                                          | 1 +
 arch/powerpc/include/asm/exception-64s.h                      | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 8a521a622966..52ad74a25f54 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -5,7 +5,7 @@
 #
 # Architecture requirements
 #
-# * arm/arm64
+# * arm/arm64/powerpc
 #
 # Rely on implicit context synchronization as a result of exception return
 # when returning from IPI handler, and when returning to user-space.
@@ -45,7 +45,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..920c4e3ca4ef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -131,6 +131,7 @@ config PPC
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47bd4ea0837d..b88cb3a989b6 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -68,6 +68,10 @@
  *
  * The nop instructions allow us to insert one or more instructions to flush the
  * L1-D cache when returning to userspace or a guest.
+ *
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
+ * without additional additional synchronisation instructions.
  */
 #define RFI_FLUSH_SLOT							\
 	RFI_FLUSH_FIXUP_SECTION;					\
-- 
2.23.0
