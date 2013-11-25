From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Mon, 25 Nov 2013 10:02:50 -0800
Message-ID: <20131125180250.GR4138@linux.vnet.ibm.com>
References: <20131121110308.GC10022@twins.programming.kicks-ass.net>
 <20131121125616.GI3694@twins.programming.kicks-ass.net>
 <20131121132041.GS4138@linux.vnet.ibm.com>
 <20131121172558.GA27927@linux.vnet.ibm.com>
 <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
 <20131121221859.GH4138@linux.vnet.ibm.com>
 <20131122155835.GR3866@twins.programming.kicks-ass.net>
 <20131122182632.GW4138@linux.vnet.ibm.com>
 <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
 <20131125173540.GK3694@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131125173540.GK3694@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 25, 2013 at 06:35:40PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 22, 2013 at 07:51:07PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 22, 2013 at 10:26:32AM -0800, Paul E. McKenney wrote:
> > > The real source of my cognitive pain is that here we have a sequence of
> > > code that has neither atomic instructions or memory-barrier instructions,
> > > but it looks like it still manages to act as a full memory barrier.
> > > Still not quite sure I should trust it...
> > 
> > Yes, this is something that puzzles me too.
> > 
> > That said, the two rules that:
> > 
> > 1)  stores aren't re-ordered against other stores
> > 2)  reads aren't re-ordered against other reads
> > 
> > Do make that:
> > 
> > 	STORE x
> > 	LOAD  x
> > 
> > form a fence that neither stores nor loads can pass through from
> > either side; note however that they themselves rely on the data
> > dependency to not reorder against themselves.
> > 
> > If you put them the other way around:
> > 
> > 	LOAD x
> > 	STORE y
> > 
> > we seem to get a stronger variant because stores are not re-ordered
> > against older reads.
> > 
> > There is however the exception cause for rule 1) above, which includes
> > clflush, non-temporal stores and string ops; the actual mfence
> > instruction doesn't seem to have this exception and would thus be
> > slightly stronger still.
> > 
> > Still confusion situation all round.
> 
> I think this means x86 needs help too.

I still do not believe that it does.  Again, strangely enough.

We need to ask someone in Intel that understands this all the way down
to the silicon.  The guy I used to rely on for this no longer works
at Intel.

Do you know someone who fits this description, or should I start sending
cold-call emails to various Intel contacts?

> Consider:
> 
> x = y = 0
> 
>   w[x] = 1  |  w[y] = 1
>   mfence    |  mfence
>   r[y] = 0  |  r[x] = 0
> 
> This is generally an impossible case, right? (Since if we observe y=0
> this means that w[y]=1 has not yet happened, and therefore x=1, and
> vice-versa).
> 
> Now replace one of the mfences with smp_store_release(l1);
> smp_load_acquire(l2); such that we have a RELEASE+ACQUIRE pair that
> _should_ form a full barrier:
> 
>   w[x] = 1   | w[y] = 1
>   w[l1] = 1  | mfence
>   r[l2] = 0  | r[x] = 0
>   r[y] = 0   |
> 
> At which point we can observe the impossible, because as per the rule:
> 
> 'reads may be reordered with older writes to different locations'
> 
> Our r[y] can slip before the w[x]=1.
> 
> Thus x86's smp_store_release() would need to be:
> 
> +#define smp_store_release(p, v)						\
> +do {									\
> +	compiletime_assert_atomic_type(*p);				\
> +	smp_mb();							\
> +	ACCESS_ONCE(*p) = (v);						\
> +} while (0)
> 
> Or: (void)xchg((p), (v));
> 
> Idem for s390 and sparc I suppose.
> 
> The only reason your example worked is because the unlock and lock were
> for the same lock.

Exactly!!!

And if the two locks are different, then the guarantee applies only
when the unlock and lock are on the same CPU, in which case, as Linus
noted, the xchg() on entry to the slow path does the job for use.

> This of course leaves us without joy for circular buffers, which can do
> without this LOCK'ed op and without sync on PPC. Now I'm not at all sure
> we've got enough of those to justify primitives just for them.

I am beginning to think that we do, but that is a separate discussion.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
