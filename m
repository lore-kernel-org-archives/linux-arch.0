Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50508 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1729238AbgANKCd (ORCPT <rfc822;linux-arch@vger.kernel.org>); Tue,
 14 Jan 2020 05:02:33 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 0/9] Fixup page directory freeing
Date: Tue, 14 Jan 2020 15:31:36 +0530
Message-ID: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <20200114100136.tTF7OQx0W62x4zqxpe4tPl-ca0ozVbED0wzccEWoBNU@z>

This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
easy to backport these changes. Only the first 3 patches need to be backported to stable. 

The thing is, on anything SMP, freeing page directories should observe the
exact same order as normal page freeing:

 1) unhook page/directory
 2) TLB invalidate
 3) free page/directory

Without this, any concurrent page-table walk could end up with a Use-after-Free.
This is esp. trivial for anything that has software page-table walkers
(HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
(ie. caches page directories).

Even on UP this might give issues since mmu_gather is preemptible these days.
An interrupt or preempted task accessing user pages might stumble into the free
page if the hardware caches page directories.

This patch series fixup ppc64 and add generic MMU_GATHER changes to support the conversion of other architectures.
I haven't added patches w.r.t other architecture because they are yet to be acked.


Aneesh Kumar K.V (1):
  powerpc/mmu_gather: Enable RCU_TABLE_FREE even for !SMP case

Peter Zijlstra (8):
  mm/mmu_gather: Invalidate TLB correctly on batch allocation failure
    and flush
  asm-generic/tlb: Avoid potential double flush
  asm-gemeric/tlb: Remove stray function declarations
  asm-generic/tlb: Add missing CONFIG symbol
  asm-generic/tlb: Rename HAVE_RCU_TABLE_FREE
  asm-generic/tlb: Rename HAVE_MMU_GATHER_PAGE_SIZE
  asm-generic/tlb: Rename HAVE_MMU_GATHER_NO_GATHER
  asm-generic/tlb: Provide MMU_GATHER_TABLE_FREE

 arch/Kconfig                                 |  13 +-
 arch/arm/Kconfig                             |   2 +-
 arch/arm/include/asm/tlb.h                   |   4 -
 arch/arm64/Kconfig                           |   2 +-
 arch/powerpc/Kconfig                         |   5 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h |   8 --
 arch/powerpc/include/asm/book3s/64/pgalloc.h |   2 -
 arch/powerpc/include/asm/nohash/pgalloc.h    |   8 --
 arch/powerpc/include/asm/tlb.h               |  11 ++
 arch/powerpc/mm/book3s64/pgtable.c           |   7 -
 arch/s390/Kconfig                            |   4 +-
 arch/sparc/Kconfig                           |   3 +-
 arch/sparc/include/asm/tlb_64.h              |   9 ++
 arch/x86/Kconfig                             |   2 +-
 arch/x86/include/asm/tlb.h                   |   4 +-
 include/asm-generic/tlb.h                    | 120 ++++++++++-------
 mm/gup.c                                     |   2 +-
 mm/mmu_gather.c                              | 134 +++++++++++++------
 18 files changed, 207 insertions(+), 133 deletions(-)

-- 
2.24.1
