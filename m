From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 03/24] arc: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:44 +1000
Message-ID: <20200728033405.78469-4-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1Dec (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:32 -0400
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arc/include/asm/mmu_context.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index 3a5e6a5b9ed6..586d31902a99 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -102,6 +102,7 @@ static inline void get_new_mmu_context(struct mm_struct *mm)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -113,6 +114,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	unsigned long flags;
@@ -153,13 +155,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 /*
- * Called at the time of execve() to get a new ASID
- * Note the subtlety here: get_new_mmu_context() behaves differently here
- * vs. in switch_mm(). Here it always returns a new ASID, because mm has
- * an unallocated "initial" value, while in latter, it moves to a new ASID,
- * only if it was unallocated
+ * activate_mm defaults to switch_mm and is called at the time of execve() to
+ * get a new ASID Note the subtlety here: get_new_mmu_context() behaves
+ * differently here vs. in switch_mm(). Here it always returns a new ASID,
+ * because mm has an unallocated "initial" value, while in latter, it moves to
+ * a new ASID, only if it was unallocated
  */
-#define activate_mm(prev, next)		switch_mm(prev, next, NULL)
 
 /* it seemed that deactivate_mm( ) is a reasonable place to do book-keeping
  * for retiring-mm. However destroy_context( ) still needs to do that because
@@ -168,8 +169,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * there is a good chance that task gets sched-out/in, making it's ASID valid
  * again (this teased me for a whole day).
  */
-#define deactivate_mm(tsk, mm)   do { } while (0)
 
-#define enter_lazy_tlb(mm, tsk)
+#include <asm-generic/mmu_context.h>
 
 #endif /* __ASM_ARC_MMU_CONTEXT_H */
-- 
2.23.0
