From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 23 Jan 2020 11:22:51 +0000
Message-ID: <20200123112251.GC18991@willie-the-truck>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <20200123092658.GC14879@hirez.programming.kicks-ass.net>
 <20200123100635.GE14946@hirez.programming.kicks-ass.net>
 <20200123101649.GF14946@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200123101649.GF14946@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 23, 2020 at 11:16:49AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 11:06:35AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 23, 2020 at 10:26:58AM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 14, 2020 at 10:59:18PM -0500, Alex Kogan wrote:
> > > > +/* this function is called only when the primary queue is empty */
> > > > +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> > > > +				       struct mcs_spinlock *node)
> > > > +{
> > > > +	struct mcs_spinlock *head_2nd, *tail_2nd;
> > > > +	u32 new;
> > > > +
> > > > +	/* If the secondary queue is empty, do what MCS does. */
> > > > +	if (node->locked <= 1)
> > > > +		return __try_clear_tail(lock, val, node);
> > > > +
> > > > +	/*
> > > > +	 * Try to update the tail value to the last node in the secondary queue.
> > > > +	 * If successful, pass the lock to the first thread in the secondary
> > > > +	 * queue. Doing those two actions effectively moves all nodes from the
> > > > +	 * secondary queue into the main one.
> > > > +	 */
> > > > +	tail_2nd = decode_tail(node->locked);
> > > > +	head_2nd = tail_2nd->next;
> > > > +	new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
> > > > +
> > > > +	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> > > > +		/*
> > > > +		 * Try to reset @next in tail_2nd to NULL, but no need to check
> > > > +		 * the result - if failed, a new successor has updated it.
> > > > +		 */
> > > 
> > > I think you actually have an ordering bug here; the load of head_2nd
> > > *must* happen before the atomic_try_cmpxchg(), otherwise it might
> > > observe the new next and clear a valid next pointer.
> > > 
> > > What would be the best fix for that; I'm thinking:
> > > 
> > > 	head_2nd = smp_load_acquire(&tail_2nd->next);
> > > 
> > > Will?
> > 
> > Hmm, given we've not passed the lock around yet; why wouldn't something
> > like this work:
> > 
> > 	smp_store_release(&tail_2nd->next, NULL);
> 
> Argh, make that:
> 
> 	tail_2nd->next = NULL;
> 
> 	smp_wmb();
> 
> > 	if (!atomic_try_cmpxchg_relaxed(&lock, &val, new)) {

... or could you drop the smp_wmb() and make this
atomic_try_cmpxchg_release()?

To be honest, I've failed to understand the code prior to your changes
in this area: it appears to reply on a control-dependency from the two
cmpxchg_relaxed() calls (which isn't sufficient to order the store parts
afaict) and I also don't get how we deal with a transiently circular primary
queue.

Will
