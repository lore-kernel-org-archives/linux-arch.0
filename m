From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/8] xtensa: highmem support on cores with aliasing cache
Date: Tue, 22 Jul 2014 23:01:05 +0400
Message-ID: <1406055673-10100-1-git-send-email-jcmvbkbc__14766.828568145$1406055863$gmane$org@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, David Rientjes <rientjes@google.com>
List-Id: linux-arch.vger.kernel.org

Hi,

this series implements highmem support on xtensa cores with aliasing cache.
It does so by making sure that high memory pages are always mapped at
virtual addresses with color that match color of their physical address.

This involves changing the generic kmap code to make it aware of cache
coloring. This part with corresponding arch changes is cc'd linux-mm,
linux-arch and linux-mips.

The whole series can also be found at:
git://github.com/jcmvbkbc/linux-xtensa.git xtensa-highmem-ca

Leonid Yegoshin (1):
  mm/highmem: make kmap cache coloring aware

Max Filippov (7):
  xtensa: make fixmap region addressing grow with index
  xtensa: allow fixmap and kmap span more than one page table
  xtensa: fix TLBTEMP_BASE_2 region handling in fast_second_level_miss
  xtensa: implement clear_user_highpage and copy_user_highpage
  xtensa: support aliasing cache in k[un]map_atomic
  xtensa: support aliasing cache in kmap
  xtensa: support highmem in aliasing cache flushing code

 arch/xtensa/include/asm/cacheflush.h |   2 +
 arch/xtensa/include/asm/fixmap.h     |  30 +++++++--
 arch/xtensa/include/asm/highmem.h    |  18 +++++-
 arch/xtensa/include/asm/page.h       |  14 ++++-
 arch/xtensa/include/asm/pgtable.h    |   7 ++-
 arch/xtensa/kernel/entry.S           |   2 +-
 arch/xtensa/mm/cache.c               |  77 ++++++++++++++++++++---
 arch/xtensa/mm/highmem.c             |  24 +++++---
 arch/xtensa/mm/misc.S                | 116 ++++++++++++++++-------------------
 arch/xtensa/mm/mmu.c                 |  38 +++++++-----
 mm/highmem.c                         |  19 +++++-
 11 files changed, 235 insertions(+), 112 deletions(-)

Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: David Rientjes <rientjes@google.com>
-- 
1.8.1.4
