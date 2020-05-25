Return-Path: <SRS0=7Sat=7H=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v3 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Date: Mon, 25 May 2020 20:52:59 +0800
Message-ID: <20200525125300.794-6-yezhenyu2@huawei.com>
In-Reply-To: <20200525125300.794-1-yezhenyu2@huawei.com>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200525125259.WMWfrfxIpRlvALIU-j9hLUInp8CHgKbfh_zVYqZbIvU@z>

This patch provides flush_{pte|pmd|pud|p4d}_tlb_range() in generic
code, which are expressed through the mmu_gather APIs.  These
interface set tlb->cleared_* and finally call tlb_flush(), so we
can do the tlb invalidation according to the information in
struct mmu_gather.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 include/asm-generic/pgtable.h | 12 ++++++++++--
 mm/pgtable-generic.c          | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.=
h
index 329b8c8ca703..8c92122ded9b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1161,11 +1161,19 @@ static inline int pmd_free_pte_page(pmd_t *pmd, u=
nsigned long addr)
  * invalidate the entire TLB which is not desitable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
-#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
-#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
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
=20
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 3d7c01e76efc..3eff199d3507 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -101,6 +101,28 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, u=
nsigned long address,
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
=20
+#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+
+#define FLUSH_Pxx_TLB_RANGE(_pxx)					\
+void flush_##_pxx##_tlb_range(struct vm_area_struct *vma,		\
+			      unsigned long addr, unsigned long end)	\
+{									\
+		struct mmu_gather tlb;					\
+									\
+		tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);		\
+		tlb_start_vma(&tlb, vma);				\
+		tlb_flush_##_pxx##_range(&tlb, addr, end - addr);	\
+		tlb_end_vma(&tlb, vma);					\
+		tlb_finish_mmu(&tlb, addr, end);			\
+}
+
+FLUSH_Pxx_TLB_RANGE(pte)
+FLUSH_Pxx_TLB_RANGE(pmd)
+FLUSH_Pxx_TLB_RANGE(pud)
+FLUSH_Pxx_TLB_RANGE(p4d)
+
+#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */
+
 #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 int pmdp_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pmd_t *pmdp,
--=20
2.19.1
