Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:37182 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfJKWrL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 18:47:11 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
Date: Fri, 11 Oct 2019 15:38:18 -0700
Message-ID: <20191011223818.7238-1-vgupta@synopsys.com>
In-Reply-To: <20191011121951.nxna6hruuskvdxod@box>
References: <20191011121951.nxna6hruuskvdxod@box>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191011223818.PSSyOwpIvbonxoObtqRhjgV4KGOOzusRPmeyid49Owc@z>

This is inine with similar patches for nopud [1] and nop4d [2] cases.

  However I'm not really sure I understand clearly how the nopmd code is
  supposed to work (for a 2 tier paging system) - hence the RFC.
  Consider free_pmd_range() simplified/annotated below

  free_pmd_range
  ...
	pmd = pmd_offset(pud, addr);
	do {
		next = pmd_addr_end(addr, end);
		if (pmd_none_or_clear_bad(pmd)) => *pmd_bad()/pmd_clear_bad() [a]*
			continue;
		free_pte_range(tlb, pmd, addr);
	} while (pmd++, addr = next, addr != end);
   ...
	*pmd_free_tlb(tlb, pmd, start); => [b]*

   For ARC/nopmd case [a] is actually checking pgd and consequently
   pmd_clear_bad() can't be stubbed out for PMD_FOLDED case. However it seems
   case [b] can be stubbed out (hence this patch) along same lines as [1] and [2]

| bloat-o-meter2 vmlinux-E-elide-p?d_clear_bad vmlinux-F-elide-pmd_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-112 (-112)
| function                                     old     new   delta
| free_pgd_range                               422     310    -112
| Total: Before=4137002, After=4136890, chg -1.000000%

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006266.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006265.html

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/tlb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f3dad87f4ecc..a1edad7d4170 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -574,6 +574,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	} while (0)
 #endif
 
+#ifndef __PAGETABLE_PMD_FOLDED
 #ifndef pmd_free_tlb
 #define pmd_free_tlb(tlb, pmdp, address)			\
 	do {							\
@@ -583,6 +584,9 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__pmd_free_tlb(tlb, pmdp, address);		\
 	} while (0)
 #endif
+#else
+#define pmd_free_tlb(tlb, pmdp, address)        do { } while (0)
+#endif
 
 #ifndef __PAGETABLE_PUD_FOLDED
 #ifndef pud_free_tlb
-- 
2.20.1
