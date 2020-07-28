Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 05/24] arm64: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:46 +1000
Message-ID: <20200728033405.78469-6-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728033346.HbVnpPbNz8Q9sYyZu41iMUtvGghvA5iCCfvwL9FMfnA@z>

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/include/asm/mmu_context.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/as=
m/mmu_context.h
index b0bd9b55594c..0f5e351f586a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -174,7 +174,6 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly whe=
n you
  * take CPU migration into account.
  */
-#define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
=20
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); =
0; })
@@ -202,6 +201,7 @@ static inline void update_saved_ttbr0(struct task_str=
uct *tsk,
 }
 #endif
=20
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -244,12 +244,11 @@ switch_mm(struct mm_struct *prev, struct mm_struct =
*next,
 	update_saved_ttbr0(tsk, next);
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, current)
-
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* !__ASM_MMU_CONTEXT_H */
--=20
2.23.0
