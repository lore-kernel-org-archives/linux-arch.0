Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbeGYPSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2018 11:18:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so5411252pgv.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Jul 2018 07:06:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/4] mm: mmu_gather changes to support explicit paging
Date: Thu, 26 Jul 2018 00:06:37 +1000
Message-ID: <20180725140641.30372-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180725140637.sP4qkBjrHUB8-vejVZl9Je3fDqwoKoPlsbf7X8XalSc@z>

The first 3 patches in this series are some generic mm changes I
would like to make, including a possible fix which may(?) be needed
for ARM64. Other than the bugfix, these first 3 patches should not
change anything so hopefully they aren't too controversial.

The powerpc patch is also there for reference. 

Thanks,
Nick

Nicholas Piggin (4):
  mm: move tlb_table_flush to tlb_flush_mmu_free
  mm: mmu_notifier fix for tlb_end_vma
  mm: allow arch to have tlb_flush caled on an empty TLB range
  powerpc/64s/radix: optimise TLB flush with precise TLB ranges in
    mmu_gather

 arch/powerpc/include/asm/tlb.h | 34 +++++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb-radix.c    | 10 ++++++++++
 include/asm-generic/tlb.h      | 35 ++++++++++++++++++++++++++++++----
 mm/memory.c                    | 14 ++------------
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.17.0
