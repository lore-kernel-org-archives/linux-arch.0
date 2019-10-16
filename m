Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:58622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406198AbfJPQYK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:10 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 0/5] elide extraneous generated code for folded p4d/pud/pmd
Date: Wed, 16 Oct 2019 09:23:55 -0700
Message-ID: <20191016162400.14796-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191016162355.BvZF9Eb4YbXvNZ4AgS3Ap9ycI7RnFemro5P5RSvgUMc@z>

Hi,

This series came out of seemingly benign excursion into understanding/removing
__ARCH_USE_5LEVEL_HACK from ARC port showing some extraneous code being
generated despite folded p4d/pud/pmd

| bloat-o-meter2 vmlinux-[AB]*
| add/remove: 0/0 grow/shrink: 3/0 up/down: 130/0 (130)
| function                                     old     new   delta
| free_pgd_range                               548     660    +112
| p4d_clear_bad                                  2      20     +18

The patches here address that

| bloat-o-meter2 vmlinux-[BF]*
| add/remove: 0/2 grow/shrink: 0/1 up/down: 0/-386 (-386)
| function                                     old     new   delta
| pud_clear_bad                                 20       -     -20
| p4d_clear_bad                                 20       -     -20
| free_pgd_range                               660     314    -346

The code savings are not a whole lot, but still worthwhile IMHO.

Please review, test and apply. It seems to survive my usual battery of
multibench, hakcbench etc.

Thx,
-Vineet

---
Changes since v2 [3]
 - No code changes: Fixed the silly typos and collected ACKs

Changes since v1 [1]
 - Per Linus Sugestion remvoed the extra ifdey'ery (hence not
   accumulating Kirill's ACks)
 - Added the RFC patch for pmd_free_tlb() after discussions [2]
 - Also throwing in the ARC patch which started this all (so we get the
   full context of patchset) - I'm ok if this goes via mm tree, should
   be non contentious and can drop this too if Andrew thinks otherwise

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006263.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006277.html
[3] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006307.html
---

Vineet Gupta (5):
  ARC: mm: remove __ARCH_USE_5LEVEL_HACK
  asm-generic/tlb: stub out pud_free_tlb() if nopud ...
  asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
  asm-generic/tlb: stub out pmd_free_tlb() if nopmd
  asm-generic/mm: stub out p{4,u}d_clear_bad() if
    __PAGETABLE_P{4,u}D_FOLDED

 arch/arc/include/asm/pgtable.h      |  1 -
 arch/arc/mm/fault.c                 | 10 ++++++++--
 arch/arc/mm/highmem.c               |  4 +++-
 include/asm-generic/4level-fixup.h  |  1 -
 include/asm-generic/5level-fixup.h  |  1 -
 include/asm-generic/pgtable-nop4d.h |  2 +-
 include/asm-generic/pgtable-nopmd.h |  2 +-
 include/asm-generic/pgtable-nopud.h |  2 +-
 include/asm-generic/pgtable.h       | 11 +++++++++++
 include/asm-generic/tlb.h           |  4 ----
 mm/pgtable-generic.c                |  9 +++++++++
 11 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.20.1
