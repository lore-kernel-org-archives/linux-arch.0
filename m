From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization
	for 2 contending tasks
Date: Thu, 27 Feb 2014 15:42:19 -0500
Message-ID: <530FA32B.8010202@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140226162057.GW6835@laptop.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org

On 02/26/2014 11:20 AM, Peter Zijlstra wrote:
> You don't happen to have a proper state diagram for this thing do you?
>
> I suppose I'm going to have to make one; this is all getting a bit
> unwieldy, and those xchg() + fixup things are hard to read.

I don't have a state diagram on hand, but I will add more comments to 
describe the 4 possible cases and how to handle them.

>
> On Wed, Feb 26, 2014 at 10:14:23AM -0500, Waiman Long wrote:
>> +static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
>> +{
>> +	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
>> +	u16		     old;
>> +
>> +	/*
>> +	 * Fall into the quick spinning code path only if no one is waiting
>> +	 * or the lock is available.
>> +	 */
>> +	if (unlikely((qsval != _QSPINLOCK_LOCKED)&&
>> +		     (qsval != _QSPINLOCK_WAITING)))
>> +		return 0;
>> +
>> +	old = xchg(&qlock->lock_wait, _QSPINLOCK_WAITING|_QSPINLOCK_LOCKED);
>> +
>> +	if (old == 0) {
>> +		/*
>> +		 * Got the lock, can clear the waiting bit now
>> +		 */
>> +		smp_u8_store_release(&qlock->wait, 0);
>
> So we just did an atomic op, and now you're trying to optimize this
> write. Why do you need a whole byte for that?
>
> Surely a cmpxchg loop with the right atomic op can't be _that_ much
> slower? Its far more readable and likely avoids that steal fail below as
> well.

At low contention level, atomic operations that requires a lock prefix 
are the major contributor to the total execution times. I saw estimate 
online that the time to execute a lock prefix instruction can easily be 
50X longer than a regular instruction that can be pipelined. That is why 
I try to do it with as few lock prefix instructions as possible. If I 
have to do an atomic cmpxchg, it probably won't be faster than the 
regular qspinlock slowpath.

Given that speed at low contention level which is the common case is 
important to get this patch accepted, I have to do what I can to make it 
run as far as possible for this 2 contending task case.

>> +		return 1;
>> +	} else if (old == _QSPINLOCK_LOCKED) {
>> +try_again:
>> +		/*
>> +		 * Wait until the lock byte is cleared to get the lock
>> +		 */
>> +		do {
>> +			cpu_relax();
>> +		} while (ACCESS_ONCE(qlock->lock));
>> +		/*
>> +		 * Set the lock bit&  clear the waiting bit
>> +		 */
>> +		if (cmpxchg(&qlock->lock_wait, _QSPINLOCK_WAITING,
>> +			   _QSPINLOCK_LOCKED) == _QSPINLOCK_WAITING)
>> +			return 1;
>> +		/*
>> +		 * Someone has steal the lock, so wait again
>> +		 */
>> +		goto try_again;
> That's just a fail.. steals should not ever be allowed. It's a fair lock
> after all.

The code is unfair, but this unfairness help it to run faster than 
ticket spinlock in this particular case. And the regular qspinlock 
slowpath is fair. A little bit of unfairness in this particular case 
helps its speed.

>> +	} else if (old == _QSPINLOCK_WAITING) {
>> +		/*
>> +		 * Another task is already waiting while it steals the lock.
>> +		 * A bit of unfairness here won't change the big picture.
>> +		 * So just take the lock and return.
>> +		 */
>> +		return 1;
>> +	}
>> +	/*
>> +	 * Nothing need to be done if the old value is
>> +	 * (_QSPINLOCK_WAITING | _QSPINLOCK_LOCKED).
>> +	 */
>> +	return 0;
>> +}
>
>
>
>> @@ -296,6 +478,9 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>>   		return;
>>   	}
>>
>> +#ifdef queue_code_xchg
>> +	prev_qcode = queue_code_xchg(lock, my_qcode);
>> +#else
>>   	/*
>>   	 * Exchange current copy of the queue node code
>>   	 */
>> @@ -329,6 +514,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>>   	} else
>>   		prev_qcode&= ~_QSPINLOCK_LOCKED;	/* Clear the lock bit */
>>   	my_qcode&= ~_QSPINLOCK_LOCKED;
>> +#endif /* queue_code_xchg */
>>
>>   	if (prev_qcode) {
>>   		/*
> That's just horrible.. please just make the entire #else branch another
> version of that same queue_code_xchg() function.

OK, I will wrap it in another function.

Regards,
Longman
