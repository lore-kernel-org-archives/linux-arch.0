From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 08/11] alpha/tlb: Fix __p*_free_tlb()
Date: Fri, 17 Jul 2020 13:10:13 +0200
Message-ID: <20200717111349.825172312@infradead.org>
References: <20200717111005.024867618@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

Since Alpha has page based PMDs, no software walkers and IPI based TLB
invalidation, it can use the simple tlb_remove_page() based freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/tlb.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/alpha/include/asm/tlb.h
+++ b/arch/alpha/include/asm/tlb.h
@@ -4,7 +4,16 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, address)		pte_free((tlb)->mm, pte)
-#define __pmd_free_tlb(tlb, pmd, address)		pmd_free((tlb)->mm, pmd)
+extern void ___pte_free_tlb(struct mmu_gather *tlb, pte_t *pte);
+extern void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd);
+
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
+
+#define __pmd_free_tlb(tlb, pmd, address)	\
+	tlb_remove_table((tlb), virt_to_page(pmd))
  
 #endif
