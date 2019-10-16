Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58520 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732453AbfJPQYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:07 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 4/5] asm-generic/tlb: stub out pmd_free_tlb() if nopmd
Date: Wed, 16 Oct 2019 09:23:59 -0700
Message-ID: <20191016162400.14796-5-vgupta@synopsys.com>
In-Reply-To: <20191016162400.14796-1-vgupta@synopsys.com>
References: <20191016162400.14796-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191016162359.uGelfF3tpQZRMwCszsW2u6i_eGPIouMXlzhucXSNXZc@z>

This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat.
With this patch we see the following code reduction.

| bloat-o-meter2 vmlinux-E-elide-p?d_clear_bad vmlinux-F-elide-pmd_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-112 (-112)
| function                                     old     new   delta
| free_pgd_range                               422     310    -112
| Total: Before=4137042, After=4136930, chg -1.000000%

Note that pmd folding can be tricky: In 2-level setup (where pmd is
conceptually folded) most pmd routines are valid and refer to upper levels.
In this patch we can, but see next patch for example where we can't

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/pgtable-nopmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index b85b8271a73d..0d9b28cba16d 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 }
-#define __pmd_free_tlb(tlb, x, a)		do { } while (0)
+#define pmd_free_tlb(tlb, x, a)		do { } while (0)
 
 #undef  pmd_addr_end
 #define pmd_addr_end(addr, end)			(end)
-- 
2.20.1
