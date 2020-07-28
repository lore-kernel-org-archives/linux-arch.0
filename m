From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 13/24] nios2: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:54 +1000
Message-ID: <20200728033405.78469-14-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <ley.foon.tan@intel.com>
List-Id: linux-arch.vger.kernel.org

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nios2/include/asm/mmu_context.h | 21 ++++-----------------
 arch/nios2/mm/mmu_context.c          |  1 +
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/nios2/include/asm/mmu_context.h b/arch/nios2/include/asm/mmu_context.h
index 78ab3dacf579..4f99ed09b5a7 100644
--- a/arch/nios2/include/asm/mmu_context.h
+++ b/arch/nios2/include/asm/mmu_context.h
@@ -26,16 +26,13 @@ extern unsigned long get_pid_from_context(mm_context_t *ctx);
  */
 extern pgd_t *pgd_current;
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * Initialize the context related info for a new mm_struct instance.
  *
  * Set all new contexts to 0, that way the generation will never match
  * the currently running generation when this context is switched in.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 					struct mm_struct *mm)
 {
@@ -43,26 +40,16 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		struct task_struct *tsk);
 
-static inline void deactivate_mm(struct task_struct *tsk,
-				struct mm_struct *mm)
-{
-}
-
 /*
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_NIOS2_MMU_CONTEXT_H */
diff --git a/arch/nios2/mm/mmu_context.c b/arch/nios2/mm/mmu_context.c
index 45d6b9c58d67..d77aa542deb2 100644
--- a/arch/nios2/mm/mmu_context.c
+++ b/arch/nios2/mm/mmu_context.c
@@ -103,6 +103,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	next->context = get_new_context();
-- 
2.23.0
