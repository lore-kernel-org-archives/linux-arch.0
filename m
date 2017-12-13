From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 04/12] arm64: Provide pmdp_establish() helper
Date: Wed, 13 Dec 2017 13:57:48 +0300
Message-ID: <20171213105756.69879-5-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

We need an atomic way to setup pmd page table entry, avoiding races with
CPU setting dirty/accessed bits. This is required to implement
pmdp_invalidate() that doesn't lose these bits.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/arm64/include/asm/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 149d05fb9421..116d610a2620 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -676,6 +676,13 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 {
 	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
 }
+
+#define pmdp_establish pmdp_establish
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
+}
 #endif
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-- 
2.15.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
