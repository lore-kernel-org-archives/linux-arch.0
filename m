From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 04/24] arm: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:45 +1000
Message-ID: <20200728033405.78469-5-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1Def (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:35 -0400
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/include/asm/mmu_context.h | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index f99ed524fe41..84e58956fcab 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -26,6 +26,8 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
+
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -92,32 +94,10 @@ static inline void finish_arch_post_lock_switch(void)
 
 #endif	/* CONFIG_MMU */
 
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
 #endif	/* CONFIG_CPU_HAS_ASID */
 
-#define destroy_context(mm)		do { } while(0)
 #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
 
-/*
- * This is called when "tsk" is about to enter lazy TLB mode.
- *
- * mm:  describes the currently active mm context
- * tsk: task which is entering lazy tlb
- * cpu: cpu number which is entering lazy tlb
- *
- * tsk->mm will be NULL
- */
-static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * This is the actual mm switch as far as the scheduler
  * is concerned.  No registers are touched.  We avoid
@@ -149,6 +129,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #endif
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #endif
-- 
2.23.0
