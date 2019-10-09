Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:55028 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731589AbfJIW1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 18:27:08 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/3] eldie generated code for folded p4d/pud
Date: Wed,  9 Oct 2019 15:26:55 -0700
Message-ID: <20191009222658.961-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191009222655.EnRSZHl1QsDsgPxOfKnnonxeKd8toIgfwMDMSEYUrDs@z>

Hi,

This series elides extraneous generate code for folded p4d/pud.
This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
The code saving are not a while lot, but still worthwhile IMHO.

bloat-o-meter2 vmlinux-A-baseline vmlinux-E-elide-p?d_clear_bad
add/remove: 0/2 grow/shrink: 0/1 up/down: 0/-146 (-146)
function                                     old     new   delta
p4d_clear_bad                                  2       -      -2
pud_clear_bad                                 20       -     -20
free_pgd_range                               546     422    -124
Total: Before=4137148, After=4137002, chg -1.000000%

Thx,
-Vineet

Vineet Gupta (3):
  asm-generic/tlb: stub out pud_free_tlb() if __PAGETABLE_PUD_FOLDED ...
  asm-generic/tlb: stub out p4d_free_tlb() if __PAGETABLE_P4D_FOLDED ...
  asm-generic/mm: stub out p{4,d}d_clear_bad() if
    __PAGETABLE_P{4,u}D_FOLDED

 include/asm-generic/4level-fixup.h |  2 --
 include/asm-generic/5level-fixup.h |  2 --
 include/asm-generic/pgtable.h      | 11 +++++++++++
 include/asm-generic/tlb.h          |  8 ++++++--
 mm/pgtable-generic.c               |  4 ++++
 5 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.20.1
