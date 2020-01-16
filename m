From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 6/9] asm-generic/tlb: Rename HAVE_RCU_TABLE_FREE
Date: Thu, 16 Jan 2020 12:15:28 +0530
Message-ID: <20200116064531.483522-7-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/Kconfig                    |  2 +-
 arch/arm/Kconfig                |  2 +-
 arch/arm/include/asm/tlb.h      |  2 +-
 arch/arm64/Kconfig              |  2 +-
 arch/powerpc/Kconfig            |  2 +-
 arch/s390/Kconfig               |  2 +-
 arch/sparc/Kconfig              |  2 +-
 arch/sparc/include/asm/tlb_64.h |  2 +-
 arch/x86/Kconfig                |  2 +-
 arch/x86/include/asm/tlb.h      |  4 ++--
 include/asm-generic/tlb.h       | 10 +++++-----
 mm/gup.c                        |  2 +-
 mm/mmu_gather.c                 |  8 ++++----
 13 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5e907a954532..501d565690b5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -393,7 +393,7 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_ARCH_JUMP_LABEL_RELATIVE
 	bool
=20
-config HAVE_RCU_TABLE_FREE
+config MMU_GATHER_RCU_TABLE_FREE
 	bool
=20
 config HAVE_MMU_GATHER_PAGE_SIZE
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96dab76da3b3..36445579243c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -102,7 +102,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE if SMP && ARM_LPAE
+	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 669474add486..46a21cee3442 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -37,7 +37,7 @@ static inline void __tlb_remove_table(void *_table)
=20
 #include <asm-generic/tlb.h>
=20
-#ifndef CONFIG_HAVE_RCU_TABLE_FREE
+#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 #define tlb_remove_table(tlb, entry) tlb_remove_page(tlb, entry)
 #endif
=20
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e688dfad0b72..a434f7c2438f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,7 +162,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_FUNCTION_ARG_ACCESS_API
-	select HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f9970f87612e..955759234776 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -222,7 +222,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS=
_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bc88841d335d..e2cde82a1a3c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -169,7 +169,7 @@ config S390
 	select HAVE_OPROFILE
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
-	select HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 18e9fb6fcf1b..c703eb6b7461 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,7 +64,7 @@ config SPARC64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select HAVE_RCU_TABLE_FREE if SMP
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb=
_64.h
index 8cb8f3833239..6820d357581c 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -33,7 +33,7 @@ void flush_tlb_pending(void);
  * and therefore we don't need a TLBI when freeing page-table pages.
  */
=20
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 #define tlb_needs_table_invalidate()	(false)
 #endif
=20
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..f809bed408dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -200,7 +200,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE		if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER |=
| UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index f23e7aaff4cd..820082bd6880 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -29,8 +29,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
  * shootdown, enablement code for several hypervisors overrides
  * .flush_tlb_others hook in pv_mmu_ops and implements it by issuing
  * a hypercall. To keep software pagetable walkers safe in this case we
- * switch to RCU based table free (HAVE_RCU_TABLE_FREE). See the comment
- * below 'ifdef CONFIG_HAVE_RCU_TABLE_FREE' in include/asm-generic/tlb.h
+ * switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the c=
omment
+ * below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic=
/tlb.h
  * for more details.
  */
 static inline void __tlb_remove_table(void *table)
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 1a4cea5f95df..04a1b8f08eea 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -126,7 +126,7 @@
  *  This ensures we call tlb_flush() every time tlb_change_page_size() a=
ctually
  *  changes the size and provides mmu_gather::page_size to tlb_flush().
  *
- *  HAVE_RCU_TABLE_FREE
+ *  MMU_GATHER_RCU_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_p=
age()
  *  for page directores (__p*_free_tlb()). This provides separate freein=
g of
@@ -142,7 +142,7 @@
  *  Use this if your architecture lacks an efficient flush_tlb_range().
  */
=20
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 /*
  * Semi RCU freeing of the page directories.
  *
@@ -193,10 +193,10 @@ extern void tlb_remove_table(struct mmu_gather *tlb=
, void *table);
 #else
=20
 #ifdef tlb_needs_table_invalidate
-#error tlb_needs_table_invalidate() requires HAVE_RCU_TABLE_FREE
+#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
 #endif
=20
-#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
=20
=20
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
@@ -235,7 +235,7 @@ extern bool __tlb_remove_page_size(struct mmu_gather =
*tlb, struct page *page,
 struct mmu_gather {
 	struct mm_struct	*mm;
=20
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
=20
diff --git a/mm/gup.c b/mm/gup.c
index 7646bf993b25..789fadc011b8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1729,7 +1729,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * Before activating this code, please be aware that the following assum=
ptions
  * are currently made:
  *
- *  *) Either HAVE_RCU_TABLE_FREE is enabled, and tlb_remove_table() is =
used to
+ *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table=
() is used to
  *  free pages containing page tables or TLB flushing requires IPI broad=
cast.
  *
  *  *) ptes can be read atomically by the architecture.
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7c1b8f67af7b..86bb2176e173 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,7 +91,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, str=
uct page *page, int page_
=20
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
=20
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
=20
 /*
  * See the comment near struct mmu_table_batch.
@@ -173,11 +173,11 @@ void tlb_remove_table(struct mmu_gather *tlb, void =
*table)
 		tlb_table_flush(tlb);
 }
=20
-#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
=20
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
@@ -220,7 +220,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm=
_struct *mm,
 	tlb->batch_count =3D 0;
 #endif
=20
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb->batch =3D NULL;
 #endif
 #ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
--=20
2.24.1
