Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44838 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeFLHQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jun 2018 03:16:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so11010108pgd.11
        for <linux-arch@vger.kernel.org>; Tue, 12 Jun 2018 00:16:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/3] couple of TLB flush optimisations
Date: Tue, 12 Jun 2018 17:16:18 +1000
Message-ID: <20180612071621.26775-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180612071618.IjcN8yvPmje7YPJgaNOxGP1x4CS3Prrosko8vk5H9fE@z>

I'm just looking around TLB flushing and noticed a few issues with
the core code. The first one seems pretty straightforward, unless I
missed something, but the TLB flush pattern after the revert seems
okay.

The second one might be a bit more interesting for other architectures
and the big comment in include/asm-generic/tlb.h and linked mail from
Linus gives some good context.

I suspect mmu notifiers should use this precise TLB range too, because
I don't see how they could care about the page table structure under
the mapping. Although I only use it in powerpc so far.

Comments?

Thanks,
Nick

Nicholas Piggin (3):
  Revert "mm: always flush VMA ranges affected by zap_page_range"
  mm: mmu_gather track of invalidated TLB ranges explicitly for more
    precise flushing
  powerpc/64s/radix: optimise TLB flush with precise TLB ranges in
    mmu_gather

 arch/powerpc/mm/tlb-radix.c |  7 +++++--
 include/asm-generic/tlb.h   | 27 +++++++++++++++++++++++++--
 mm/memory.c                 | 18 ++++--------------
 3 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.17.0
