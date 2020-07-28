From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 10/24] microblaze: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:51 +1000
Message-ID: <20200728033405.78469-11-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgG1De5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:57 -0400
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
 arch/microblaze/include/asm/processor.h      | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index a1c7dd48454c..c2c77f708455 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -33,10 +33,6 @@
    to represent all kernel pages as shared among all contexts.
  */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 # define NO_CONTEXT	256
 # define LAST_CONTEXT	255
 # define FIRST_CONTEXT	1
@@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
@@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *active_mm,
 			struct mm_struct *mm)
 {
@@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *active_mm,
 
 extern void mmu_context_init(void);
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 1ff5a82b76b6..616211871a6e 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
 #  define KSTK_EIP(task)	(task_pc(task))
 #  define KSTK_ESP(task)	(task_sp(task))
 
-/* FIXME */
-#  define deactivate_mm(tsk, mm)	do { } while (0)
-
 #  define STACK_TOP	TASK_SIZE
 #  define STACK_TOP_MAX	STACK_TOP
 
-- 
2.23.0
