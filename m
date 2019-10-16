Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58502 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727138AbfJPQYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:07 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 1/5] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Date: Wed, 16 Oct 2019 09:23:56 -0700
Message-ID: <20191016162400.14796-2-vgupta@synopsys.com>
In-Reply-To: <20191016162400.14796-1-vgupta@synopsys.com>
References: <20191016162400.14796-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191016162356.mRhuG0xKGn4dMHB18Yzr_NODnFLuNrnJdPFa-3_ENoI@z>

With paging code made 5-level compliant, this is no longer needed.
ARC has software page walker with 2 lookup levels (pgd -> pte)

This was expected to be non functional change but ended with slight
code bloat due to needless inclusions of p*d_free_tlb() macros which
will be addressed in further patches.

| bloat-o-meter2 vmlinux-[AB]*
| add/remove: 0/0 grow/shrink: 2/0 up/down: 128/0 (128)
| function                                     old     new   delta
| free_pgd_range                               546     656    +110
| p4d_clear_bad                                  2      20     +18
| Total: Before=4137148, After=4137276, chg 0.000000%

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/pgtable.h |  1 -
 arch/arc/mm/fault.c            | 10 ++++++++--
 arch/arc/mm/highmem.c          |  4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 7addd0301c51..b917b596f7fb 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -33,7 +33,6 @@
 #define _ASM_ARC_PGTABLE_H
 
 #include <linux/bits.h>
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
 #include <asm/mmu.h>	/* to propagate CONFIG_ARC_MMU_VER <n> */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 3861543b66a0..fb86bc3e9b35 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -30,6 +30,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	 * with the 'reference' page table.
 	 */
 	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
 
@@ -39,8 +40,13 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pgd_present(*pgd_k))
 		goto bad_area;
 
-	pud = pud_offset(pgd, address);
-	pud_k = pud_offset(pgd_k, address);
+	p4d = p4d_offset(pgd, address);
+	p4d_k = p4d_offset(pgd_k, address);
+	if (!p4d_present(*p4d_k))
+		goto bad_area;
+
+	pud = pud_offset(p4d, address);
+	pud_k = pud_offset(p4d_k, address);
 	if (!pud_present(*pud_k))
 		goto bad_area;
 
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index a4856bfaedf3..fc8849e4f72e 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -111,12 +111,14 @@ EXPORT_SYMBOL(__kunmap_atomic);
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
 	pgd_t *pgd_k;
+	p4d_t *p4d_k;
 	pud_t *pud_k;
 	pmd_t *pmd_k;
 	pte_t *pte_k;
 
 	pgd_k = pgd_offset_k(kvaddr);
-	pud_k = pud_offset(pgd_k, kvaddr);
+	p4d_k = p4d_offset(pgd_k, kvaddr);
+	pud_k = pud_offset(p4d_k, kvaddr);
 	pmd_k = pmd_offset(pud_k, kvaddr);
 
 	pte_k = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-- 
2.20.1
