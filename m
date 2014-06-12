From: "Long, Wai Man" <waiman.long@hp.com>
Subject: Re: [PATCH v11 09/16] qspinlock, x86: Allow unfair spinlock in a
	virtual guest
Date: Wed, 11 Jun 2014 21:37:55 -0400
Message-ID: <53990473.7020802@hp.com>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-10-git-send-email-Waiman.Long@hp.com>
	<20140611105402.GL3213@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140611105402.GL3213@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org


On 6/11/2014 6:54 AM, Peter Zijlstra wrote:
> On Fri, May 30, 2014 at 11:43:55AM -0400, Waiman Long wrote:
>> Enabling this configuration feature causes a slight decrease the
>> performance of an uncontended lock-unlock operation by about 1-2%
>> mainly due to the use of a static key. However, uncontended lock-unlock
>> operation are really just a tiny percentage of a real workload. So
>> there should no noticeable change in application performance.
> No, entirely unacceptable.
>
>> +#ifdef CONFIG_VIRT_UNFAIR_LOCKS
>> +/**
>> + * queue_spin_trylock_unfair - try to acquire the queue spinlock unfairly
>> + * @lock : Pointer to queue spinlock structure
>> + * Return: 1 if lock acquired, 0 if failed
>> + */
>> +static __always_inline int queue_spin_trylock_unfair(struct qspinlock *lock)
>> +{
>> +	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
>> +
>> +	if (!qlock->locked && (cmpxchg(&qlock->locked, 0, _Q_LOCKED_VAL) == 0))
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * queue_spin_lock_unfair - acquire a queue spinlock unfairly
>> + * @lock: Pointer to queue spinlock structure
>> + */
>> +static __always_inline void queue_spin_lock_unfair(struct qspinlock *lock)
>> +{
>> +	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
>> +
>> +	if (likely(cmpxchg(&qlock->locked, 0, _Q_LOCKED_VAL) == 0))
>> +		return;
>> +	/*
>> +	 * Since the lock is now unfair, we should not activate the 2-task
>> +	 * pending bit spinning code path which disallows lock stealing.
>> +	 */
>> +	queue_spin_lock_slowpath(lock, -1);
>> +}
> Why is this needed?

I added the unfair version of lock and trylock as my original version 
isn't a simple test-and-set lock. Now I changed the core part to use the 
simple test-and-set lock. However, I still think that an unfair version 
in the fast path can be helpful to performance when both the unfair lock 
and paravirt spinlock are enabled. In this case, paravirt spinlock code 
will disable the unfair lock code in the slowpath, but still allow the 
unfair version in the fast path to get the best possible performance in 
a virtual guest.

Yes, I could take that out to allow either unfair or paravirt spinlock, 
but not both. I do think that a little bit of unfairness will help in 
the virtual environment.

>> +/*
>> + * Redefine arch_spin_lock and arch_spin_trylock as inline functions that will
>> + * jump to the unfair versions if the static key virt_unfairlocks_enabled
>> + * is true.
>> + */
>> +#undef arch_spin_lock
>> +#undef arch_spin_trylock
>> +#undef arch_spin_lock_flags
>> +
>> +/**
>> + * arch_spin_lock - acquire a queue spinlock
>> + * @lock: Pointer to queue spinlock structure
>> + */
>> +static inline void arch_spin_lock(struct qspinlock *lock)
>> +{
>> +	if (static_key_false(&virt_unfairlocks_enabled))
>> +		queue_spin_lock_unfair(lock);
>> +	else
>> +		queue_spin_lock(lock);
>> +}
>> +
>> +/**
>> + * arch_spin_trylock - try to acquire the queue spinlock
>> + * @lock : Pointer to queue spinlock structure
>> + * Return: 1 if lock acquired, 0 if failed
>> + */
>> +static inline int arch_spin_trylock(struct qspinlock *lock)
>> +{
>> +	if (static_key_false(&virt_unfairlocks_enabled))
>> +		return queue_spin_trylock_unfair(lock);
>> +	else
>> +		return queue_spin_trylock(lock);
>> +}
> So I really don't see the point of all this? Why do you need special
> {try,}lock paths for this case? Are you worried about the upper 24bits?

No, as I said above. I was planning for the coexistence of unfair lock 
in the fast path and paravirt spinlock in the slowpath.

>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index ae1b19d..3723c83 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -217,6 +217,14 @@ static __always_inline int try_set_locked(struct qspinlock *lock)
>>   {
>>   	struct __qspinlock *l = (void *)lock;
>>   
>> +#ifdef CONFIG_VIRT_UNFAIR_LOCKS
>> +	/*
>> +	 * Need to use atomic operation to grab the lock when lock stealing
>> +	 * can happen.
>> +	 */
>> +	if (static_key_false(&virt_unfairlocks_enabled))
>> +		return cmpxchg(&l->locked, 0, _Q_LOCKED_VAL) == 0;
>> +#endif
>>   	barrier();
>>   	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
>>   	barrier();
> Why? If we have a simple test-and-set lock like below, we'll never get
> here at all.

Again, it is due the coexistence of unfair lock in fast path and 
paravirt spinlock in the slowpath.

>> @@ -252,6 +260,18 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>   
>>   	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
>>   
>> +#ifdef CONFIG_VIRT_UNFAIR_LOCKS
>> +	/*
>> +	 * A simple test and set unfair lock
>> +	 */
>> +	if (static_key_false(&virt_unfairlocks_enabled)) {
>> +		cpu_relax();	/* Relax after a failed lock attempt */
> Meh, I don't think anybody can tell the difference if you put that in or
> not, therefore don't.

Yes, I can take out the cpu_relax() here.

-Longman
