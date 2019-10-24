Return-Path: <peterz@infradead.org>
Date: Thu, 24 Oct 2019 23:21:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
Message-ID: <20191024212105.GY4114@hirez.programming.kicks-ass.net>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.296135499@linutronix.de>
 <20191023220618.qsmog2k5oaagj27v@treble>
 <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
 <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
 <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191024212105.etdWtButgH77SisEyk9WUWUWqxOSozZFkNnNphLz7o4@z>

On Thu, Oct 24, 2019 at 10:52:59PM +0200, Thomas Gleixner wrote:
> is just undefined behaviour and I personally consider it to be a plain bug.

I concur.

> Just for the record: This results in running a resulting or even completely
> unrelated signal handler with interrupts disabled as well.
> 
> Whatever we decide it is, leaving it completely inconsistent is not a
> solution at all. The options are:
> 
>   1)  Always do conditional tracing depending on the user_regs->eflags.IF
>       state.
> 
>   2)  #1 + warn once when syscalls and exceptions (except NMI/MCE) happen
>       and user_regs->eflags.IF is cleared.
> 
>   3a) #2 + enforce signal handling to run with interrupts enabled.
> 
>   3b) #2 + set regs->eflags.IF. So the state is always correct from the
>       kernel POV. Of course that changes existing behaviour, but its
>       changing undefined and inconsistent behaviour.
>   
>   4) Let iopl(level) return -EPERM if level == 3.
> 
>      Yeah, I know it's not possible due to regressions (DPKD uses iopl(3)),
>      but TBH that'd be the sanest option of all.
> 
>      Of course the infinite wisdom of hardware designers tied IN, INS, OUT,
>      OUTS and CLI/STI together on IOPL so we cannot even distangle them in
>      any way.
> 
>      The only way out would be to actually use a full 8K sized I/O bitmap,
>      but that's a massive pain as it has to be copied on every context
>      switch. 
> 
> Really pretty options to chose from ...

If 4 is out (and I'm afraid it might be), then I'm on record for liking
3b.
