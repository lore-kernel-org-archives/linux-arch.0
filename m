From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Tue, 26 Nov 2013 11:20:03 -0800
Message-ID: <20131126192003.GA4137@linux.vnet.ibm.com>
References: <20131121221859.GH4138@linux.vnet.ibm.com>
 <20131122155835.GR3866@twins.programming.kicks-ass.net>
 <20131122182632.GW4138@linux.vnet.ibm.com>
 <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
 <20131125173540.GK3694@twins.programming.kicks-ass.net>
 <20131125180250.GR4138@linux.vnet.ibm.com>
 <20131125182715.GG10022@twins.programming.kicks-ass.net>
 <20131125235252.GA4138@linux.vnet.ibm.com>
 <20131126095945.GI10022@twins.programming.kicks-ass.net>
 <CA+55aFxXEbHuaKuxBDH=7a2-n_z849CdfeDtdL=_nFxu_Tx9_g@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxXEbHuaKuxBDH=7a2-n_z849CdfeDtdL=_nFxu_Tx9_g@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <ragha>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 26, 2013 at 11:00:50AM -0800, Linus Torvalds wrote:
> On Tue, Nov 26, 2013 at 1:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > If you now want to weaken this definition, then that needs consideration
> > because we actually rely on things like
> >
> > spin_unlock(l1);
> > spin_lock(l2);
> >
> > being full barriers.
> 
> Btw, maybe we should just stop that assumption. The complexity of this
> discussion makes me go "maybe we should stop with subtle assumptions
> that happen to be obviously true on x86 due to historical
> implementations, but aren't obviously true even *there* any more with
> the MCS lock".

From an RCU viewpoint, I am OK with that approach.  From the viewpoint
of documenting our assumptions, I really really like that approach.

> We already have a concept of
> 
>         smp_mb__before_spinlock();
>         spin_lock():
> 
> for sequences where we *know* we need to make getting a spin-lock be a
> full memory barrier. It's free on x86 (and remains so even with the
> MCS lock, regardless of any subtle issues, if only because even the
> MCS lock starts out with a locked atomic, never mind the contention
> slow-case). Of course, that macro is only used inside the scheduler,
> and is actually documented to not really be a full memory barrier, but
> it handles the case we actually care about.

This would work well if we made it be smp_mb__after_spinlock(), used
as follows:

	spin_lock();
	smp_mb__after_spinlock();

The reason that it must go after rather than before is to handle the
MCS-style low-overhead handoffs.  During the handoff, you can count
on code at the beginning of the critical section being executed, but
things before the lock cannot possibly help you.

We should also have something for lock releases, for example:

	smp_mb__before_spinunlock();
	spin_unlock();

This allows architectures to choose where to put the overhead, and
also very clearly documents which unlock+lock pairs need the full
barriers.

Heh.  Must smp_mb__after_spinlock() and smp_mb__before_spinunlock()
provide a full barrier when used separately, or only when used together?
The unlock+lock guarantee requires that they provide a full barrier
only when used together.  However, I believe that the scheduler's use
of smp_mb__before_spinlock() needs a full barrier without pairing.

I have no idea whether or not we should have a separate API for each
flavor of lock.

> IOW, where do we really care about the "unlock+lock" is a memory
> barrier? And could we make those places explicit, and then do
> something similar to the above to them?

There are several places in RCU that assume unlock+lock is a full
memory barrier, but I would be more than happy to fix them up given
an smp_mb__after_spinlock() and an smp_mb__before_spinunlock(), or
something similar.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
