Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:54416 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057Ab3EWRIJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2013 13:08:09 -0400
Received: by mail-we0-f170.google.com with SMTP id u59so1698458wes.29
        for <linux-arch@vger.kernel.org>; Thu, 23 May 2013 10:08:08 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH 00/11] HugeTLB and THP support for ARM64.
Date: Thu, 23 May 2013 18:07:47 +0100
Message-ID: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, patches@linaro.org, Steve Capper <steve.capper@linaro.org>
Message-ID: <20130523170747.BayinwnEbIAe4xMpp5HEo41yJ7fZX6ys2uKfqXYVFUw@z>

This series brings huge pages and transparent huge pages to ARM64.
The functionality is very similar to x86, and a lot of code that can
be used by both ARM64 and x86 is brought into mm to avoid the need
for code duplication.

One notable difference from x86 is that ARM64 supports normal pages
that are 64KB. When 64KB pages are enabled, huge page and
transparent huge pages are 512MB only, otherwise the sizes match
x86.

This series applies to 3.10-rc2.

I've tested this under the ARMv8 Fast model and the x86 code has
been tested in a KVM guest. libhugetlbfs was used for testing under
both architectures.

Changelog:
Patch:
   * pud_large usage replaced with pud_huge for general hugetlb
     code imported into mm.
   * comments tidied up for bit swap of PTE_FILE, PTE_PROT_NONE.

RFC v2:
   * PROT_NONE support added for HugeTLB and THP.
   * pmd_modify implementation fixed.
   * Superfluous huge dcache flushing code removed.
   * Simplified (and corrected) MAX_ORDER raise for THP && 64KB
     pages.
   * The MAX_ORDER check in huge_mm.h has been corrected.

---

Steve Capper (11):
  mm: hugetlb: Copy huge_pmd_share from x86 to mm.
  x86: mm: Remove x86 version of huge_pmd_share.
  mm: hugetlb: Copy general hugetlb code from x86 to mm.
  x86: mm: Remove general hugetlb code from x86.
  mm: thp: Correct the HPAGE_PMD_ORDER check.
  ARM64: mm: Restore memblock limit when map_mem finished.
  ARM64: mm: Make PAGE_NONE pages read only and no-execute.
  ARM64: mm: Swap PTE_FILE and PTE_PROT_NONE bits.
  ARM64: mm: HugeTLB support.
  ARM64: mm: Raise MAX_ORDER for 64KB pages and THP.
  ARM64: mm: THP support.

 arch/arm64/Kconfig                     |  17 +++
 arch/arm64/include/asm/hugetlb.h       | 117 ++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  12 ++
 arch/arm64/include/asm/pgtable.h       |  84 +++++++++++--
 arch/arm64/include/asm/tlb.h           |   6 +
 arch/arm64/include/asm/tlbflush.h      |   2 +
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/fault.c                  |  19 +--
 arch/arm64/mm/hugetlbpage.c            |  70 +++++++++++
 arch/arm64/mm/mmu.c                    |  19 ++-
 arch/x86/Kconfig                       |   6 +
 arch/x86/mm/hugetlbpage.c              | 187 ----------------------------
 include/linux/huge_mm.h                |   2 +-
 include/linux/hugetlb.h                |   4 +
 mm/hugetlb.c                           | 219 +++++++++++++++++++++++++++++++--
 15 files changed, 537 insertions(+), 228 deletions(-)
 create mode 100644 arch/arm64/include/asm/hugetlb.h
 create mode 100644 arch/arm64/mm/hugetlbpage.c

-- 
1.8.1.4

