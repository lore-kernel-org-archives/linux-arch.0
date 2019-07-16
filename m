Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGPSrn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 14:47:43 -0400
Date: Tue, 16 Jul 2019 20:47:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190716184724.GH3402@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190716184724.SPoTFVpeSZSOlBvcBerskt_ClqXvgxXK_JIcVjuMtVQ@z>

On Tue, Jul 16, 2019 at 01:19:16PM -0400, Alex Kogan wrote:
> > On Jul 16, 2019, at 11:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > static void cna_move(struct cna_node *cn, struct cna_node *cni)
> > {
> > 	struct cna_node *head, *tail;
> > 
> > 	/* remove @cni */
> > 	WRITE_ONCE(cn->mcs.next, cni->mcs.next);
> > 
> > 	/* stick @cni on the 'other' list tail */
> > 	cni->mcs.next = NULL;
> > 
> > 	if (cn->mcs.locked <= 1) {
> > 		/* head = tail = cni */
> > 		head = cni;
> > 		head->tail = cni;
> > 		cn->mcs.locked = head->encoded_tail;
> > 	} else {
> > 		/* add to tail */
> > 		head = (struct cna_node *)decode_tail(cn->mcs.locked);
> > 		tail = tail->tail;
> > 		tail->next = cni;
> > 	}
> > }
> > 
> > static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> > {
> > 	struct cna_node *cni, *cn = (struct cna_node *)node;
> > 
> > 	while ((cni = (struct cna_node *)READ_ONCE(cn->mcs.next))) {
> > 		if (likely(cni->node == cn->node))
> > 			break;
> > 
> > 		cna_move(cn, cni);
> > 	}
> > 
> > 	return cni;
> > }
> But then you move nodes from the main list to the ‘other’ list one-by-one.
> I’m afraid this would be unnecessary expensive.
> Plus, all this extra work is wasted if you do not find a thread on the same 
> NUMA node (you move everyone to the ‘other’ list only to move them back in 
> cna_mcs_pass_lock()).

My primary concern was readability; I find the above suggestion much
more readable. Maybe it can be written differently; you'll have to play
around a bit.

> >> +static inline bool cna_set_locked_empty_mcs(struct qspinlock *lock, u32 val,
> >> +					struct mcs_spinlock *node)
> >> +{
> >> +	/* Check whether the secondary queue is empty. */
> >> +	if (node->locked <= 1) {
> >> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val,
> >> +				_Q_LOCKED_VAL))
> >> +			return true; /* No contention */
> >> +	} else {
> >> +		/*
> >> +		 * Pass the lock to the first thread in the secondary
> >> +		 * queue, but first try to update the queue's tail to
> >> +		 * point to the last node in the secondary queue.
> > 
> > 
> > That comment doesn't make sense; there's at least one conditional
> > missing.
> In CNA, we cannot just clear the tail when the MCS chain is empty, as 
> there might be nodes in the ‘other’ chain. In that case (this is the “else” part),
> we want to pass the lock to the first node in the ‘other’ chain, but 
> first we need to put the last node from that chain into the tail. Perhaps the
> comment should read “…  but first try to update the *primary* queue's tail …”, 
> if that makes more sense.

It is 'try and pass the lock' at best. It is not a
definite/unconditional thing we're doing.

> >> +		 */
> >> +		struct cna_node *succ = CNA_NODE(node->locked);
> >> +		u32 new = succ->tail->encoded_tail + _Q_LOCKED_VAL;
> >> +
> >> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> >> +			arch_mcs_spin_unlock_contended(&succ->mcs.locked, 1);
> >> +			return true;
> >> +		}
> >> +	}
> >> +
> >> +	return false;
> >> +}

> >> +static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
> >> +				     struct mcs_spinlock *next)
> >> +{
> >> +	struct cna_node *succ = NULL;
> >> +	u64 *var = &next->locked;
> >> +	u64 val = 1;
> >> +
> >> +	succ = find_successor(node);
> >> +
> >> +	if (succ) {
> >> +		var = &succ->mcs.locked;
> >> +		/*
> >> +		 * We unlock a successor by passing a non-zero value,
> >> +		 * so set @val to 1 iff @locked is 0, which will happen
> >> +		 * if we acquired the MCS lock when its queue was empty
> >> +		 */
> >> +		val = node->locked + (node->locked == 0);
> >> +	} else if (node->locked > 1) { /* if the secondary queue is not empty */
> >> +		/* pass the lock to the first node in that queue */
> >> +		succ = CNA_NODE(node->locked);
> >> +		succ->tail->mcs.next = next;
> >> +		var = &succ->mcs.locked;
> > 
> >> +	}	/*
> >> +		 * Otherwise, pass the lock to the immediate successor
> >> +		 * in the main queue.
> >> +		 */
> > 
> > I don't think this mis-indented comment can happen. The call-site
> > guarantees @next is non-null.
> > 
> > Therefore, cna_find_next() will either return it, or place it on the
> > secondary list. If it (cna_find_next) returns NULL, we must have a
> > non-empty secondary list.
> > 
> > In no case do I see this tertiary condition being possible.
> find_successor() will return NULL if it does not find a thread running on the 
> same NUMA node. And the secondary queue might be empty at that time.

See; I couldn't untangle that case from the code. Means readablilty
needs improving.
