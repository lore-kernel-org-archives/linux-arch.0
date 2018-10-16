Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32962 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVEX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Oct 2018 17:04:23 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/5] mm: dirty/accessed pte optimisations
Date: Tue, 16 Oct 2018 23:13:38 +1000
Message-ID: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ley Foon Tan <ley.foon.tan@intel.com>
Message-ID: <20181016131338.E9o9FUED1PBouny87SecdNvQBEZetXeiVA0dNFl_Oo8@z>

Since v1 I fixed the hang in nios2, split the fork patch into two
as Linus asked, and added hugetlb code for the "don't bother write
protecting already writeprotected" patch.

Please consider this for more cooking in -mm.

Thanks,
Nick

Nicholas Piggin (5):
  nios2: update_mmu_cache clear the old entry from the TLB
  mm/cow: don't bother write protecting already write-protected huge
    pages
  mm/cow: optimise pte accessed bit handling in fork
  mm/cow: optimise pte dirty bit handling in fork
  mm: optimise pte dirty/accessed bit setting by demand based pte
    insertion

 arch/nios2/mm/cacheflush.c |  2 ++
 mm/huge_memory.c           | 24 ++++++++++++++++--------
 mm/hugetlb.c               |  2 +-
 mm/memory.c                | 19 +++++++++++--------
 mm/vmscan.c                |  8 ++++++++
 5 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.18.0
