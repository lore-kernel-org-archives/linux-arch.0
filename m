Return-Path: <tglx@linutronix.de>
Date: Fri, 25 Oct 2019 00:33:52 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt
 disable
In-Reply-To: <CALCETrXyhnMwwOyWQ-FtsNFAsrcG41-pPrAp8Wj2vc0N9JzP-Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910242353330.1783@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de> <20191023220618.qsmog2k5oaagj27v@treble> <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de> <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
 <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de> <CALCETrXyhnMwwOyWQ-FtsNFAsrcG41-pPrAp8Wj2vc0N9JzP-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191024223352.5tzEPnYfHTkgjE9Phmx38NBy6unqylxQ8OBBFBbeN5k@z>

On Thu, 24 Oct 2019, Andy Lutomirski wrote:
> On Thu, Oct 24, 2019 at 1:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > I spent quite some time digging deeper into this. Finding all corner cases
> > which eventually enable interrupts from an exception handler is not as
> > trivial as it looked in the first place. Especially the fault handler is a
> > nightmare. Also PeterZ's approach of doing
> >
> >            if (regs->eflags & IF)
> >                 local_irq_disable();
> >
> > is doomed due to sys_iopl(). See below.
> 
> I missed something in the discussion.  What breaks?

Assume user space has issued CLI then the above check is giving the wrong
answer because it assumes that all faults in user mode have IF set.

> Can you check user_mode(regs) too?

Yes, but I still hate it with a passion :)

> > What's your plan with cr2? Stash it in pt_regs or something else?
> 
> Just read it from CR2.  I added a new idtentry macro arg called
> "entry_work", and setting it to 0 causes the enter_from_user_mode to
> be skipped.  Then C code calls enter_from_user_mode() after reading
> CR2 (and DR7).  WIP code is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/idtentry
> 
> The idea is that, if everything is converted, then we get rid of the
> entry_work=1 case, which is easier if there's a macro.
> 
> So my suggestion is to use a macro for the 2-arg version and open-code
> all the 3-arg cases.  Then, when the dust settles, we get rid of the
> third arg and they can use the macro.

I'll have a look tomorrow with brain awake.
 
> > The interesting bells and whistels result from sys_iopl(). If user space
> > has been granted iopl(level = 3) it gains cli/sti priviledges. When the
> > application has interrupts disabled in userspace:
> >
> >   - invocation of a syscall
> >
> >   - any exception (aside of NMI/MCE) which conditionally enables interrupts
> >     depending on user_mode(regs) and therefor can be preempted and
> >     schedule
> >
> > is just undefined behaviour and I personally consider it to be a plain bug.
> >
> > Just for the record: This results in running a resulting or even completely
> > unrelated signal handler with interrupts disabled as well.
> 
> I am seriously tempted to say that the solution is to remove iopl(),
> at least on 64-bit kernels.  Doing STI in user mode is BS :)

STI would be halfways sane. CLI is the problem. And yes I agree it's BS :)

> Otherwise we need to give it semantics, no?  I personally have no
> actual problem with the fact that an NMI can cause scheduling to
> happen.  Big fscking deal.

Right, I don't care either. I do neither care that any exception/syscall
which hits a user space CLI region might schedule. It's been that way
forever.

But giving this semantics is insanely hard at least if you want sensible,
useful, consistent and understandable semantics. I know that's overrated.

> > Whatever we decide it is, leaving it completely inconsistent is not a
> > solution at all. The options are:
> >
> >   1)  Always do conditional tracing depending on the user_regs->eflags.IF
> >       state.
> 
> I'm okay with always tracing like user mode means IRQs on or doing it
> "correctly".  I consider the former to be simpler and therefore quite
> possibly better.
> 
> >
> >   2)  #1 + warn once when syscalls and exceptions (except NMI/MCE) happen
> >       and user_regs->eflags.IF is cleared.
> >
> >   3a) #2 + enforce signal handling to run with interrupts enabled.
> >
> >   3b) #2 + set regs->eflags.IF. So the state is always correct from the
> >       kernel POV. Of course that changes existing behaviour, but its
> >       changing undefined and inconsistent behaviour.
> >
> >   4) Let iopl(level) return -EPERM if level == 3.
> >
> >      Yeah, I know it's not possible due to regressions (DPKD uses iopl(3)),
> >      but TBH that'd be the sanest option of all.
> >
> >      Of course the infinite wisdom of hardware designers tied IN, INS, OUT,
> >      OUTS and CLI/STI together on IOPL so we cannot even distangle them in
> >      any way.
> 
> >
> >      The only way out would be to actually use a full 8K sized I/O bitmap,
> >      but that's a massive pain as it has to be copied on every context
> >      switch.
> 
> Hmm.  This actually doesn't seem that bad.  We already have a TIF_
> flag to optimize this.  So basically iopl() would effectively become
> ioperm(everything on).

Yes, and the insane user space would:

     1) Pay the latency price for copying 8K bitmap on every context switch
     	IN

     2) Inflict latency on the next task due to requiring memset of 8K
     	bitmap on every context switch OUT

     3) #GP when issuing CLI/STI

I personally have no problem with that. #1 and #3 are sane and as iopl()
requires CAP_RAW_IO it's not available to Joe User, so the sysadmin is
responsible for eventual issues resulting from #2.

Though the no-regression hammer might pound on #3 as it breaks random
engineering trainwrecks from hell.

#1/#2 could be easily mitigated though.

      struct tss_struct {
      	struct x86_hw_tss       x86_tss;
	unsigned long           io_bitmap[IO_BITMAP_LONGS + 1];
      };

and x86_tss has

    u16	io_bitmap_base;

which is either set to

  INVALID_IO_BITMAP_OFFSET ( 0x8000 )

or

  IO_BITMAP_OFFSET
    (offsetof(struct tss_struct, io_bitmap) - offsetof(struct tss_struct, x86_tss))

So we could add

	unsigned long           io_bitmap_all[IO_BITMAP_LONGS + 1];

and just set the base to this one.

But that involves also upping __KERNEL_TSS_LIMIT. Too tired to think about
the implications of that right now.

Thanks,

	tglx
