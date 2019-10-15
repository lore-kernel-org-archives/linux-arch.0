Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:39750 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389572AbfJOTTb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 15:19:31 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 3/5] asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
Date: Tue, 15 Oct 2019 12:19:24 -0700
Message-ID: <20191015191926.9281-4-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-1-vgupta@synopsys.com>
References: <20191015191926.9281-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191015191924.emTHjXl4bqSPE1opHoPg9DFahQA9ryn_LERjUZNdj-c@z>

... independent of __ARCH_HAS_5LEVEL_HACK

This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
from this routine not required in a 2-level paging setup

| bloat-o-meter2 vmlinux-C-elide-pud_free_tlb vmlinux-D-elide-p4d_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-104 (-104)
| function                                     old     new   delta
| free_pgd_range                               552     422    -130
| Total: Before=4137172, After=4137042, chg -1.000000%

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/5level-fixup.h  | 1 -
 include/asm-generic/pgtable-nop4d.h | 2 +-
 include/asm-generic/tlb.h           | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index f6947da70d71..4c74b1c1d13b 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -51,7 +51,6 @@ static inline int p4d_present(p4d_t p4d)
 #undef p4d_free_tlb
 #define p4d_free_tlb(tlb, x, addr)	do { } while (0)
 #define p4d_free(mm, x)			do { } while (0)
-#define __p4d_free_tlb(tlb, x, addr)	do { } while (0)
 
 #undef  p4d_addr_end
 #define p4d_addr_end(addr, end)		(end)
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index aebab905e6cd..ce2cbb3c380f 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -50,7 +50,7 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
  */
 #define p4d_alloc_one(mm, address)		NULL
 #define p4d_free(mm, x)				do { } while (0)
-#define __p4d_free_tlb(tlb, x, a)		do { } while (0)
+#define p4d_free_tlb(tlb, x, a)			do { } while (0)
 
 #undef  p4d_addr_end
 #define p4d_addr_end(addr, end)			(end)
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 5e0c2d01e656..05dddc17522b 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -594,7 +594,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	} while (0)
 #endif
 
-#ifndef __ARCH_HAS_5LEVEL_HACK
 #ifndef p4d_free_tlb
 #define p4d_free_tlb(tlb, pudp, address)			\
 	do {							\
@@ -603,7 +602,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__p4d_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
-#endif
 
 #endif /* CONFIG_MMU */
 
-- 
2.20.1
