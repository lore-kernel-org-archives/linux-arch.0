From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 00/12]  Do not lose dirty bit on THP pages
Date: Wed, 13 Dec 2017 13:57:44 +0300
Message-ID: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

Vlastimil noted that pmdp_invalidate() is not atomic and we can lose
dirty and access bits if CPU sets them after pmdp dereference, but
before set_pmd_at().

The bug can lead to data loss, but the race window is tiny and I haven't
seen any reports that suggested that it happens in reality. So I don't
think it worth sending it to stable.

Unfortunately, there's no way to address the issue in a generic way. We need to
fix all architectures that support THP one-by-one.

All architectures that have THP supported have to provide atomic
pmdp_invalidate() that returns previous value.

If generic implementation of pmdp_invalidate() is used, architecture needs to
provide atomic pmdp_estabish().

pmdp_estabish() is not used out-side generic implementation of
pmdp_invalidate() so far, but I think this can change in the future.

Aneesh Kumar K.V (2):
  powerpc/mm: update pmdp_invalidate to return old pmd value
  mm/thp: Remove pmd_huge_split_prepare

Catalin Marinas (1):
  arm64: Provide pmdp_establish() helper

Kirill A. Shutemov (7):
  asm-generic: Provide generic_pmdp_establish()
  arc: Use generic_pmdp_establish as pmdp_establish
  arm/mm: Provide pmdp_establish() helper
  mips: Use generic_pmdp_establish as pmdp_establish
  x86/mm: Provide pmdp_establish() helper
  mm: Do not lose dirty and access bits in pmdp_invalidate()
  mm: Use updated pmdp_invalidate() interface to track dirty/accessed
    bits

Martin Schwidefsky (1):
  s390/mm: Modify pmdp_invalidate to return old value.

Nitin Gupta (1):
  sparc64: Update pmdp_invalidate() to return old pmd value

 arch/arc/include/asm/hugepage.h               |  3 +
 arch/arm/include/asm/pgtable-3level.h         |  3 +
 arch/arm64/include/asm/pgtable.h              |  7 +++
 arch/mips/include/asm/pgtable.h               |  3 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 -
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 13 +----
 arch/powerpc/include/asm/book3s/64/radix.h    |  6 --
 arch/powerpc/mm/pgtable-book3s64.c            |  7 ++-
 arch/powerpc/mm/pgtable-hash64.c              | 22 -------
 arch/s390/include/asm/pgtable.h               |  4 +-
 arch/sparc/include/asm/pgtable_64.h           |  2 +-
 arch/sparc/mm/tlb.c                           | 23 ++++++--
 arch/x86/include/asm/pgtable-3level.h         | 37 +++++++++++-
 arch/x86/include/asm/pgtable.h                | 15 +++++
 fs/proc/task_mmu.c                            |  8 +--
 include/asm-generic/pgtable.h                 | 25 +++++---
 mm/huge_memory.c                              | 83 ++++++++++++---------------
 mm/pgtable-generic.c                          |  6 +-
 19 files changed, 156 insertions(+), 115 deletions(-)

-- 
2.15.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
