From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 15/26] arm64: mte: Allow user control of the tag check
 mode via prctl()
Date: Wed, 27 May 2020 09:48:32 +0100
Message-ID: <20200527084831.GA11111@willie-the-truck>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-16-catalin.marinas@arm.com>
 <20200527074658.GB9887@willie-the-truck>
 <20200527083218.GS5031@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388140AbgE0Isi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 04:48:38 -0400
Content-Disposition: inline
In-Reply-To: <20200527083218.GS5031@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org

On Wed, May 27, 2020 at 09:32:20AM +0100, Dave Martin wrote:
> On Wed, May 27, 2020 at 08:46:59AM +0100, Will Deacon wrote:
> > On Fri, May 15, 2020 at 06:16:01PM +0100, Catalin Marinas wrote:
> > > By default, even if PROT_MTE is set on a memory range, there is no tag
> > > check fault reporting (SIGSEGV). Introduce a set of option to the
> > > exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
> > > check fault mode:
> > > 
> > >   PR_MTE_TCF_NONE  - no reporting (default)
> > >   PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
> > >   PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
> > > 
> > > These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
> > > context-switched by the kernel. Note that uaccess done by the kernel is
> > > not checked and cannot be configured by the user.
> > > 
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > ---
> > > 
> > > Notes:
> > >     v3:
> > >     - Use SCTLR_EL1_TCF0_NONE instead of 0 for consistency.
> > >     - Move mte_thread_switch() in this patch from an earlier one. In
> > >       addition, it is called after the dsb() in __switch_to() so that any
> > >       asynchronous tag check faults have been registered in the TFSR_EL1
> > >       registers (to be added with the in-kernel MTE support.
> > >     
> > >     v2:
> > >     - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
> > >     - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
> > >       Collingbourne).
> > >     - Added ISB to update_sctlr_el1_tcf0() since, with the latest
> > >       architecture update/fix, the TCF0 field is used by the uaccess
> > >       routines.
> > > 
> > >  arch/arm64/include/asm/mte.h       | 14 ++++++
> > >  arch/arm64/include/asm/processor.h |  3 ++
> > >  arch/arm64/kernel/mte.c            | 77 ++++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/process.c        | 26 ++++++++--
> > >  include/uapi/linux/prctl.h         |  6 +++
> > >  5 files changed, 123 insertions(+), 3 deletions(-)
> > 
> > Dave is working on man pages for prctl() (and I think also ptrace). I think
> > it would be /very/ useful for us to have some RFC patches on top of his work
> > adding documentation for the MTE interactions, as we found some other minor
> > issues/inconsistencies as a direct result of writing and reviewing the man
> > page for our existing interfaces.
> 
> I have a local draft for the address tagging and MTE prctls already btw.
> I hadn't posted them yet so as to focus on nailing the "easy" stuff down
> ;)
> 
> If I have time I'll try and get them posted today so that people can
> take a look before next week.

Oh, great! I wasn't meaning that you should be the one doing it, but if
you're already drafted them that's really good. Might make sense for them to
appear as RFC patches at the end of this series, to be honest, so the next
posting (v5) can all be reviewed together.

But I'll leave that up to you and Catalin to figure out.

Will
