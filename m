Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfIWIkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 04:40:52 -0400
Date: Mon, 23 Sep 2019 10:40:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry
 function
In-Reply-To: <20190923083114.GF2349@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1909231040270.2003@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150808.724554170@linutronix.de> <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com> <20190923083114.GF2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190923084040.f-vjBvbc6zFoifFWkVFhlqTti_f6tSxYLDHAs2Lf7Oo@z>

On Mon, 23 Sep 2019, Peter Zijlstra wrote:

> On Fri, Sep 20, 2019 at 04:41:03PM -0700, Andy Lutomirski wrote:
> > On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Replace the syscall entry work handling with the generic version, Provide
> > > the necessary helper inlines to handle the real architecture specific
> > > parts, e.g. audit and seccomp invocations.
> > 
> > > -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> > > -               ret = tracehook_report_syscall_entry(regs);
> > > -               if (ret || (work & _TIF_SYSCALL_EMU))
> > > -                       return -1L;
> > > -       }
> > 
> > Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.
> 
> IIUC that's actually in patch #1.

Correct:

+       if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+               ret = arch_syscall_enter_tracehook(regs);
+               if (ret || (ti_work & _TIF_SYSCALL_EMU))
+                       return -1L;
+       }
