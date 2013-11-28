From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Thu, 28 Nov 2013 10:27:12 -0800
Message-ID: <20131128182712.GW4137@linux.vnet.ibm.com>
References: <20131126095945.GI10022@twins.programming.kicks-ass.net>
 <CA+55aFxXEbHuaKuxBDH=7a2-n_z849CdfeDtdL=_nFxu_Tx9_g@mail.gmail.com>
 <20131126192003.GA4137@linux.vnet.ibm.com>
 <CA+55aFyjisiM1eC53STpcKLky84n8JRz3Aagp-CQd_+3AOJhow@mail.gmail.com>
 <20131126225136.GG4137@linux.vnet.ibm.com>
 <20131127101613.GC9032@mudshark.cambridge.arm.com>
 <20131127171143.GN4137@linux.vnet.ibm.com>
 <20131128114058.GC21354@mudshark.cambridge.arm.com>
 <20131128173853.GV4137@linux.vnet.ibm.com>
 <20131128180318.GE16203@mudshark.cambridge.arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131128180318.GE16203@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>R
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 28, 2013 at 06:03:18PM +0000, Will Deacon wrote:
> On Thu, Nov 28, 2013 at 05:38:53PM +0000, Paul E. McKenney wrote:
> > On Thu, Nov 28, 2013 at 11:40:59AM +0000, Will Deacon wrote:
> > > On Wed, Nov 27, 2013 at 05:11:43PM +0000, Paul E. McKenney wrote:
> > > > And in fact the unlock+lock barrier is all that RCU needs.  I guess the
> > > > question is whether it is worth having two flavors of __after_spinlock(),
> > > > one that is a full barrier with just the lock, and another that is
> > > > only guaranteed to be a full barrier with unlock+lock.
> > > 
> > > I think it's worth distinguishing those cases because, in my mind, one is
> > > potentially a lot heavier than the other. The risk is that we end up
> > > producing a set of strangely named barrier abstractions that nobody can
> > > figure out how to use properly:
> > > 
> > > 
> > > 	/*
> > > 	 * Prevent re-ordering of arbitrary accesses across spin_lock and
> > > 	 * spin_unlock.
> > > 	 */
> > > 	mb__after_spin_lock()
> > > 	mb__after_spin_unlock()
> > > 
> > > 	/*
> > > 	 * Order spin_lock() vs spin_unlock()
> > > 	 */
> > > 	mb__between_spin_unlock_lock() /* Horrible name! */
> > > 
> > > 
> > > We could potentially replace the first set of barriers with spin_lock_mb()
> > > and spin_unlock_mb() variants (which would be more efficient than half
> > > barrier + full barrier), then we only end up with strangely named barrier
> > > which applies to the non _mb() spinlock routines.
> > 
> > How about the current mb__before_spinlock() making the acquisition be
> > a full barrier, and an mb_after_spinlock() making a prior release plus
> > this acquisition be a full barrier?
> 
> Hmm, without horrible hacks to keep track of whether we've done an
> mb__before_spinlock() without a matching spinlock(), that's going to end up
> with full-barrier + pointless half-barrier (similarly on the release path).

We should be able to detect mb__before_spinlock() without a matching
spinlock via static analysis, right?

Or am I missing your point?

> > Yes, we might need better names, but I believe that this approach does
> > what you need.
> > 
> > Thoughts?
> 
> I still think we need to draw the distinction between ordering all accesses
> against a lock and ordering an unlock against a lock. The latter is free for
> arm64 (STLR => LDAR is ordered) but the former requires a DMB.
> 
> Not sure I completely got your drift...

Here is what I am suggesting:

o	mb__before_spinlock():

	o	Must appear immediately before a lock acquisition.
	o	Upgrades a lock acquisition to a full barrier.
	o	Emits DMB on ARM64.
	
o	mb_after_spinlock():

	o	Must appear immediatly after a lock acquisition.
	o	Upgrades an unlock+lock pair to a full barrier.
	o	Emits a no-op on ARM64, as in "do { } while (0)".
	o	Might need a separate flavor for queued locks on
		some platforms, but no sign of that yet.

Does that make sense?

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
