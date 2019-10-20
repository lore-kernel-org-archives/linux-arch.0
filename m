Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:60264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfJTLtR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Oct 2019 07:49:17 -0400
Date: Sun, 20 Oct 2019 13:49:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 01/15] entry: Provide generic syscall entry
 functionality
In-Reply-To: <CALCETrXB92rZqHMyhSULWVY3Q5=t9q4N9aZFCTn4k0DMNPJfMQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910201347460.2090@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150808.521907403@linutronix.de> <CALCETrXB92rZqHMyhSULWVY3Q5=t9q4N9aZFCTn4k0DMNPJfMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191020114910.XWjXOB4XWfKCvJonByls-XEwuf1kP1cBZGde0M2hVFk@z>

On Fri, 20 Sep 2019, Andy Lutomirski wrote:
> On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > +#ifndef _TIF_AUDIT
> > +# define _TIF_AUDIT                    (0)
> > +#endif
> 
> I'm wondering if these should be __TIF (double-underscore) or
> MAYBE_TIF_ or something to avoid errors where people do flags |=
> TIF_WHATEVER and get surprised.

That's what exists today already. See arch/*/include/asm/threadinfo.h
 
> > +/**
> > + * syscall_enter_from_usermode - Check and handle work before invoking
> > + *                              a syscall
> > + * @regs:      Pointer to currents pt_regs
> > + * @syscall:   The syscall number
> > + *
> > + * Invoked from architecture specific syscall entry code with interrupts
> > + * enabled.
> > + *
> > + * Returns: The original or a modified syscall number
> > + */
> 
> Maybe document that it can return -1 to skip the syscall and that, if
> this happens, it may use syscall_set_error() or
> syscall_set_return_value() first.  If neither of those is called and
> -1 is returned, then the syscall will fail with ENOSYS.

Sure.

Thanks,

	tglx
