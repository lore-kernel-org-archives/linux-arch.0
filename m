From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 22/24] unicore32: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:34:03 +1000
Message-ID: <20200728033405.78469-23-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <gxt@pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

Cc: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/unicore32/include/asm/mmu_context.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
index 388c0c811c68..e1751cb5439c 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -18,24 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu-single.h>
 
-#define init_new_context(tsk, mm)	0
-
-#define destroy_context(mm)		do { } while (0)
-
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
@@ -52,9 +34,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		cpu_switch_mm(next->pgd, next);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-#define activate_mm(prev, next)	switch_mm(prev, next, NULL)
-
 /*
  * We are inserting a "fake" vma for the user-accessible vector page so
  * gdb and friends can get to it through ptrace and /proc/<pid>/mem.
@@ -95,4 +74,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 	/* by default, allow everything */
 	return true;
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0
