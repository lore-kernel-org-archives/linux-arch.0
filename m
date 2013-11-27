From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Wed, 27 Nov 2013 09:11:43 -0800
Message-ID: <20131127171143.GN4137@linux.vnet.ibm.com>
References: <20131125173540.GK3694@twins.programming.kicks-ass.net>
 <20131125180250.GR4138@linux.vnet.ibm.com>
 <20131125182715.GG10022@twins.programming.kicks-ass.net>
 <20131125235252.GA4138@linux.vnet.ibm.com>
 <20131126095945.GI10022@twins.programming.kicks-ass.net>
 <CA+55aFxXEbHuaKuxBDH=7a2-n_z849CdfeDtdL=_nFxu_Tx9_g@mail.gmail.com>
 <20131126192003.GA4137@linux.vnet.ibm.com>
 <CA+55aFyjisiM1eC53STpcKLky84n8JRz3Aagp-CQd_+3AOJhow@mail.gmail.com>
 <20131126225136.GG4137@linux.vnet.ibm.com>
 <20131127101613.GC9032@mudshark.cambridge.arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131127101613.GC9032@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>R
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 27, 2013 at 10:16:13AM +0000, Will Deacon wrote:
> On Tue, Nov 26, 2013 at 10:51:36PM +0000, Paul E. McKenney wrote:
> > On Tue, Nov 26, 2013 at 11:32:25AM -0800, Linus Torvalds wrote:
> > > On Tue, Nov 26, 2013 at 11:20 AM, Paul E. McKenney
> > > <paulmck@linux.vnet.ibm.com> wrote:
> > > >
> > > > There are several places in RCU that assume unlock+lock is a full
> > > > memory barrier, but I would be more than happy to fix them up given
> > > > an smp_mb__after_spinlock() and an smp_mb__before_spinunlock(), or
> > > > something similar.
> > > 
> > > A "before_spinunlock" would actually be expensive on x86.
> > 
> > Good point, on x86 the typical non-queued spin-lock acquisition path
> > has an atomic operation with full memory barrier in any case.  I believe
> > that this is the case for the other TSO architectures.  For the non-TSO
> > architectures:
> > 
> > o	ARM has an smp_mb() during lock acquisition, so after_spinlock()
> > 	can be a no-op for them.
> 
> Ok, but what about arm64? We use acquire for lock() and release for
> unlock(), so in Linus' example:

Right, I did forget the arm vs. arm64 split!

>     write A;
>     spin_lock()
>     mb__after_spinlock();
>     read B
> 
> Then A could very well be reordered after B if mb__after_spinlock() is a nop.
> Making that a full barrier kind of defeats the point of using acquire in the
> first place...

The trick is that you don't have mb__after_spinlock() unless you need the
ordering, which we expect in a small minority of the lock acquisitions.
So you would normally get the benefit of acquire/release efficiency.

> It's one thing ordering unlock -> lock, but another getting those two to
> behave as full barriers for any arbitrary memory accesses.

And in fact the unlock+lock barrier is all that RCU needs.  I guess the
question is whether it is worth having two flavors of __after_spinlock(),
one that is a full barrier with just the lock, and another that is
only guaranteed to be a full barrier with unlock+lock.

								Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
