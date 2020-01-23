Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:60352 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWJBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 04:01:11 -0500
Date: Thu, 23 Jan 2020 10:00:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123090038.GD14946@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
 <20200122170456.GY14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122170456.GY14879@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20200123090038.AkA0R6dsmhAM8JoAeSCwi2CWVbo4QC_36EMaLhh9ZHU@z>

On Wed, Jan 22, 2020 at 06:04:56PM +0100, Peter Zijlstra wrote:
> +/*
> + * cna_splice_head -- splice the entire secondary queue onto the head of the
> + * primary queue.
> + */
> +static cna_splice_head(struct qspinlock *lock, u32 val,
> +		       struct mcs_spinlock *node, struct mcs_spinlock *next)
> +{
> +	struct mcs_spinlock *head_2nd, *tail_2nd;
> +
> +	tail_2nd = decode_tail(node->locked);
> +	head_2nd = tail_2nd->next;
> +
> +	if (lock) {

That should be: if (!next) {

> +		u32 new = ((struct cna_node *)tail_2nd)->encoded_tail | _Q_LOCKED_VAL;
> +		if (!atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
> +			return NULL;
> +
> +		/*
> +		 * The moment we've linked the primary tail we can race with
> +		 * the WRITE_ONCE(prev->next, node) store from new waiters.
> +		 * That store must win.
> +		 */

And that still is a shit comment; I'll go try again.

> +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, next);
> +	} else {
> +		tail_2nd->next = next;
> +	}
> +
> +	return head_2nd;
> +}
