From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/3] HIGHMEM support for ARC
Date: Wed, 28 Oct 2015 16:53:10 +0530
Message-ID: <1446031393-2312-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>, Joonsoo Kim <js1304@gmail.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infraded.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This series adds highmem suppport for ARC. It adds the kmap atomic API and some
leg work for future patch for PAE40.

Please Review.

Thx,
-Vineet

Vineet Gupta (3):
  ARC: mm: preps ahead of HIGHMEM support
  ARC: mm: HIGHMEM: kmap API implementation
  ARC: mm: HIGHMEM: switch to using phys_addr_t for physical addresses

 arch/arc/Kconfig                  |   7 ++
 arch/arc/include/asm/cacheflush.h |   8 +--
 arch/arc/include/asm/highmem.h    |  61 +++++++++++++++++
 arch/arc/include/asm/kmap_types.h |  18 +++++
 arch/arc/include/asm/pgtable.h    |   9 +--
 arch/arc/include/asm/processor.h  |   7 +-
 arch/arc/mm/Makefile              |   1 +
 arch/arc/mm/cache.c               |  42 +++++++-----
 arch/arc/mm/fault.c               |  13 +++-
 arch/arc/mm/highmem.c             | 138 ++++++++++++++++++++++++++++++++++++++
 arch/arc/mm/init.c                |  20 +++++-
 arch/arc/mm/tlb.c                 |  10 +--
 12 files changed, 293 insertions(+), 41 deletions(-)
 create mode 100644 arch/arc/include/asm/highmem.h
 create mode 100644 arch/arc/include/asm/kmap_types.h
 create mode 100644 arch/arc/mm/highmem.c

-- 
1.9.1
