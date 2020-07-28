Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 04/24] arm: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:45 +1000
Message-ID: <20200728033405.78469-5-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728033345.eM56UUcYYqfCJisFm4IZ1C4y3-R8XPaCvfLVOGvt6Qs@z>

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/include/asm/mmu_context.h | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mm=
u_context.h
index f99ed524fe41..84e58956fcab 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -26,6 +26,8 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
=20
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *=
tsk);
+
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -92,32 +94,10 @@ static inline void finish_arch_post_lock_switch(void)
=20
 #endif	/* CONFIG_MMU */
=20
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
 #endif	/* CONFIG_CPU_HAS_ASID */
=20
-#define destroy_context(mm)		do { } while(0)
 #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
=20
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
@@ -149,6 +129,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext,
 #endif
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#include <asm-generic/mmu_context.h>
=20
 #endif
--=20
2.23.0
