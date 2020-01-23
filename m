Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWKRE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 05:17:04 -0500
Date: Thu, 23 Jan 2020 11:16:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123101649.GF14946@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <20200123092658.GC14879@hirez.programming.kicks-ass.net>
 <20200123100635.GE14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123100635.GE14946@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200123101649.PCFN448zL6U6Mhce3wTQo1uU8wDI8abcM23JelrCDq0@z>

On Thu, Jan 23, 2020 at 11:06:35AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 10:26:58AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 14, 2020 at 10:59:18PM -0500, Alex Kogan wrote:
> > > +/* this function is called only when the primary queue is empty */
> > > +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> > > +				       struct mcs_spinlock *node)
> > > +{
> > > +	struct mcs_spinlock *head_2nd, *tail_2nd;
> > > +	u32 new;
> > > +
> > > +	/* If the secondary queue is empty, do what MCS does. */
> > > +	if (node->locked <= 1)
> > > +		return __try_clear_tail(lock, val, node);
> > > +
> > > +	/*
> > > +	 * Try to update the tail value to the last node in the secondary queue.
> > > +	 * If successful, pass the lock to the first thread in the secondary
> > > +	 * queue. Doing those two actions effectively moves all nodes from the
> > > +	 * secondary queue into the main one.
> > > +	 */
> > > +	tail_2nd = decode_tail(node->locked);
> > > +	head_2nd = tail_2nd->next;
> > > +	new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
> > > +
> > > +	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> > > +		/*
> > > +		 * Try to reset @next in tail_2nd to NULL, but no need to check
> > > +		 * the result - if failed, a new successor has updated it.
> > > +		 */
> > 
> > I think you actually have an ordering bug here; the load of head_2nd
> > *must* happen before the atomic_try_cmpxchg(), otherwise it might
> > observe the new next and clear a valid next pointer.
> > 
> > What would be the best fix for that; I'm thinking:
> > 
> > 	head_2nd = smp_load_acquire(&tail_2nd->next);
> > 
> > Will?
> 
> Hmm, given we've not passed the lock around yet; why wouldn't something
> like this work:
> 
> 	smp_store_release(&tail_2nd->next, NULL);

Argh, make that:

	tail_2nd->next = NULL;

	smp_wmb();

> 	if (!atomic_try_cmpxchg_relaxed(&lock, &val, new)) {
> 		tail_2nd->next = head_2nd;
> 		return false;
> 	}
> 
> The whole second queue is only ever modified by the lock owner, and that
> is us, so we can pre-terminate the secondary queue (break the circular
> link), try the cmpxchg and fix it back up when it fails.
