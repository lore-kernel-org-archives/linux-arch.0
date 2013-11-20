From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Wed, 20 Nov 2013 09:14:00 -0800
Message-ID: <20131120171400.GI4138@linux.vnet.ibm.com>
References: <cover.1384885312.git.tim.c.chen@linux.intel.com>
 <1384911463.11046.454.camel@schen9-DESK>
 <20131120153123.GF4138@linux.vnet.ibm.com>
 <20131120154643.GG19352@mudshark.cambridge.arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131120154643.GG19352@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 20, 2013 at 03:46:43PM +0000, Will Deacon wrote:
> Hi Paul,
> 
> On Wed, Nov 20, 2013 at 03:31:23PM +0000, Paul E. McKenney wrote:
> > On Tue, Nov 19, 2013 at 05:37:43PM -0800, Tim Chen wrote:
> > > @@ -68,7 +72,12 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
> > >  		while (!(next = ACCESS_ONCE(node->next)))
> > >  			arch_mutex_cpu_relax();
> > >  	}
> > > -	ACCESS_ONCE(next->locked) = 1;
> > > -	smp_wmb();
> > > +	/*
> > > +	 * Pass lock to next waiter.
> > > +	 * smp_store_release() provides a memory barrier to ensure
> > > +	 * all operations in the critical section has been completed
> > > +	 * before unlocking.
> > > +	 */
> > > +	smp_store_release(&next->locked, 1);
> > 
> > However, there is one problem with this that I missed yesterday.
> > 
> > Documentation/memory-barriers.txt requires that an unlock-lock pair
> > provide a full barrier, but this is not guaranteed if we use
> > smp_store_release() for unlock and smp_load_acquire() for lock.
> > At least one of these needs a full memory barrier.
> 
> Hmm, so in the following case:
> 
>   Access A
>   unlock()	/* release semantics */
>   lock()	/* acquire semantics */
>   Access B
> 
> A cannot pass beyond the unlock() and B cannot pass the before the lock().
> 
> I agree that accesses between the unlock and the lock can be move across both
> A and B, but that doesn't seem to matter by my reading of the above.
> 
> What is the problematic scenario you have in mind? Are you thinking of the
> lock() moving before the unlock()? That's only permitted by RCpc afaiu,
> which I don't think any architectures supported by Linux implement...
> (ARMv8 acquire/release is RCsc).

If smp_load_acquire() and smp_store_release() are both implemented using
lwsync on powerpc, and if Access A is a store and Access B is a load,
then Access A and Access B can be reordered.

Of course, if every other architecture will be providing RCsc implementations
for smp_load_acquire() and smp_store_release(), which would not be a bad
thing, then another approach is for powerpc to use sync rather than lwsync
for one or the other of smp_load_acquire() or smp_store_release().

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
