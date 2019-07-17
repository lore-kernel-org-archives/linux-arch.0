Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfGQIkB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 04:40:01 -0400
Date: Wed, 17 Jul 2019 10:39:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190717083944.GR3463@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716184724.GH3402@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717083944.Wz5ay_-C0vdad2IXxcswMitjF1Jdvt4WUOg40swUuP4@z>

On Tue, Jul 16, 2019 at 08:47:24PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 01:19:16PM -0400, Alex Kogan wrote:
> > > On Jul 16, 2019, at 11:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > static void cna_move(struct cna_node *cn, struct cna_node *cni)
> > > {
> > > 	struct cna_node *head, *tail;
> > > 
> > > 	/* remove @cni */
> > > 	WRITE_ONCE(cn->mcs.next, cni->mcs.next);
> > > 
> > > 	/* stick @cni on the 'other' list tail */
> > > 	cni->mcs.next = NULL;
> > > 
> > > 	if (cn->mcs.locked <= 1) {
> > > 		/* head = tail = cni */
> > > 		head = cni;
> > > 		head->tail = cni;
> > > 		cn->mcs.locked = head->encoded_tail;
> > > 	} else {
> > > 		/* add to tail */
> > > 		head = (struct cna_node *)decode_tail(cn->mcs.locked);
> > > 		tail = tail->tail;
> > > 		tail->next = cni;
> > > 	}
> > > }
> > > 
> > > static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> > > {
> > > 	struct cna_node *cni, *cn = (struct cna_node *)node;
> > > 
> > > 	while ((cni = (struct cna_node *)READ_ONCE(cn->mcs.next))) {
> > > 		if (likely(cni->node == cn->node))
> > > 			break;
> > > 
> > > 		cna_move(cn, cni);
> > > 	}
> > > 
> > > 	return cni;
> > > }
> > But then you move nodes from the main list to the ‘other’ list one-by-one.
> > I’m afraid this would be unnecessary expensive.
> > Plus, all this extra work is wasted if you do not find a thread on the same 
> > NUMA node (you move everyone to the ‘other’ list only to move them back in 
> > cna_mcs_pass_lock()).
> 
> My primary concern was readability; I find the above suggestion much
> more readable. Maybe it can be written differently; you'll have to play
> around a bit.

static void cna_splice_tail(struct cna_node *cn, struct cna_node *head, struct cna_node *tail)
{
	struct cna_node *list;

	/* remove [head,tail] */
	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
	tail->mcs.next = NULL;

	/* stick [head,tail] on the secondary list tail */
	if (cn->mcs.locked <= 1) {
		/* create secondary list */
		head->tail = tail;
		cn->mcs.locked = head->encoded_tail;
	} else {
		/* add to tail */
		list = (struct cna_node *)decode_tail(cn->mcs.locked);
		list->tail->next = head;
		list->tail = tail;
	}
}

static struct cna_node *cna_find_next(struct mcs_spinlock *node)
{
	struct cna_node *cni, *cn = (struct cna_node *)node;
	struct cna_node *head, *tail = NULL;

	/* find any next lock from 'our' node */
	for (head = cni = (struct cna_node *)READ_ONCE(cn->mcs.next);
	     cni && cni->node != cn->node;
	     tail = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
		;

	/* when found, splice any skipped locks onto the secondary list */
	if (cni && tail)
		cna_splice_tail(cn, head, tail);

	return cni;
}

How's that?
