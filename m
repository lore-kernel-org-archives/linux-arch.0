From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 1/8] qspinlock: Introducing a 4-byte
	queue spinlock	implementation
Date: Sun, 2 Mar 2014 14:12:28 +0100
Message-ID: <20140302131228.GA13206@redhat.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <1393475567-4453-2-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel
List-Id: linux-arch.vger.kernel.org

On 02/26, Waiman Long wrote:
>
> +void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
> +{
> +	unsigned int cpu_nr, qn_idx;
> +	struct qnode *node, *next;
> +	u32 prev_qcode, my_qcode;
> +
> +	/*
> +	 * Get the queue node
> +	 */
> +	cpu_nr = smp_processor_id();
> +	node   = get_qnode(&qn_idx);
> +
> +	/*
> +	 * It should never happen that all the queue nodes are being used.
> +	 */
> +	BUG_ON(!node);
> +
> +	/*
> +	 * Set up the new cpu code to be exchanged
> +	 */
> +	my_qcode = queue_encode_qcode(cpu_nr, qn_idx);
> +
> +	/*
> +	 * Initialize the queue node
> +	 */
> +	node->wait = true;
> +	node->next = NULL;
> +
> +	/*
> +	 * The lock may be available at this point, try again if no task was
> +	 * waiting in the queue.
> +	 */
> +	if (!(qsval >> _QCODE_OFFSET) && queue_spin_trylock(lock)) {
> +		put_qnode();
> +		return;
> +	}

Cosmetic, but probably "goto release_node" would be more consistent.

And I am wondering how much this "qsval >> _QCODE_OFFSET" check can help.
Note that this is the only usage of this arg, perhaps it would be better
to simply remove it and shrink the caller's code a bit? It is also used
in 3/8, but we can read the "fresh" value of ->qlcode (trylock does this
anyway), and perhaps it can actually help if it is already unlocked.

> +	prev_qcode = atomic_xchg(&lock->qlcode, my_qcode);
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
> +			if (atomic_cmpxchg(&lock->qlcode, my_qcode,
> +					  _QSPINLOCK_LOCKED) == my_qcode)
> +				goto release_node;
> +			/*
> +			 * The cmpxchg fails only if one or more tasks
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

You know, actually I started this email because I thought that "goto notify_next"
is wrong, I misread the patch as if this "goto" can happen even if prev_qcode != 0.

So feel free to ignore, all my comments are cosmetic/subjective, but to me it
would be more clean/clear to rewrite the code above as

	if (prev_qcode == 0) {
		if (atomic_cmpxchg(..., _QSPINLOCK_LOCKED) == my_qcode)
			goto release_node;
		goto notify_next;
	}

	if (prev_qcode & _QSPINLOCK_LOCKED)
		prev_qcode &= ~_QSPINLOCK_LOCKED;
	else
		queue_spin_unlock(lock);


> +	while (true) {
> +		u32 qcode;
> +		int retval;
> +
> +		retval = queue_get_lock_qcode(lock, &qcode, my_qcode);
> +		if (retval > 0)
> +			;	/* Lock not available yet */
> +		else if (retval < 0)
> +			/* Lock taken, can release the node & return */
> +			goto release_node;

I guess this is for 3/8which adds the optimized version of
queue_get_lock_qcode(), so perhaps this "retval < 0" block can go into 3/8
as well.

> +		else if (qcode != my_qcode) {
> +			/*
> +			 * Just get the lock with other spinners waiting
> +			 * in the queue.
> +			 */
> +			if (queue_spin_setlock(lock))
> +				goto notify_next;

OTOH, at least the generic (non-optimized) version of queue_spin_setlock()
could probably accept "qcode" and avoid atomic_read() + _QSPINLOCK_LOCKED
check.

But once again, please feel free to ignore.

Oleg.
