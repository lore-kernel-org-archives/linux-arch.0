Return-Path: <SRS0=PUSD=5Q=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to flush_pmd_tlb_range
Date: Tue, 31 Mar 2020 22:29:23 +0800
Message-ID: <20200331142927.1237-5-yezhenyu2@huawei.com>
In-Reply-To: <20200331142927.1237-1-yezhenyu2@huawei.com>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, corbet@lwn.net, vgupta@synopsys.com, tony.luck@intel.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200331142923.2_x4CKfWHfMJrQjVlXwRvYuxYZwe2r19vQ7SWP1PB9E@z>

Preparations to support for passing struct mmu_gather to
flush_tlb_range.  See in future patches.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arc/include/asm/hugepage.h               |  4 +--
 arch/arc/include/asm/tlbflush.h               |  5 +--
 arch/arc/mm/tlb.c                             |  4 +--
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  3 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  8 ++++-
 include/asm-generic/pgtable.h                 |  4 +--
 mm/pgtable-generic.c                          | 35 ++++++++++++++++---
 7 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugep=
age.h
index 30ac40fed2c5..c2b325dd47f2 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -67,8 +67,8 @@ extern void pgtable_trans_huge_deposit(struct mm_struct=
 *mm, pmd_t *pmdp,
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t=
 *pmdp);
=20
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
-extern void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned lon=
g start,
-				unsigned long end);
+extern void flush_pmd_tlb_range(struct mmu_gather *tlb, struct vm_area_s=
truct *vma,
+				unsigned long start, unsigned long end);
=20
 /* We don't have hardware dirty/accessed bits, generic_pmdp_establish is=
 fine.*/
 #define pmdp_establish generic_pmdp_establish
diff --git a/arch/arc/include/asm/tlbflush.h b/arch/arc/include/asm/tlbfl=
ush.h
index 992a2837a53f..49e4e5b59bb2 100644
--- a/arch/arc/include/asm/tlbflush.h
+++ b/arch/arc/include/asm/tlbflush.h
@@ -26,7 +26,7 @@ void local_flush_pmd_tlb_range(struct vm_area_struct *v=
ma, unsigned long start,
 #define flush_tlb_all()			local_flush_tlb_all()
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define flush_pmd_tlb_range(vma, s, e)	local_flush_pmd_tlb_range(vma, s,=
 e)
+#define flush_pmd_tlb_range(tlb, vma, s, e)	local_flush_pmd_tlb_range(vm=
a, s, e)
 #endif
 #else
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long st=
art,
@@ -36,7 +36,8 @@ extern void flush_tlb_kernel_range(unsigned long start,=
 unsigned long end);
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned lon=
g start, unsigned long end);
+extern void flush_pmd_tlb_range(struct mmu_gather *tlb, struct vm_area_s=
truct *vma,
+				unsigned long start, unsigned long end);
 #endif
 #endif /* CONFIG_SMP */
 #endif
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index c340acd989a0..10b2a2373dc0 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -464,8 +464,8 @@ void flush_tlb_range(struct vm_area_struct *vma, unsi=
gned long start,
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
-			 unsigned long end)
+void flush_pmd_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *=
vma,
+			 unsigned long start, unsigned long end)
 {
 	struct tlb_args ta =3D {
 		.ta_vma =3D vma,
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc=
/include/asm/book3s/64/tlbflush.h
index dcb5c3839d2f..6445d179ac15 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -47,7 +47,8 @@ static inline void tlbiel_all_lpid(bool radix)
=20
=20
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
-static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
+static inline void flush_pmd_tlb_range(struct mmu_gather *tlb,
+				       struct vm_area_struct *vma,
 				       unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s6=
4/pgtable.c
index 2bf7e1b4fd82..0a9c7ad7ee81 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -106,9 +106,15 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, un=
signed long address,
 		     pmd_t *pmdp)
 {
 	unsigned long old_pmd;
+	struct mmu_gather tlb;
+	unsigned long tlb_start =3D address;
+	unsigned long tlb_end =3D address + HPAGE_PMD_SIZE;
=20
 	old_pmd =3D pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESEN=
T, _PAGE_INVALID);
-	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+	tlb.cleared_pmds =3D 1;
+	flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.=
h
index e2e2bef07dd2..32d4661e5a56 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1160,10 +1160,10 @@ static inline int pmd_free_pte_page(pmd_t *pmd, u=
nsigned long addr)
  * invalidate the entire TLB which is not desitable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
-#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
+#define flush_pmd_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, ad=
dr, end)
 #define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
 #else
-#define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
+#define flush_pmd_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
 #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
 #endif
 #endif
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 3d7c01e76efc..96c9cf77bfb5 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -109,8 +109,14 @@ int pmdp_set_access_flags(struct vm_area_struct *vma=
,
 	int changed =3D !pmd_same(*pmdp, entry);
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	if (changed) {
+		struct mmu_gather tlb;
+		unsigned long tlb_start =3D address;
+		unsigned long tlb_end =3D address + HPAGE_PMD_SIZE;
 		set_pmd_at(vma->vm_mm, address, pmdp, entry);
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+		tlb.cleared_pmds =3D 1;
+		flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
+		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	}
 	return changed;
 }
@@ -123,8 +129,15 @@ int pmdp_clear_flush_young(struct vm_area_struct *vm=
a,
 	int young;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	young =3D pmdp_test_and_clear_young(vma, address, pmdp);
-	if (young)
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	if (young) {
+		struct mmu_gather tlb;
+		unsigned long tlb_start =3D address;
+		unsigned long tlb_end =3D address + HPAGE_PMD_SIZE;
+		tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+		tlb.cleared_pmds =3D 1;
+		flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
+		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	}
 	return young;
 }
 #endif
@@ -134,11 +147,17 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *=
vma, unsigned long address,
 			    pmd_t *pmdp)
 {
 	pmd_t pmd;
+	struct mmu_gather tlb;
+	unsigned long tlb_start =3D address;
+	unsigned long tlb_end =3D address + HPAGE_PMD_SIZE;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
 			   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
 	pmd =3D pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
-	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+	tlb.cleared_pmds =3D 1;
+	flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	return pmd;
 }
=20
@@ -195,7 +214,13 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, un=
signed long address,
 		     pmd_t *pmdp)
 {
 	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mknotpresent(*pmdp=
));
-	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	struct mmu_gather tlb;
+	unsigned long tlb_start =3D address;
+	unsigned long tlb_end =3D address + HPAGE_PMD_SIZE;
+	tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+	tlb.cleared_pmds =3D 1;
+	flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	return old;
 }
 #endif
--=20
2.19.1
