Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34279 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbaIZOEH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Sep 2014 10:04:07 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so11628894wiv.11
        for <linux-arch@vger.kernel.org>; Fri, 26 Sep 2014 07:04:06 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH V4 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Date: Fri, 26 Sep 2014 15:03:47 +0100
Message-ID: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com, Steve Capper <steve.capper@linaro.org>
Message-ID: <20140926140347.2JcJfp7HQk9_9N1h0G2YQfQ2Yu7fPbuygzh5Qfdtn6k@z>

Hello,
This series implements general forms of get_user_pages_fast and
__get_user_pages_fast in core code and activates them for arm and arm64.

These are required for Transparent HugePages to function correctly, as
a futex on a THP tail will otherwise result in an infinite loop (due to
the core implementation of __get_user_pages_fast always returning 0).

Unfortunately, a futex on THP tail can be quite common for certain
workloads; thus THP is unreliable without a __get_user_pages_fast
implementation.

This series may also be beneficial for direct-IO heavy workloads and
certain KVM workloads.

I appreciate that the merge window is coming very soon, and am posting
this revision on the off-chance that it gets the nod for 3.18. (The changes
thus far have been minimal and the feedback I've got has been mainly
positive).

Changes since PATCH V3 are
(mainly addressing comments from Hugh Dickins):
 * Added pte_numa and pmd_numa calls.
 * Added comments to clarify what assumptions are being made by the
   implementation.
 * Cleaned up formatting for checkpatch.
 * As these changes are mainly cosmetic, I've retained the Tested-by
   and Reviewed-by tags.

Changes since PATCH V2 are:
 * spelt `PATCH' correctly in the subject prefix this time. :-(
 * Added acks, tested-bys and reviewed-bys.
 * Cleanup of patch #6 with pud_pte and pud_pmd helpers.
 * Switched config option from HAVE_RCU_GUP to HAVE_GENERIC_RCU_GUP.

Changes since PATCH V1 are:
 * Rebase to 3.17-rc1
 * Switched to kick_all_cpus_sync as suggested by Mark Rutland.

The main changes since RFC V5 are:
 * Rebased against 3.16-rc1.
 * pmd_present no longer tested for by gup_huge_pmd and gup_huge_pud,
   because the entry must be present for these leaf functions to be
   called. 
 * Rather than assume puds can be re-cast as pmds, a separate
   function pud_write is instead used by the core gup.
 * ARM activation logic changed, now it will only activate
   RCU_TABLE_FREE and RCU_GUP when running with LPAE.

The main changes since RFC V4 are:
 * corrected the arm64 logic so it now correctly rcu-frees page
   table backing pages.
 * rcu free logic relaxed for pre-ARMv7 ARM as we need an IPI to
   invalidate TLBs anyway.
 * rebased to 3.15-rc3 (some minor changes were needed to allow it to merge).
 * dropped Catalin's mmu_gather patch as that's been merged already.

This series has been tested with LTP mm tests and some custom futex tests
that exacerbate the futex on THP tail case; on both an Arndale board and
a Juno board. Also debug counters were temporarily employed to ensure that
the RCU_TABLE_FREE logic was behaving as expected.

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

 arch/arm/Kconfig                      |   5 +
 arch/arm/include/asm/pgtable-2level.h |   2 +
 arch/arm/include/asm/pgtable-3level.h |  15 ++
 arch/arm/include/asm/pgtable.h        |   6 +-
 arch/arm/include/asm/tlb.h            |  38 +++-
 arch/arm/mm/flush.c                   |  15 ++
 arch/arm64/Kconfig                    |   4 +
 arch/arm64/include/asm/pgtable.h      |  21 +-
 arch/arm64/include/asm/tlb.h          |  20 +-
 arch/arm64/mm/flush.c                 |  15 ++
 mm/Kconfig                            |   3 +
 mm/gup.c                              | 354 ++++++++++++++++++++++++++++++++++
 12 files changed, 488 insertions(+), 10 deletions(-)

-- 
1.9.3

