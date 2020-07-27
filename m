From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] lockdep: Fix TRACE_IRQFLAGS vs NMIs
Date: Mon, 27 Jul 2020 15:17:31 +0200
Message-ID: <20200727131731.GB105139@gmail.com>
References: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgG0NRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 09:17:35 -0400
Content-Disposition: inline
In-Reply-To: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, x86@kernel.org, linux-sh@vger.kernel.org, borntraeger@de.ibm.com, jcmvbkbc@gmail.com


* peterz@infradead.org <peterz@infradead.org> wrote:

> 
> Prior to commit 859d069ee1dd ("lockdep: Prepare for NMI IRQ state
> tracking") IRQ state tracking was disabled in NMIs due to nmi_enter()
> doing lockdep_off() -- with the obvious requirement that NMI entry
> call nmi_enter() before trace_hardirqs_off().
> 
> [ afaict, PowerPC and SH violate this order on their NMI entry ]
> 
> However, that commit explicitly changed lockdep_hardirqs_*() to ignore
> lockdep_off() and breaks every architecture that has irq-tracing in
> it's NMI entry that hasn't been fixed up (x86 being the only fixed one
> at this point).
> 
> The reason for this change is that by ignoring lockdep_off() we can:
> 
>   - get rid of 'current->lockdep_recursion' in lockdep_assert_irqs*()
>     which was going to to give header-recursion issues with the
>     seqlock rework.
> 
>   - allow these lockdep_assert_*() macros to function in NMI context.
> 
> Restore the previous state of things and allow an architecture to
> opt-in to the NMI IRQ tracking support, however instead of relying on
> lockdep_off(), rely on in_nmi(), both are part of nmi_enter() and so
> over-all entry ordering doesn't need to change.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig.debug   |    3 +++
>  kernel/locking/lockdep.c |    8 +++++++-
>  lib/Kconfig.debug        |    6 ++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)

Tree management side note: to apply this I've created a new 
tip:locking/nmi branch, which is based off the existing NMI vs. IRQ 
tracing commits included in locking/core:

ed00495333cc: ("locking/lockdep: Fix TRACE_IRQFLAGS vs. NMIs")
ba1f2b2eaa2a: ("x86/entry: Fix NMI vs IRQ state tracking")
859d069ee1dd: ("lockdep: Prepare for NMI IRQ state tracking")
248591f5d257: ("kcsan: Make KCSAN compatible with new IRQ state tracking")
e1bcad609f5a: ("Merge branch 'tip/x86/entry'")
b037b09b9058: ("x86/entry: Rename idtentry_enter/exit_cond_rcu() to idtentry_enter/exit()")
dcb7fd82c75e: ("Linux 5.8-rc4")

This locking/nmi branch can then be merged into irq/entry (there's a 
bunch of conflicts between them), without coupling all of v5.9's 
locking changes to Thomas's generic entry work.

Thanks,

	Ingo
