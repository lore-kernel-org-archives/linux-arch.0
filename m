Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:46091 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbaHUUmb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Aug 2014 16:42:31 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so9550358wgg.28
        for <linux-arch@vger.kernel.org>; Thu, 21 Aug 2014 13:42:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
Date: Thu, 21 Aug 2014 14:42:29 -0600
Message-ID: <CALdTtnuuZBNGR5Ti3PsN3BdA=FQ7ErYuyHMsiSp_5TD-U0n2Lg@mail.gmail.com>
Subject: Re: [PATH V2 0/6] RCU get_user_pages_fast and __get_user_pages_fast
From: Dann Frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will.deacon@arm.com>, gary.robertson@linaro.org, Christoffer Dall <christoffer.dall@linaro.org>, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, Mark Rutland <mark.rutland@arm.com>, mgorman@suse.de
Message-ID: <20140821204229.uJmHVUxmioOalrG9olF3rEdCycjAK3tdb-oomtTgdEs@z>

On Thu, Aug 21, 2014 at 9:43 AM, Steve Capper <steve.capper@linaro.org> wrote:
> Hello,
> This series implements general forms of get_user_pages_fast and
> __get_user_pages_fast and activates them for arm and arm64.
>
> These are required for Transparent HugePages to function correctly, as
> a futex on a THP tail will otherwise result in an infinite loop (due to
> the core implementation of __get_user_pages_fast always returning 0).
>
> Unfortunately, a futex on THP tail can be quite common for certain
> workloads; thus THP is unreliable without a __get_user_pages_fast
> implementation.
>
> This series may also be beneficial for direct-IO heavy workloads and
> certain KVM workloads.
>
> Changes since PATCH V1 are:
>  * Rebase to 3.17-rc1
>  * Switched to kick_all_cpus_sync as suggested by Mark Rutland.
>
> The main changes since RFC V5 are:
>  * Rebased against 3.16-rc1.
>  * pmd_present no longer tested for by gup_huge_pmd and gup_huge_pud,
>    because the entry must be present for these leaf functions to be
>    called.
>  * Rather than assume puds can be re-cast as pmds, a separate
>    function pud_write is instead used by the core gup.
>  * ARM activation logic changed, now it will only activate
>    RCU_TABLE_FREE and RCU_GUP when running with LPAE.
>
> The main changes since RFC V4 are:
>  * corrected the arm64 logic so it now correctly rcu-frees page
>    table backing pages.
>  * rcu free logic relaxed for pre-ARMv7 ARM as we need an IPI to
>    invalidate TLBs anyway.
>  * rebased to 3.15-rc3 (some minor changes were needed to allow it to merge).
>  * dropped Catalin's mmu_gather patch as that's been merged already.
>
> This series has been tested with LTP mm tests and some custom futex tests
> that exacerbate the futex on THP tail case; on both an Arndale board and
> a Juno board. Also debug counters were temporarily employed to ensure that
> the RCU_TABLE_FREE logic was behaving as expected.
>
> I would really appreciate any comments (especially on the validity or
> otherwise of the core fast_gup implementation) and testers.

Continues to gets rid of my gccgo hang issue w/ THP.

Tested-by: dann frazier <dann.frazier@canonical.com>

> Cheers,
> --
> Steve
>
> Steve Capper (6):
>   mm: Introduce a general RCU get_user_pages_fast.
>   arm: mm: Introduce special ptes for LPAE
>   arm: mm: Enable HAVE_RCU_TABLE_FREE logic
>   arm: mm: Enable RCU fast_gup
>   arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
>   arm64: mm: Enable RCU fast_gup
>
>  arch/arm/Kconfig                      |   5 +
>  arch/arm/include/asm/pgtable-2level.h |   2 +
>  arch/arm/include/asm/pgtable-3level.h |  15 ++
>  arch/arm/include/asm/pgtable.h        |   6 +-
>  arch/arm/include/asm/tlb.h            |  38 ++++-
>  arch/arm/mm/flush.c                   |  15 ++
>  arch/arm64/Kconfig                    |   4 +
>  arch/arm64/include/asm/pgtable.h      |  11 +-
>  arch/arm64/include/asm/tlb.h          |  20 ++-
>  arch/arm64/mm/flush.c                 |  15 ++
>  mm/Kconfig                            |   3 +
>  mm/gup.c                              | 278 ++++++++++++++++++++++++++++++++++
>  12 files changed, 402 insertions(+), 10 deletions(-)
>
> --
> 1.9.3
>
