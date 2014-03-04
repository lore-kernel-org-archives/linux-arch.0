From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 1/8] qspinlock: Introducing a 4-byte queue spinlock
	implementation
Date: Tue, 04 Mar 2014 09:46:25 -0500
Message-ID: <5315E741.2000205@hp.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-2-git-send-email-Waiman.Long@hp.com>
	<20140302131228.GA13206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140302131228.GA13206@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: linux-arch.vger.kernel.org

On 03/02/2014 08:12 AM, Oleg Nesterov wrote:
> On 02/26, Waiman Long wrote:
>> +void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>> +{
>> +	unsigned int cpu_nr, qn_idx;
>> +	struct qnode *node, *next;
>> +	u32 prev_qcode, my_qcode;
>> +
>> +	/*
>> +	 * Get the queue node
>> +	 */
>> +	cpu_nr = smp_processor_id();
>> +	node   = get_qnode(&qn_idx);
>> +
>> +	/*
>> +	 * It should never happen that all the queue nodes are being used.
>> +	 */
>> +	BUG_ON(!node);
>> +
>> +	/*
>> +	 * Set up the new cpu code to be exchanged
>> +	 */
>> +	my_qcode = queue_encode_qcode(cpu_nr, qn_idx);
>> +
>> +	/*
>> +	 * Initialize the queue node
>> +	 */
>> +	node->wait = true;
>> +	node->next = NULL;
>> +
>> +	/*
>> +	 * The lock may be available at this point, try again if no task was
>> +	 * waiting in the queue.
>> +	 */
>> +	if (!(qsval>>  _QCODE_OFFSET)&&  queue_spin_trylock(lock)) {
>> +		put_qnode();
>> +		return;
>> +	}
> Cosmetic, but probably "goto release_node" would be more consistent.

Yes, that is true.

> And I am wondering how much this "qsval>>  _QCODE_OFFSET" check can help.
> Note that this is the only usage of this arg, perhaps it would be better
> to simply remove it and shrink the caller's code a bit? It is also used
> in 3/8, but we can read the "fresh" value of ->qlcode (trylock does this
> anyway), and perhaps it can actually help if it is already unlocked.

First of all, there is no shrinkage in the caller code even if the qsval 
argument is removed, at least for x86. The caller just targets the 
return register of the cmpxchg instruction to be the 2nd function 
parameter register.

When the lock is lightly contended, there isn't much difference on 
whether to check qsval or a fresh copy of qlcode. However, when the lock 
is heavily contended, every additional read or write will contribute to 
the cacheline bouncing traffic. The code was written to minimize those 
optional read request.

>> +	prev_qcode = atomic_xchg(&lock->qlcode, my_qcode);
>> +	/*
>> +	 * It is possible that we may accidentally steal the lock. If this is
>> +	 * the case, we need to either release it if not the head of the queue
>> +	 * or get the lock and be done with it.
>> +	 */
>> +	if (unlikely(!(prev_qcode&  _QSPINLOCK_LOCKED))) {
>> +		if (prev_qcode == 0) {
>> +			/*
>> +			 * Got the lock since it is at the head of the queue
>> +			 * Now try to atomically clear the queue code.
>> +			 */
>> +			if (atomic_cmpxchg(&lock->qlcode, my_qcode,
>> +					  _QSPINLOCK_LOCKED) == my_qcode)
>> +				goto release_node;
>> +			/*
>> +			 * The cmpxchg fails only if one or more tasks
>> +			 * are added to the queue. In this case, we need to
>> +			 * notify the next one to be the head of the queue.
>> +			 */
>> +			goto notify_next;
>> +		}
>> +		/*
>> +		 * Accidentally steal the lock, release the lock and
>> +		 * let the queue head get it.
>> +		 */
>> +		queue_spin_unlock(lock);
>> +	} else
>> +		prev_qcode&= ~_QSPINLOCK_LOCKED;	/* Clear the lock bit */
> You know, actually I started this email because I thought that "goto notify_next"
> is wrong, I misread the patch as if this "goto" can happen even if prev_qcode != 0.
>
> So feel free to ignore, all my comments are cosmetic/subjective, but to me it
> would be more clean/clear to rewrite the code above as
>
> 	if (prev_qcode == 0) {
> 		if (atomic_cmpxchg(..., _QSPINLOCK_LOCKED) == my_qcode)
> 			goto release_node;
> 		goto notify_next;
> 	}
>
> 	if (prev_qcode&  _QSPINLOCK_LOCKED)
> 		prev_qcode&= ~_QSPINLOCK_LOCKED;
> 	else
> 		queue_spin_unlock(lock);
>

This part of the code cause confusion and make it harder to read. I am 
planning to rewrite it to use cmpxchg to make sure that it won't 
accidentally steal the lock. That should make the code easier to 
understand and make it possible to write better optimized code in other 
part of the function.

>> +	while (true) {
>> +		u32 qcode;
>> +		int retval;
>> +
>> +		retval = queue_get_lock_qcode(lock,&qcode, my_qcode);
>> +		if (retval>  0)
>> +			;	/* Lock not available yet */
>> +		else if (retval<  0)
>> +			/* Lock taken, can release the node&  return */
>> +			goto release_node;
> I guess this is for 3/8which adds the optimized version of
> queue_get_lock_qcode(), so perhaps this "retval<  0" block can go into 3/8
> as well.
>

Yes, that is true.

>> +		else if (qcode != my_qcode) {
>> +			/*
>> +			 * Just get the lock with other spinners waiting
>> +			 * in the queue.
>> +			 */
>> +			if (queue_spin_setlock(lock))
>> +				goto notify_next;
> OTOH, at least the generic (non-optimized) version of queue_spin_setlock()
> could probably accept "qcode" and avoid atomic_read() + _QSPINLOCK_LOCKED
> check.
>

Will do so.

Thank for the comments.

-Longman
