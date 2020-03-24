Return-Path: <SRS0=1/KV=5J=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v4 6/6] mm: Set VM_LEVEL flags in some tlb_flush functions
Date: Tue, 24 Mar 2020 21:45:34 +0800
Message-ID: <20200324134534.1570-7-yezhenyu2@huawei.com>
In-Reply-To: <20200324134534.1570-1-yezhenyu2@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200324134534.NXycQBk-G3Ldu3b3FLrpN_Yft4kbTic-NOK3JIvb4_Y@z>

Set VM_LEVEL flags in some tlb_flush functions.
The relevant functions are:

	tlb_flush in asm/tlb.h
	get_clear_flush and clear_flush in mm/hugetlbpage.c
	flush_pmd|pud_tlb_range in asm-generic/patable.h
	do_huge_pmd_numa_page and move_huge_pmd in mm/huge_memory.c

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlb.h  | 12 ++++++++++++
 arch/arm64/mm/hugetlbpage.c   |  4 ++--
 include/asm-generic/pgtable.h | 16 ++++++++++++++--
 mm/huge_memory.c              |  8 +++++++-
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index b76df828e6b7..77fe942b30b6 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -27,6 +27,18 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	bool last_level =3D !tlb->freed_tables;
 	unsigned long stride =3D tlb_get_unmap_size(tlb);
=20
+	/*
+	 * mm_gather tracked which levels of the page tables
+	 * have been cleared, we can use this info to set
+	 * vm->vm_flags.
+	 */
+	if (tlb->cleared_ptes)
+		vma.vm_flags |=3D VM_LEVEL_PTE;
+	else if (tlb->cleared_pmds)
+		vma.vm_flags |=3D VM_LEVEL_PMD;
+	else if (tlb->cleared_puds)
+		vma.vm_flags |=3D VM_LEVEL_PUD;
+
 	/*
 	 * If we're tearing down the address space then we only care about
 	 * invalidating the walk-cache, since the ASID allocator won't
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index bbeb6a5a6ba6..c35a1bd06bd0 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -140,7 +140,7 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 	}
=20
 	if (valid) {
-		struct vm_area_struct vma =3D TLB_FLUSH_VMA(mm, 0);
+		struct vm_area_struct vma =3D TLB_FLUSH_VMA(mm, VM_LEVEL_PTE);
 		flush_tlb_range(&vma, saddr, addr);
 	}
 	return orig_pte;
@@ -161,7 +161,7 @@ static void clear_flush(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	struct vm_area_struct vma =3D TLB_FLUSH_VMA(mm, 0);
+	struct vm_area_struct vma =3D TLB_FLUSH_VMA(mm, VM_LEVEL_PTE);
 	unsigned long i, saddr =3D addr;
=20
 	for (i =3D 0; i < ncontig; i++, addr +=3D pgsize, ptep++)
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.=
h
index e2e2bef07dd2..391e704faf7a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1160,8 +1160,20 @@ static inline int pmd_free_pte_page(pmd_t *pmd, un=
signed long addr)
  * invalidate the entire TLB which is not desitable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
-#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
-#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
+#define flush_pmd_tlb_range(vma, addr, end)				\
+	do {								\
+		vma->vm_flags &=3D ~(VM_LEVEL_PUD | VM_LEVEL_PTE);	\
+		vma->vm_flags |=3D VM_LEVEL_PMD;				\
+		flush_tlb_range(vma, addr, end);			\
+	} while (0)
+
+#define flush_pud_tlb_range(vma, addr, end)				\
+	do {								\
+		vma->vm_flags &=3D ~(VM_LEVEL_PMD | VM_LEVEL_PTE);	\
+		vma->vm_flags |=3D VM_LEVEL_PUD;				\
+		flush_tlb_range(vma, addr, end);			\
+	} while (0)
+
 #else
 #define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
 #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 24ad53b4dfc0..9a78b8d865f0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1646,6 +1646,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf, pmd_t pmd)
 	 * mapping or not. Hence use the tlb range variant
 	 */
 	if (mm_tlb_flush_pending(vma->vm_mm)) {
+		vma->vm_flags &=3D ~(VM_LEVEL_PUD | VM_LEVEL_PTE);
+		vma->vm_flags |=3D VM_LEVEL_PMD;
 		flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
 		/*
 		 * change_huge_pmd() released the pmd lock before
@@ -1917,8 +1919,12 @@ bool move_huge_pmd(struct vm_area_struct *vma, uns=
igned long old_addr,
 		}
 		pmd =3D move_soft_dirty_pmd(pmd);
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
-		if (force_flush)
+		if (force_flush) {
+			vma->vm_flags &=3D ~(VM_LEVEL_PUD | VM_LEVEL_PTE);
+			vma->vm_flags |=3D VM_LEVEL_PMD;
 			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+		}
+
 		if (new_ptl !=3D old_ptl)
 			spin_unlock(new_ptl);
 		spin_unlock(old_ptl);
--=20
2.19.1
