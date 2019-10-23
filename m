Return-Path: <tglx@linutronix.de>
Date: Thu, 24 Oct 2019 01:23:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 05/17] x86/traps: Make interrupt enable/disable
 symmetric in C code
In-Reply-To: <20191023220109.jmbrluyjxenblcij@treble>
Message-ID: <alpine.DEB.2.21.1910240121460.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.084086112@linutronix.de> <20191023220109.jmbrluyjxenblcij@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023232359.iJQe5tgiogLO5uTaZHAt5eHqNkWlwQODsUOLNkVWJsc@z>

On Wed, 23 Oct 2019, Josh Poimboeuf wrote:
> On Wed, Oct 23, 2019 at 02:27:10PM +0200, Thomas Gleixner wrote:
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1500,10 +1500,13 @@ static noinline void
> >  		return;
> >  
> >  	/* Was the fault on kernel-controlled part of the address space? */
> > -	if (unlikely(fault_in_kernel_space(address)))
> > +	if (unlikely(fault_in_kernel_space(address))) {
> >  		do_kern_addr_fault(regs, hw_error_code, address);
> > -	else
> > +	} else {
> >  		do_user_addr_fault(regs, hw_error_code, address);
> > +		if (regs->flags & X86_EFLAGS_IF)
> > +			local_irq_disable();
> > +	}
> 
> The corresponding irq enable is in do_user_addr_fault(), why not do the
> disable there?

Yeah, will do. Was just as lazy as Peter and did not want to touch the
gazillion of returns. :)

Thanks,

	tglx
