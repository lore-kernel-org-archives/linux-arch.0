Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJVZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Apr 2019 05:21:25 -0400
Date: Mon, 1 Apr 2019 11:21:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190401092115.GH11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190401092115.QHCQe1zquNA5HOkWtAbSRF9c52Dat0r5nfdy8CheuoQ@z>

On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
> +static inline void pass_mcs_lock(struct mcs_spinlock *node,
> +				 struct mcs_spinlock *next)
> +{
> +	struct mcs_spinlock *succ = NULL;
> +
> +	succ = find_successor(node);
> +
> +	if (succ) {
> +		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
> +	} else if (node->locked > 1) {
> +		/*
> +		 * If the secondary queue is not empty, pass the lock
> +		 * to the first node in that queue.
> +		 */
> +		succ = MCS_NODE(node->locked);
> +		succ->tail->next = next;
> +		arch_mcs_spin_unlock_contended(&succ->locked, 1);
> +	} else {
> +		/*
> +		 * Otherwise, pass the lock to the immediate successor
> +		 * in the main queue.
> +		 */
> +		arch_mcs_spin_unlock_contended(&next->locked, 1);
> +	}
> +}

Note that something like:

static inline void
pass_mcs_lock(struct mcs_spinlock *node, struct mcs_spinlock *next)
{
	struct mcs_spinlock *succ = NULL;
	uintptr_t *var = &next->locked;
	uintptr_t val = 1;

	succ = find_successor(node);
	if (succ) {
		var = &succ->locked;
		val = node->locked;
	} else if (node->locked > 1) {
		succ = MCS_NODE(node->locked);
		succ->tail->next = next; /* WRITE_ONCE() !?!? */
		var = &node->locked;
	}

	arch_mcs_spin_unlock_contended(var, val);
}

is shorter and generates much better code if
arch_mcs_spin_unlock_contended() is asm volatile ().
