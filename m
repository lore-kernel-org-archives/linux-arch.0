From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 1/9] powerpc/mmu_gather: Enable RCU_TABLE_FREE even for !SMP case
Date: Thu, 16 Jan 2020 12:15:23 +0530
Message-ID: <20200116064531.483522-2-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

A follow up patch is going to make sure we correctly invalidate page walk=
 cache
before we free page table pages. In order to keep things simple enable
RCU_TABLE_FREE even for !SMP so that we don't have to fixup the !SMP case
differently in the followup patch

!SMP case is right now broken for radix translation w.r.t page walk cache=
 flush.
We can get interrupted in between page table free and that would imply we
have page walk cache entries pointing to tables which got freed already.

Cc: <stable@vger.kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/Kconfig                         | 2 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 8 --------
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 2 --
 arch/powerpc/include/asm/nohash/pgalloc.h    | 8 --------
 arch/powerpc/mm/book3s64/pgtable.c           | 7 -------
 5 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1ec34e16ed65..04240205f38c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -222,7 +222,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS=
_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE		if SMP
+	select HAVE_RCU_TABLE_FREE
 	select HAVE_RCU_TABLE_NO_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/=
include/asm/book3s/32/pgalloc.h
index 998317702630..dc5c039eb28e 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -49,7 +49,6 @@ static inline void pgtable_free(void *table, unsigned i=
ndex_size)
=20
 #define get_hugepd_cache_index(x)  (x)
=20
-#ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 				    void *table, int shift)
 {
@@ -66,13 +65,6 @@ static inline void __tlb_remove_table(void *_table)
=20
 	pgtable_free(table, shift);
 }
-#else
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif
=20
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t tabl=
e,
 				  unsigned long address)
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/=
include/asm/book3s/64/pgalloc.h
index f6968c811026..a41e91bd0580 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -19,9 +19,7 @@ extern struct vmemmap_backing *vmemmap_list;
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
 extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int sh=
ift);
-#ifdef CONFIG_SMP
 extern void __tlb_remove_table(void *_table);
-#endif
 void pte_frag_destroy(void *pte_frag);
=20
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/inc=
lude/asm/nohash/pgalloc.h
index 332b13b4ecdb..29c43665a753 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -46,7 +46,6 @@ static inline void pgtable_free(void *table, int shift)
=20
 #define get_hugepd_cache_index(x)	(x)
=20
-#ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table,=
 int shift)
 {
 	unsigned long pgf =3D (unsigned long)table;
@@ -64,13 +63,6 @@ static inline void __tlb_remove_table(void *_table)
 	pgtable_free(table, shift);
 }
=20
-#else
-static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table,=
 int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t tabl=
e,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s6=
4/pgtable.c
index 75483b40fcb1..2bf7e1b4fd82 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -378,7 +378,6 @@ static inline void pgtable_free(void *table, int inde=
x)
 	}
 }
=20
-#ifdef CONFIG_SMP
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
 	unsigned long pgf =3D (unsigned long)table;
@@ -395,12 +394,6 @@ void __tlb_remove_table(void *_table)
=20
 	return pgtable_free(table, index);
 }
-#else
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
-{
-	return pgtable_free(table, index);
-}
-#endif
=20
 #ifdef CONFIG_PROC_FS
 atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
--=20
2.24.1
