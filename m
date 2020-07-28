From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 06/24] csky: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:47 +1000
Message-ID: <20200728033405.78469-7-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/csky/include/asm/mmu_context.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index abdf1f1cb6ec..b227d29393a8 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -24,11 +24,6 @@
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
-#define activate_mm(prev,next)		switch_mm(prev, next, current)
-
-#define destroy_context(mm)		do {} while (0)
-#define enter_lazy_tlb(mm, tsk)		do {} while (0)
-#define deactivate_mm(tsk, mm)		do {} while (0)
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
@@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
-- 
2.23.0
