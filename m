From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Tue, 26 Nov 2013 14:51:36 -0800
Message-ID: <20131126225136.GG4137@linux.vnet.ibm.com>
References: <20131122182632.GW4138@linux.vnet.ibm.com>
 <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
 <20131125173540.GK3694@twins.programming.kicks-ass.net>
 <20131125180250.GR4138@linux.vnet.ibm.com>
 <20131125182715.GG10022@twins.programming.kicks-ass.net>
 <20131125235252.GA4138@linux.vnet.ibm.com>
 <20131126095945.GI10022@twins.programming.kicks-ass.net>
 <CA+55aFxXEbHuaKuxBDH=7a2-n_z849CdfeDtdL=_nFxu_Tx9_g@mail.gmail.com>
 <20131126192003.GA4137@linux.vnet.ibm.com>
 <CA+55aFyjisiM1eC53STpcKLky84n8JRz3Aagp-CQd_+3AOJhow@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyjisiM1eC53STpcKLky84n8JRz3Aagp-CQd_+3AOJhow@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <ragha>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 26, 2013 at 11:32:25AM -0800, Linus Torvalds wrote:
> On Tue, Nov 26, 2013 at 11:20 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > There are several places in RCU that assume unlock+lock is a full
> > memory barrier, but I would be more than happy to fix them up given
> > an smp_mb__after_spinlock() and an smp_mb__before_spinunlock(), or
> > something similar.
> 
> A "before_spinunlock" would actually be expensive on x86.

Good point, on x86 the typical non-queued spin-lock acquisition path
has an atomic operation with full memory barrier in any case.  I believe
that this is the case for the other TSO architectures.  For the non-TSO
architectures:

o	ARM has an smp_mb() during lock acquisition, so after_spinlock()
	can be a no-op for them.

o	Itanium will require more thought, but it looks like it doesn't
	care between after_spinlock() and before_spinunlock().  I have
	to defer to the maintainrs.

o	PowerPC is OK either way.

> So I'd *much* rather see the "after_spinlock()" version, if that is
> sufficient for all users. And it should be, since that's the
> traditional x86 behavior that we had before the MCS lock discussion.
> 
> Because it's worth noting that a spin_lock() is still a full memory
> barrier on x86, even with the MCS code, *assuming it is done in the
> context of the thread needing the memory barrier". And I suspect that
> is much more generally true than just x86. It's the final MCS hand-off
> of a lock that is pretty weak with just a local read. The full lock
> sequence is always going to be much stronger, if only because it will
> contain a write somewhere shared as well.

Good points, and after_spinlock() works for me from an RCU perspective.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
