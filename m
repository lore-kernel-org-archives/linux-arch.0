Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQI7R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 04:59:17 -0400
Date: Wed, 17 Jul 2019 10:59:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190717085900.GS3463@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
 <20190717083944.GR3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717083944.GR3463@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717085900.q4keMVeaU7X2OS5Xh7RMjq2EjRaDbKfDjzcaN3OrBzo@z>

On Wed, Jul 17, 2019 at 10:39:44AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 08:47:24PM +0200, Peter Zijlstra wrote:

> > My primary concern was readability; I find the above suggestion much
> > more readable. Maybe it can be written differently; you'll have to play
> > around a bit.
> 
> static void cna_splice_tail(struct cna_node *cn, struct cna_node *head, struct cna_node *tail)
> {
> 	struct cna_node *list;
> 
> 	/* remove [head,tail] */
> 	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
> 	tail->mcs.next = NULL;
> 
> 	/* stick [head,tail] on the secondary list tail */
> 	if (cn->mcs.locked <= 1) {
> 		/* create secondary list */
> 		head->tail = tail;
> 		cn->mcs.locked = head->encoded_tail;
> 	} else {
> 		/* add to tail */
> 		list = (struct cna_node *)decode_tail(cn->mcs.locked);
> 		list->tail->next = head;
> 		list->tail = tail;
> 	}
> }
> 
> static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> {
> 	struct cna_node *cni, *cn = (struct cna_node *)node;
> 	struct cna_node *head, *tail = NULL;
> 
> 	/* find any next lock from 'our' node */
> 	for (head = cni = (struct cna_node *)READ_ONCE(cn->mcs.next);
> 	     cni && cni->node != cn->node;
> 	     tail = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> 		;

I think we can do away with those READ_ONCE()s, at this point those
pointers should be stable. But please double check.

> 	/* when found, splice any skipped locks onto the secondary list */
> 	if (cni && tail)
> 		cna_splice_tail(cn, head, tail);
> 
> 	return cni;
> }
> 
> How's that?
