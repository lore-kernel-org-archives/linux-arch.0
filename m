From: David Miller <davem@davemloft.net>
Subject: [PATCH 2/4] sparc64: Use RCU page table freeing.
Date: Thu, 08 Apr 2010 18:00:08 -0700 (PDT)
Message-ID: <20100408.180008.180206930.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: a.p.zijlstra@chello.nl
Cc: aarcange@redhat.com, avi@redhat.com, tglx@linutronix.de, riel@redhat.com, mingo@elte.hu, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, hugh.dickins@tiscali.co.uk, mel@csn.ul.ie, npiggin@suse.de
List-Id: linux-arch.vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgalloc_64.h |   49 +++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index cb4867d..f2df91e 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -76,7 +76,52 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 
 #define check_pgt_cache()	do { } while (0)
 
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
+static inline void pgtable_free(void *table, bool is_page)
+{
+	if (is_page)
+		free_page((unsigned long)table);
+	else
+		kmem_cache_free(pgtable_cache, table);
+}
+
+#ifdef CONFIG_SMP
+#define HAVE_ARCH_RCU_TABLE_FREE
+
+struct mmu_gather;
+extern void tlb_remove_table(struct mmu_gather *, void *);
+
+static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, bool is_page)
+{
+	unsigned long pgf = (unsigned long)table;
+	if (is_page)
+		pgf |= 0x1UL;
+	tlb_remove_table(tlb, (void *)pgf);
+}
+
+static inline void __tlb_remove_table(void *_table)
+{
+	void *table = (void *)((unsigned long)_table & ~0x1UL);
+	bool is_page = false;
+
+	if ((unsigned long)_table & 0x1UL)
+		is_page = true;
+	pgtable_free(table, is_page);
+}
+#else /* CONFIG_SMP */
+static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, bool is_page)
+{
+	pgtable_free(table, is_page);
+}
+#endif /* !CONFIG_SMP */
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *ptepage,
+				  unsigned long address)
+{
+	pgtable_page_dtor(ptepage);
+	pgtable_free_tlb(tlb, page_address(ptepage), true);
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)		      \
+	pgtable_free_tlb(tlb, pmd, false)
 
 #endif /* _SPARC64_PGALLOC_H */
-- 
1.6.6.1
