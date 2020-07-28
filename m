From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 19/24] sh: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:34:00 +1000
Message-ID: <20200728033405.78469-20-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sh/include/asm/mmu_context.h    | 5 ++---
 arch/sh/include/asm/mmu_context_32.h | 9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 9470d17c71c2..ce40147d4a7d 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -85,6 +85,7 @@ static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -121,9 +122,7 @@ static inline void switch_mm(struct mm_struct *prev,
 			activate_context(next, cpu);
 }
 
-#define activate_mm(prev, next)		switch_mm((prev),(next),NULL)
-#define deactivate_mm(tsk,mm)		do { } while (0)
-#define enter_lazy_tlb(mm,tsk)		do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #else
 
diff --git a/arch/sh/include/asm/mmu_context_32.h b/arch/sh/include/asm/mmu_context_32.h
index 71bf12ef1f65..bc5034fa6249 100644
--- a/arch/sh/include/asm/mmu_context_32.h
+++ b/arch/sh/include/asm/mmu_context_32.h
@@ -2,15 +2,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_32_H
 #define __ASM_SH_MMU_CONTEXT_32_H
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-	/* Do nothing */
-}
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 static inline void set_asid(unsigned long asid)
 {
-- 
2.23.0
