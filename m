Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33534 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaC1PBl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2014 11:01:41 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so843834wiv.16
        for <linux-arch@vger.kernel.org>; Fri, 28 Mar 2014 08:01:39 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [RFC PATCH V4 0/7] get_user_pages_fast for ARM and ARM64
Date: Fri, 28 Mar 2014 15:01:25 +0000
Message-ID: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: peterz@infradead.org, gary.robertson@linaro.org, anders.roxell@linaro.org, akpm@linux-foundation.org, Steve Capper <steve.capper@linaro.org>
Message-ID: <20140328150125.XsXV22mTc0lm3AQ4DKGcc1kbJBhrOMBh3tyMuFQf8eU@z>

Hello,
This RFC series implements get_user_pages_fast and __get_user_pages_fast.
These are required for Transparent HugePages to function correctly, as
a futex on a THP tail will otherwise result in an infinite loop (due to
the core implementation of __get_user_pages_fast always returning 0).
This series may also be beneficial for direct-IO heavy workloads and
certain KVM workloads.

The main changes since RFC V3 are:
 * fast_gup now generalised and moved to core code.
 * pte_special logic now extended to reduce unnecessary icache syncs.
 * dropped the pte_accessible logic in fast_gup as it is unnecessary.

I would really appreciate any comments (especially on the validity or
otherwise of the core fast_gup implementation) and/or testers.

Cheers,
--
Steve

Catalin Marinas (1):
  arm64: Convert asm/tlb.h to generic mmu_gather

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
 arch/arm64/include/asm/pgtable.h      |   4 +
 arch/arm64/include/asm/tlb.h          | 140 +++-------------
 arch/arm64/mm/flush.c                 |  19 +++
 mm/Kconfig                            |   3 +
 mm/Makefile                           |   1 +
 mm/gup.c                              | 297 ++++++++++++++++++++++++++++++++++
 13 files changed, 431 insertions(+), 120 deletions(-)
 create mode 100644 mm/gup.c

-- 
1.8.1.4

