From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Tue, 21 Jun 2016 14:27:22 +1000 (AEST)
Message-ID: <alpine.LNX.2.00.1606211350360.26385@nippy.intranet>
References: <20160531101925.702692792@infradead.org> <20160531102642.333689893@infradead.org> <CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com> <20160616101309.GD30921@twins.programming.kicks-ass.net> <mvmk2hpxq1a.fsf@hawking.suse.de>
 <20160617154024.GY30154@twins.programming.kicks-ass.net> <87twgniwh7.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <87twgniwh7.fsf@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org


On Mon, 20 Jun 2016, Andreas Schwab wrote:

> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Could either of you comment on the below patch?
> >
> > All atomic functions that return a value should imply full memory 
> > barrier semantics -- this very much includes a compiler barrier / 
> > memory clobber.
> 
> I wonder if it is possible to find a case where this makes a real 
> difference, ie. where the compiler erroneously reused a value due to the 
> missing barrier.

What the compiler does erroneously is a compiler bug by definition. But I 
think that was not what you meant.

Perhaps you're asking whether gcc in particular does what you expect, 
despite ambiguous source code. But what about other tools like static 
analyzers?

Ambiguous code is likely to attract patches like this for as long as it 
remains ambiguous. That's a waste of everyone's time, if patches like this 
could be written and reviewed just once.

-- 

> 
> Andreas.
> 
> 
