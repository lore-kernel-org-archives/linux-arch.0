From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [RFC PATCH 0/2] Clarify huge_pte_offset() semantics
Date: Mon, 24 Jul 2017 18:33:16 +0100
Message-ID: <20170724173318.966-1-punit.agrawal@arm.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

Hi,

The generic implementation of huge_pte_offset() has inconsistent
behaviour when looking up hugepage PUDs vs PMDs entries that are not
present (returning NULL vs pte_t*).

Similarly, it returns NULL when encountering swap entries although all
the callers have special checks to properly deal with swap entries.

Without clear semantics, it is difficult to determine what is the
expected behaviour of huge_pte_offset() without going through all the
scenarios where it used.

I faced this recently when updating the arm64 implementation of
huge_pte_offset() to handle swap entries (related to enabling poisoned
memeory)[0]. And will come across again when I update it for
contiguous hugepage support now that core changes have been merged.

To address these issues, this small series -

* makes huge_pte_offset() consistent between PUD and PMDs
* adds support for returning swap entries
* and most importantly, documents the expected behaviour of
  huge_pte_offset()

All feedback welcome.

Thanks,
Punit

[0]

Punit Agrawal (2):
  mm/hugetlb: Make huge_pte_offset() consistent between PUD and PMD
    entries
  mm/hugetlb: Support swap entries in huge_pte_offset()

 mm/hugetlb.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

-- 
2.11.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
