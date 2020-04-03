From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v1 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Date: Fri, 3 Apr 2020 17:00:47 +0800
Message-ID: <20200403090048.938-6-yezhenyu2@huawei.com>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403090048.938-1-yezhenyu2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

This patch provides flush_{pte|pmd|pud|p4d}_tlb_range() in generic
code, which are expressed through the mmu_gather APIs.  These
interface set tlb->cleared_* and finally call tlb_flush(), so we
can do the tlb invalidation according to the information in
struct mmu_gather.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 include/asm-generic/pgtable.h | 12 +++++++--
 mm/pgtable-generic.c          | 50 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index e2e2bef07dd2..2bedeee94131 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1160,11 +1160,19 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
  * invalidate the entire TLB which is not desitable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
-#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+extern void flush_pte_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
+extern void flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
+extern void flush_pud_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
+extern void flush_p4d_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
 #else
+#define flush_pte_tlb_range(vma, addr, end)	BUILD_BUG()
 #define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
 #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
+#define flush_p4d_tlb_range(vma, addr, end)	BUILD_BUG()
 #endif
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 3d7c01e76efc..0f5414a4a2ec 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -101,6 +101,56 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
+#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+void flush_pte_tlb_range(struct vm_area_struct *vma,
+			 unsigned long addr, unsigned long end)
+{
+	struct mmu_gather tlb;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
+	tlb_start_vma(&tlb, vma);
+	tlb_set_pte_range(&tlb, addr, end - addr);
+	tlb_end_vma(&tlb, vma);
+	tlb_finish_mmu(&tlb, addr, end);
+}
+
+void flush_pmd_tlb_range(struct vm_area_struct *vma,
+			 unsigned long addr, unsigned long end)
+{
+	struct mmu_gather tlb;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
+	tlb_start_vma(&tlb, vma);
+	tlb_set_pmd_range(&tlb, addr, end - addr);
+	tlb_end_vma(&tlb, vma);
+	tlb_finish_mmu(&tlb, addr, end);
+}
+
+void flush_pud_tlb_range(struct vm_area_struct *vma,
+			 unsigned long addr, unsigned long end)
+{
+	struct mmu_gather tlb;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
+	tlb_start_vma(&tlb, vma);
+	tlb_set_pud_range(&tlb, addr, end - addr);
+	tlb_end_vma(&tlb, vma);
+	tlb_finish_mmu(&tlb, addr, end);
+}
+
+void flush_p4d_tlb_range(struct vm_area_struct *vma,
+			 unsigned long addr, unsigned long end)
+{
+	struct mmu_gather tlb;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
+	tlb_start_vma(&tlb, vma);
+	tlb_set_p4d_range(&tlb, addr, end - addr);
+	tlb_end_vma(&tlb, vma);
+	tlb_finish_mmu(&tlb, addr, end);
+}
+#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */
+
 #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 int pmdp_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pmd_t *pmdp,
-- 
2.19.1
