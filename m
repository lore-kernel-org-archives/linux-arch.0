From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v3 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Thu, 30 Jan 2014 11:00:30 -0800
Message-ID: <1391108430.3138.86.camel@schen9-DESK>
References: <1390933151-1797-1-git-send-email-Waiman.Long@hp.com>
	 <1390933151-1797-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20663 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbaA3TAd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Jan 2014 14:00:33 -0500
In-Reply-To: <1390933151-1797-2-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On Tue, 2014-01-28 at 13:19 -0500, Waiman Long wrote:

> +/**
> + * queue_spin_lock_slowpath - acquire the queue spinlock
> + * @lock: Pointer to queue spinlock structure
> + */
> +void queue_spin_lock_slowpath(struct qspinlock *lock)
> +{
> +	unsigned int cpu_nr, qn_idx;
> +	struct qnode *node, *next = NULL;
> +	u32 prev_qcode, my_qcode;
> +
> +	/*
> +	 * Get the queue node
> +	 */
> +	cpu_nr = smp_processor_id();
> +	node   = this_cpu_ptr(&qnodes[0]);
> +	qn_idx = 0;
> +
> +	if (unlikely(node->used)) {
> +		/*
> +		 * This node has been used, try to find an empty queue
> +		 * node entry.
> +		 */
> +		for (qn_idx = 1; qn_idx < MAX_QNODES; qn_idx++)
> +			if (!node[qn_idx].used)
> +				break;
> +		if (unlikely(qn_idx == MAX_QNODES)) {
> +			/*
> +			 * This shouldn't happen, print a warning message
> +			 * & busy spinning on the lock.
> +			 */
> +			printk_sched(
> +			  "qspinlock: queue node table exhausted at cpu %d!\n",
> +			  cpu_nr);
> +			while (!unfair_trylock(lock))
> +				arch_mutex_cpu_relax();
> +			return;
> +		}
> +		/* Adjust node pointer */
> +		node += qn_idx;
> +	}
> +
> +	/*
> +	 * Set up the new cpu code to be exchanged
> +	 */
> +	my_qcode = SET_QCODE(cpu_nr, qn_idx);
> +

If we get interrupted here before we have a chance to set the used flag,
the interrupt handler could pick up the same qnode if it tries to
acquire queued spin lock.  Then we could overwrite the qcode we have set
here.

Perhaps an exchange operation for the used flag to prevent this race
condition?

Tim

> +	/*
> +	 * The lock may be available at this point, try again before waiting
> +	 * in a queue.
> +	 */
> +	if (queue_spin_trylock(lock))
> +		return;
> +
> +	/*
> +	 * Initialize the queue node
> +	 */
> +	init_node(node, lock, cpu_nr);
> +
> +	/*
> +	 * Exchange current copy of the queue node code
> +	 */
> +	prev_qcode = xchg(&lock->qlcode, my_qcode);
> +	/*
> +	 * It is possible that we may accidentally steal the lock. If this is
> +	 * the case, we need to either release it if not the head of the queue
> +	 * or get the lock and be done with it.
> +	 */
> +	if (unlikely(!(prev_qcode & _QSPINLOCK_LOCKED))) {
> +		if (prev_qcode == 0) {
> +			/*
> +			 * Got the lock since it is at the head of the queue
> +			 * Now try to atomically clear the queue code.
> +			 */
> +			if (cmpxchg(&lock->qlcode, my_qcode, _QSPINLOCK_LOCKED)
> +				== my_qcode)
> +				goto release_node;
> +			/*
> +			 * The cmpxchg fails only if one or more processes
> +			 * are added to the queue. In this case, we need to
> +			 * notify the next one to be the head of the queue.
> +			 */
> +			goto notify_next;
> +		}
> +		/*
> +		 * Accidentally steal the lock, release the lock and
> +		 * let the queue head get it.
> +		 */
> +		queue_spin_unlock(lock);
> +	} else
> +		prev_qcode &= ~_QSPINLOCK_LOCKED;	/* Clear the lock bit */
> +	my_qcode &= ~_QSPINLOCK_LOCKED;
> +
> +	if (prev_qcode) {
> +		/*
> +		 * Not at the queue head, get the address of the previous node
> +		 * and set up the "next" fields of the that node.
> +		 */
> +		struct qnode *prev = xlate_qcode(prev_qcode);
> +
> +		assert_prevnode(prev, lock, cpu_nr);
> +		ACCESS_ONCE(prev->next) = node;
> +		/*
> +		 * Wait until the waiting flag is off
> +		 */
> +		while (smp_load_acquire(&node->wait))
> +			arch_mutex_cpu_relax();
> +	}
> +
> +	/*
> +	 * At the head of the wait queue now
> +	 */
> +	while (true) {
> +		u32 qcode;
> +
> +		if (unlikely(!next)) {
> +			/*
> +			 * Try to get the next node address & clean up
> +			 * current node data structure now if the next node
> +			 * address had been set.
> +			 */
> +			next = ACCESS_ONCE(node->next);
> +			if (next) {
> +				assert_nextnode(next, lock, cpu_nr);
> +				cleanup_node(node, cpu_nr);
> +				node = NULL;
> +			}
> +		}
> +		qcode = ACCESS_ONCE(lock->qlcode);
> +		if (qcode & _QSPINLOCK_LOCKED)
> +			;	/* Lock not available yet */
> +		else if (qcode != my_qcode) {
> +			/*
> +			 * Just get the lock with other spinners waiting
> +			 * in the queue.
> +			 */
> +			if (unfair_trylock(lock))
> +				/* May still need to notify the next node */
> +				goto notify_next;
> +		} else {
> +			/*
> +			 * Get the lock & clear the queue code simultaneously
> +			 */
> +			if (cmpxchg(&lock->qlcode, my_qcode,
> +				    _QSPINLOCK_LOCKED) == my_qcode)
> +				/* No need to notify next one */
> +				goto release_node;
> +		}
> +		arch_mutex_cpu_relax();
> +	}
> +
> +notify_next:
> +	/*
> +	 * If the next pointer is not set, we need to wait and notify the
> +	 * next one in line to do busy spinning.
> +	 */
> +	if (unlikely(!next)) {
> +		/*
> +		 * Wait until the next one in queue set up the next field
> +		 */
> +		while (!(next = ACCESS_ONCE(node->next)))
> +			arch_mutex_cpu_relax();
> +		assert_nextnode(next, lock, cpu_nr);
> +	}
> +	/*
> +	 * The next one in queue is now at the head
> +	 */
> +	smp_store_release(&next->wait, false);
> +
> +release_node:
> +	if (node)
> +		cleanup_node(node, cpu_nr);
> +}
> +EXPORT_SYMBOL(queue_spin_lock_slowpath);
