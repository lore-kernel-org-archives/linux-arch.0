Return-Path: <luto@kernel.org>
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de>
 <20191023220618.qsmog2k5oaagj27v@treble> <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 24 Oct 2019 09:18:26 -0700
Message-ID: <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191024161826.gIg5kvlPcyZyYedWf6MOxRweqTbbwmz3MN8XRUkfcyo@z>

On Wed, Oct 23, 2019 at 4:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 23 Oct 2019, Josh Poimboeuf wrote:
>
> > On Wed, Oct 23, 2019 at 02:27:12PM +0200, Thomas Gleixner wrote:
> > > Now that the trap handlers return with interrupts disabled, the
> > > unconditional disabling of interrupts in the low level entry code can be
> > > removed along with the trace calls.
> > >
> > > Add debug checks where appropriate.
> >
> > This seems a little scary.  Does anybody other than Andy actually run
> > with CONFIG_DEBUG_ENTRY?
>
> I do.
>
> > What happens if somebody accidentally leaves irqs enabled?  How do we
> > know you found all the leaks?
>
> For the DO_ERROR() ones that's trivial:
>
>  #define DO_ERROR(trapnr, signr, sicode, addr, str, name)                  \
>  dotraplinkage void do_##name(struct pt_regs *regs, long error_code)       \
>  {                                                                         \
>         do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
> +       lockdep_assert_irqs_disabled();                                    \
>  }
>
>  DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
>
> Now for the rest we surely could do:
>
> dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
> {
>         __do_bounds(regs, error_code);
>         lockdep_assert_irqs_disabled();
> }
>
> and move the existing body into a static function so independent of any
> (future) return path there the lockdep assert will be invoked.
>

If we do this, can we macro-ize it:

DEFINE_IDTENTRY_HANDLER(do_bounds)
{
 ...
}

If you do this, please don't worry about the weird ones that take cr2
as a third argument.  Once your series lands, I will send a follow-up
to get rid of it.  It's 2/3 written already.
