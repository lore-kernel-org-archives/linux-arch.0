From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/5] mm: dirty/accessed pte optimisations
Date: Tue, 16 Oct 2018 23:13:38 +1000
Message-ID: <20181016131343.20556-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ley Foon Tan <ley.foon.tan@intel.com>
List-Id: linux-arch.vger.kernel.org

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
