From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Tue, 26 Nov 2013 09:11:06 -0800
Message-ID: <20131126171106.GJ4138@linux.vnet.ibm.com>
References: <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
 <20131121221859.GH4138@linux.vnet.ibm.com>
 <20131122155835.GR3866@twins.programming.kicks-ass.net>
 <20131122182632.GW4138@linux.vnet.ibm.com>
 <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
 <20131125173540.GK3694@twins.programming.kicks-ass.net>
 <20131125180250.GR4138@linux.vnet.ibm.com>
 <20131125182715.GG10022@twins.programming.kicks-ass.net>
 <20131125235252.GA4138@linux.vnet.ibm.com>
 <20131126095945.GI10022@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131126095945.GI10022@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 26, 2013 at 10:59:45AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 25, 2013 at 03:52:52PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 25, 2013 at 07:27:15PM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 25, 2013 at 10:02:50AM -0800, Paul E. McKenney wrote:
> > > > And if the two locks are different, then the guarantee applies only
> > > > when the unlock and lock are on the same CPU, in which case, as Linus
> > > > noted, the xchg() on entry to the slow path does the job for use.
> > > 
> > > But in that case we rely on the fact that the thing is part of a
> > > composite and we should no longer call it load_acquire, because frankly
> > > it doesn't have acquire semantics anymore because the read can escape
> > > out.
> > 
> > Actually, load-acquire and store-release are only required to provide
> > ordering in the threads/CPUs doing the load-acquire/store-release
> > operations.  It is just that we require something stronger than minimal
> > load-acquire/store-release to make a Linux-kernel lock.
> 
> I suspect we're talking past one another here; but our Document
> describes ACQUIRE/RELEASE semantics such that
> 
>   RELEASE
>   ACQUIRE
> 
> matches a full barrier, regardless on whether it is the same lock or
> not.

Ah, got it!

> If you now want to weaken this definition, then that needs consideration
> because we actually rely on things like
> 
> spin_unlock(l1);
> spin_lock(l2);
> 
> being full barriers.
> 
> Now granted, for lock operations we have actual atomic ops in between
> which would cure x86, but it would leave us confused with the barrier
> semantics.
> 
> So please; either: 
> 
> A) we have the strong ACQUIRE/RELEASE semantics as currently described;
>    and therefore any RELEASE+ACQUIRE pair must form a full barrier; and
>    our propose primitives are non-compliant and needs strengthening.
> 
> B) we go fudge about with the definitions.

Another approach would be to have local and global variants, so that
the local variants have acquire/release semantics that are guaranteed
to be visible only in the involved threads (sufficient for circular
buffers) while the global ones are visible globally, thus sufficient
for queued locks.

> But given the current description of our ACQUIRE barrier, we simply
> cannot claim the proposed primitives are good on x86 IMO.
> 
> Also, instead of the smp_store_release() I would argue that
> smp_load_acquire() is the one that needs the full buffer, even on PPC.
> 
> Because our ACQUIRE dis-allows loads/stores leaking out upwards, and
> both TSO and PPC lwsync allow just that, so the smp_load_acquire() is
> the one that needs the full barrier.

You lost me on this one.  Here is x86 ACQUIRE for X:

	r1 = ACCESS_ONCE(X);
	<loads and stores>

Since x86 does not reorder loads with later loads or stores, this should
be sufficience.

For powerpc:

	r1 = ACCESS_ONCE(X);
	lwsync;
	<loads and stores>

And lwsync does not allow prior loads to be reordered with later loads or
stores, so this should also be sufficient.

In both cases, a RELEASE+ACQUIRE provides a full barrier as long as
RELEASE has the right stuff in it.

So what am I missing?

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
