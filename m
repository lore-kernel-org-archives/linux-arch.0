Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37630 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfGQPJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 11:09:47 -0400
Date: Wed, 17 Jul 2019 17:09:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190717150913.GY3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
 <20190717083944.GR3463@hirez.programming.kicks-ass.net>
 <FFC2D45A-24B3-40E1-ABBB-1D696E830B23@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FFC2D45A-24B3-40E1-ABBB-1D696E830B23@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717150913.DtOyeh8zBOaE1ut49dSHbOS0qsZLF0bnXnfEWVWNsxA@z>

On Wed, Jul 17, 2019 at 10:27:30AM -0400, Alex Kogan wrote:
> > On Jul 17, 2019, at 4:39 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > static void cna_splice_tail(struct cna_node *cn, struct cna_node *head, struct cna_node *tail)
> > {
> > 	struct cna_node *list;
> > 
> > 	/* remove [head,tail] */
> > 	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
> > 	tail->mcs.next = NULL;
> > 
> > 	/* stick [head,tail] on the secondary list tail */
> > 	if (cn->mcs.locked <= 1) {
> > 		/* create secondary list */
> > 		head->tail = tail;
> > 		cn->mcs.locked = head->encoded_tail;
> > 	} else {
> > 		/* add to tail */
> > 		list = (struct cna_node *)decode_tail(cn->mcs.locked);
> > 		list->tail->next = head;
> > 		list->tail = tail;
> > 	}
> > }
> > 
> > static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> > {
> > 	struct cna_node *cni, *cn = (struct cna_node *)node;
> > 	struct cna_node *head, *tail = NULL;
> > 
> > 	/* find any next lock from 'our' node */
> > 	for (head = cni = (struct cna_node *)READ_ONCE(cn->mcs.next);
> > 	     cni && cni->node != cn->node;
> > 	     tail = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> > 		;
> > 
> > 	/* when found, splice any skipped locks onto the secondary list */
> > 	if (cni && tail)
> > 		cna_splice_tail(cn, head, tail);
> > 
> > 	return cni;
> > }
> > 
> > How's that?
> 
> This is almost perfect!! :)
> 
> The above should work, but I think we should have a specialized fast-path for 
> checking the immediate next node in the main queue. This would be the common
> case, once we splice ‘other’ nodes onto the secondary queue. In the above we
> would go through four branches before returning from cna_find_next(). In the 
> following we would have just one:

Right, but can you measure a difference? ;-) Anyway, no real objection,
just playing devils advocate here.

> > static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> > {
> > 	struct cna_node *cn = (struct cna_node *)node;
> 	   struct cna_node *cni = (struct cna_node *)READ_ONCE(cn->mcs.next);
> > 
> > 	struct cna_node *head, *tail = NULL;
> > 
> 	   /* fast path */
> 	   if (cni->node == cn->node) 
> 		return cni;
> 
> > 	/* find any next lock from 'our' node */
> > 	for (head = cn->mcs.next;
	     head = cni,

you just did that load :-)

> > 	     cni && cni->node != cn->node;
> > 	     tail = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> > 		;
> > 
> > 	/* when found, splice any skipped locks onto the secondary list */
> > 	if (cni && tail)
> > 		cna_splice_tail(cn, head, tail);
> > 
> > 	return cni;
> > }
> 
> 
> Also, any reason you say ‘lock’ instead of ’node’ in the comments?
> I.e., I think "when found, splice any skipped locks onto the secondary list” should be
> "when found, splice any skipped nodes onto the secondary list”.

Due to the confusion between lock waiter node and numa node :-)
