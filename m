From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 15/26] arm64: mte: Allow user control of the tag check
 mode via prctl()
Date: Wed, 27 May 2020 08:46:59 +0100
Message-ID: <20200527074658.GB9887@willie-the-truck>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-16-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbgE0HrE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 03:47:04 -0400
Content-Disposition: inline
In-Reply-To: <20200515171612.1020-16-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>

On Fri, May 15, 2020 at 06:16:01PM +0100, Catalin Marinas wrote:
> By default, even if PROT_MTE is set on a memory range, there is no tag
> check fault reporting (SIGSEGV). Introduce a set of option to the
> exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
> check fault mode:
> 
>   PR_MTE_TCF_NONE  - no reporting (default)
>   PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
>   PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
> 
> These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
> context-switched by the kernel. Note that uaccess done by the kernel is
> not checked and cannot be configured by the user.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     v3:
>     - Use SCTLR_EL1_TCF0_NONE instead of 0 for consistency.
>     - Move mte_thread_switch() in this patch from an earlier one. In
>       addition, it is called after the dsb() in __switch_to() so that any
>       asynchronous tag check faults have been registered in the TFSR_EL1
>       registers (to be added with the in-kernel MTE support.
>     
>     v2:
>     - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
>     - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
>       Collingbourne).
>     - Added ISB to update_sctlr_el1_tcf0() since, with the latest
>       architecture update/fix, the TCF0 field is used by the uaccess
>       routines.
> 
>  arch/arm64/include/asm/mte.h       | 14 ++++++
>  arch/arm64/include/asm/processor.h |  3 ++
>  arch/arm64/kernel/mte.c            | 77 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/process.c        | 26 ++++++++--
>  include/uapi/linux/prctl.h         |  6 +++
>  5 files changed, 123 insertions(+), 3 deletions(-)

Dave is working on man pages for prctl() (and I think also ptrace). I think
it would be /very/ useful for us to have some RFC patches on top of his work
adding documentation for the MTE interactions, as we found some other minor
issues/inconsistencies as a direct result of writing and reviewing the man
page for our existing interfaces.

Cheers,

Will
