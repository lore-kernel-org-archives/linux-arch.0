Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 21/24] um: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:34:02 +1000
Message-ID: <20200728033405.78469-22-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728033402.GhnZOh9Au738LiTVxVRGCSe-A7F-S9pWEcxasyiz4xg@z>

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/um/include/asm/mmu_context.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_=
context.h
index 17ddd4edf875..f8a100770691 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,9 @@ static inline bool arch_vma_access_permitted(struct vm=
_area_struct *vma,
  * end asm-generic/mm_hooks.h functions
  */
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 extern void force_flush_all(void);
=20
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *=
new)
 {
 	/*
@@ -66,13 +65,12 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next,
 	}
 }
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm,=20
-				  struct task_struct *tsk)
-{
-}
-
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *=
mm);
=20
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
=20
+#include <asm-generic/mmu_context.h>
+
 #endif
--=20
2.23.0
