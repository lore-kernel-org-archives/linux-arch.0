From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/3] Minor changes to common hugetlb code for ARM
Date: Tue, 11 Sep 2012 17:47:13 +0100
Message-ID: <1347382036-18455-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, mhocko@suse.cz, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hello,

A few changes are required to common hugetlb code before the ARM support
can be merged. I posted the main one previously, which has been picked up
by akpm:

  http://marc.info/?l=linux-mm&m=134573987631394&w=2

The remaining three patches (included here) are all fairly minor but do
affect other architectures.

All comments welcome,

Will

Catalin Marinas (2):
  mm: thp: Fix the pmd_clear() arguments in pmdp_get_and_clear()
  mm: thp: Fix the update_mmu_cache() last argument passing in
    mm/huge_memory.c

Steve Capper (1):
  mm: Introduce HAVE_ARCH_TRANSPARENT_HUGEPAGE

 arch/x86/Kconfig              |    4 ++++
 include/asm-generic/pgtable.h |    2 +-
 mm/Kconfig                    |    2 +-
 mm/huge_memory.c              |    6 +++---
 4 files changed, 9 insertions(+), 5 deletions(-)

-- 
1.7.4.1
