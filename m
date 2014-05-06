Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41674 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaEFPaZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2014 11:30:25 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so2979607wgg.1
        for <linux-arch@vger.kernel.org>; Tue, 06 May 2014 08:30:24 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [RFC PATCH V5 0/6] get_user_pages_fast for ARM and ARM64
Date: Tue,  6 May 2014 16:30:03 +0100
Message-ID: <1399390209-1756-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, Steve Capper <steve.capper@linaro.org>
Message-ID: <20140506153003.2GCE-6KaxdF_P53s_LCD3mLWRAQAbCJbZSV-LJ5YZJs@z>

Hello,
This RFC series implements get_user_pages_fast and __get_user_pages_fast.
These are required for Transparent HugePages to function correctly, as
a futex on a THP tail will otherwise result in an infinite loop (due to
the core implementation of __get_user_pages_fast always returning 0).
This series may also be beneficial for direct-IO heavy workloads and
certain KVM workloads.

The main changes since RFC V4 are:
 * corrected the arm64 logic so it now correctly rcu-frees page
   table backing pages.
 * rcu free logic relaxed for pre-ARMv7 ARM as we need an IPI to
   invalidate TLBs anyway.
 * rebased to 3.15-rc3 (some minor changes were needed to allow it to merge).
 * dropped Catalin's mmu_gather patch as that's been merged already.

I would really appreciate any comments (especially on the validity or
otherwise of the core fast_gup implementation) and/or testers.

Cheers,
--
Steve



Steve Capper (6):
  mm: Introduce a general RCU get_user_pages_fast.
  arm: mm: Introduce special ptes for LPAE
  arm: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm: mm: Enable RCU fast_gup
  arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm64: mm: Enable RCU fast_gup

 arch/arm/Kconfig                      |   4 +
 arch/arm/include/asm/pgtable-2level.h |   2 +
 arch/arm/include/asm/pgtable-3level.h |  14 ++
 arch/arm/include/asm/pgtable.h        |   6 +-
 arch/arm/include/asm/tlb.h            |  38 ++++-
 arch/arm/mm/flush.c                   |  19 +++
 arch/arm64/Kconfig                    |   4 +
 arch/arm64/include/asm/pgtable.h      |   8 +-
 arch/arm64/include/asm/tlb.h          |  18 ++-
 arch/arm64/mm/flush.c                 |  19 +++
 mm/Kconfig                            |   3 +
 mm/Makefile                           |   1 +
 mm/gup.c                              | 297 ++++++++++++++++++++++++++++++++++
 13 files changed, 424 insertions(+), 9 deletions(-)
 create mode 100644 mm/gup.c

-- 
1.8.1.4

