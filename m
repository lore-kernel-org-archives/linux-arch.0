Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 15/24] parisc: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 13:33:56 +1000
Message-ID: <20200728033405.78469-16-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728033356.hCFX_XcXr7dvmXY77Y4pYdyk-TT-UunFJEFiaeIH6tk@z>

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/parisc/include/asm/mmu_context.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/=
asm/mmu_context.h
index 07b89c74abeb..71f8a3679b83 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -8,16 +8,13 @@
 #include <asm/pgalloc.h>
 #include <asm-generic/mm_hooks.h>
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 /* on PA-RISC, we actually have enough contexts to justify an allocator
  * for them.  prumpf */
=20
 extern unsigned long alloc_sid(void);
 extern void free_sid(unsigned long);
=20
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -27,6 +24,7 @@ init_new_context(struct task_struct *tsk, struct mm_str=
uct *mm)
 	return 0;
 }
=20
+#define destroy_context destroy_context
 static inline void
 destroy_context(struct mm_struct *mm)
 {
@@ -72,8 +70,7 @@ static inline void switch_mm(struct mm_struct *prev,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct =
*next)
 {
 	/*
@@ -91,4 +88,7 @@ static inline void activate_mm(struct mm_struct *prev, =
struct mm_struct *next)
=20
 	switch_mm(prev,next,current);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
--=20
2.23.0
