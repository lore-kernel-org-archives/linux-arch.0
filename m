Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfIWK1y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 06:27:54 -0400
Date: Mon, 23 Sep 2019 12:27:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
In-Reply-To: <20190923084718.GG2349@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1909231227050.2003@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150809.446771597@linutronix.de> <20190923084718.GG2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190923102747.65qOlr13bUx7RJJM0EsFxWzEfHSYoXmjWBX8Q0fPx_I@z>

On Mon, 23 Sep 2019, Peter Zijlstra wrote:

> On Thu, Sep 19, 2019 at 05:03:24PM +0200, Thomas Gleixner wrote:
> > To prepare for converting the exit to usermode code to the generic version,
> > move the irqflags tracing into C code.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/entry/common.c          |   10 ++++++++++
> >  arch/x86/entry/entry_32.S        |   11 +----------
> >  arch/x86/entry/entry_64.S        |   10 ++--------
> >  arch/x86/entry/entry_64_compat.S |   21 ---------------------
> >  4 files changed, 13 insertions(+), 39 deletions(-)
> > 
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -102,6 +102,8 @@ static void exit_to_usermode_loop(struct
> >  	struct thread_info *ti = current_thread_info();
> >  	u32 cached_flags;
> >  
> > +	trace_hardirqs_off();
> 
> Bah.. so this gets called from:
> 
>  - C code, with IRQs disabled
>  - entry_64.S:error_exit
>  - entry_32.S:resume_userspace
> 
> The first obviously doesn't need this annotation, but this patch doesn't
> remove the TRACE_IRQS_OFF from entry_64.S and only the 32bit case is
> changed.
> 
> Is that entry_64.S case an oversight, or do we need an extensive comment
> on this one?

Lemme stare at that again. At some point I probably lost track in that maze.

Thanks,

	tglx
