Return-Path: <tglx@linutronix.de>
Date: Thu, 24 Oct 2019 01:52:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt
 disable
In-Reply-To: <20191023220618.qsmog2k5oaagj27v@treble>
Message-ID: <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de> <20191023220618.qsmog2k5oaagj27v@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023235233.qU5aOOuUYynZXgNGQZ5Un3Xa6philmzX_YCmWtd4cgE@z>

On Wed, 23 Oct 2019, Josh Poimboeuf wrote:

> On Wed, Oct 23, 2019 at 02:27:12PM +0200, Thomas Gleixner wrote:
> > Now that the trap handlers return with interrupts disabled, the
> > unconditional disabling of interrupts in the low level entry code can be
> > removed along with the trace calls.
> > 
> > Add debug checks where appropriate.
> 
> This seems a little scary.  Does anybody other than Andy actually run
> with CONFIG_DEBUG_ENTRY?

I do.

> What happens if somebody accidentally leaves irqs enabled?  How do we
> know you found all the leaks?

For the DO_ERROR() ones that's trivial:

 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)                  \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
 {									   \
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
+	lockdep_assert_irqs_disabled();					   \
 }
 
 DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)

Now for the rest we surely could do:

dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
{
	__do_bounds(regs, error_code);
	lockdep_assert_irqs_disabled();
}

and move the existing body into a static function so independent of any
(future) return path there the lockdep assert will be invoked.

Thanks,

	tglx
