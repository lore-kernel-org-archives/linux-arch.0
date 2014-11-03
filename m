From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v13 09/11] pvqspinlock,
	x86: Add para-virtualization support
Date: Mon, 03 Nov 2014 16:17:39 -0500
Message-ID: <5457F0F3.5080008@hp.com>
References: <1414613951-32532-1-git-send-email-Waiman.Long@hp.com>
	<1414613951-32532-10-git-send-email-Waiman.Long@hp.com>
	<20141103103505.GZ23531@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141103103505.GZ23531@worktop.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On 11/03/2014 05:35 AM, Peter Zijlstra wrote:
> On Wed, Oct 29, 2014 at 04:19:09PM -0400, Waiman Long wrote:
>>   arch/x86/include/asm/pvqspinlock.h    |  411 +++++++++++++++++++++++++++++++++
> I do wonder why all this needs to live in x86..
>

I haven't looked into the para-virtualization code in other 
architectures to see if my PV code is equally applicable there. That is 
why I put it under the x86 directory. If other architectures decide to 
use qspinlock with paravirtualization, we may need to pull out some 
common code, if any, back to kernel/locking.

>>
>> +#ifdef CONFIG_QUEUE_SPINLOCK
>> +
>> +static __always_inline void pv_kick_cpu(int cpu)
>> +{
>> +	PVOP_VCALLEE1(pv_lock_ops.kick_cpu, cpu);
>> +}
>> +
>> +static __always_inline void pv_lockwait(u8 *lockbyte)
>> +{
>> +	PVOP_VCALLEE1(pv_lock_ops.lockwait, lockbyte);
>> +}
>> +
>> +static __always_inline void pv_lockstat(enum pv_lock_stats type)
>> +{
>> +	PVOP_VCALLEE1(pv_lock_ops.lockstat, type);
>> +}
> Why are any of these PV ops? they're only called from other pv_*()
> functions. What's the point of pv ops you only call from pv code?

It is the same reason that you made them PV ops in your patch. Even when 
PV is on, the code won't need to call any of the PV ops most of the 
time. So it is just a matter of optimizing the most common case at the 
expense of performance in the rare case that the CPU need to be halt and 
woken up which will be bad performance-wise anyway However, if you think 
they should be regular function pointers, I am fine with that too.

>> +/*
>> + *	Queue Spinlock Para-Virtualization (PV) Support
>> + *
>> + * The PV support code for queue spinlock is roughly the same as that
>> + * of the ticket spinlock.
> Relative comments are bad, esp. since we'll make the ticket code go away
> if this works, at which point this is a reference into a black hole.

Thank for the suggestion, I will remove that when I need to revise the 
patch.

>>                              Each CPU waiting for the lock will spin until it
>> + * reaches a threshold. When that happens, it will put itself to a halt state
>> + * so that the hypervisor can reuse the CPU cycles in some other guests as
>> + * well as returning other hold-up CPUs faster.
>
>
>
>> +/**
>> + * queue_spin_lock - acquire a queue spinlock
>> + * @lock: Pointer to queue spinlock structure
>> + *
>> + * N.B. INLINE_SPIN_LOCK should not be enabled when PARAVIRT_SPINLOCK is on.
> One should write a compile time fail for that, not a comment.

Will do that.

>> + */
>> +static __always_inline void queue_spin_lock(struct qspinlock *lock)
>> +{
>> +	u32 val;
>> +
>> +	val = atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL);
>> +	if (likely(val == 0))
>> +		return;
>> +	if (static_key_false(&paravirt_spinlocks_enabled))
>> +		pv_queue_spin_lock_slowpath(lock, val);
>> +	else
>> +		queue_spin_lock_slowpath(lock, val);
>> +}
> No, this is just vile.. _that_ is what we have PV ops for. And at that
> point its the same function it was before the PV stuff, so that whole
> inline thing is then gone.

I did that because in all the architectures except s390, the lock 
functions are not inlined. They live in the _raw_spin_lock* defined in 
kernel/locking/spinlock.c. The unlock functions, on the other hand, are 
all inlined except when PV spinlock is enabled. So adding a check for 
the jump label won't change any of the status quo.

>> +extern void queue_spin_unlock_slowpath(struct qspinlock *lock);
>> +
>>   /**
>>    * queue_spin_unlock - release a queue spinlock
>>    * @lock : Pointer to queue spinlock structure
>>    *
>>    * An effective smp_store_release() on the least-significant byte.
>> + *
>> + * Inlining of the unlock function is disabled when CONFIG_PARAVIRT_SPINLOCKS
>> + * is defined. So _raw_spin_unlock() will be the only call site that will
>> + * have to be patched.
> again if you hard rely on the not inlining make a build fail not a
> comment.

Will do that.

>>    */
>>   static inline void queue_spin_unlock(struct qspinlock *lock)
>>   {
>>   	barrier();
>> +	if (!static_key_false(&paravirt_spinlocks_enabled)) {
>> +		native_spin_unlock(lock);
>> +		return;
>> +	}
>>
>> +	/*
>> +	 * Need to atomically clear the lock byte to avoid racing with
>> +	 * queue head waiter trying to set _QLOCK_LOCKED_SLOWPATH.
>> +	 */
>> +	if (unlikely(cmpxchg((u8 *)lock, _Q_LOCKED_VAL, 0) != _Q_LOCKED_VAL))
>> +		queue_spin_unlock_slowpath(lock);
>> +}
> Idem, that static key stuff is wrong, use PV ops to switch between
> unlock paths.

As said in my previous emails, the PV ops call site patching code 
doesn't work well with locking. First of all, the native_patch() 
function was called even in a KVM PV guest. Some unlock calls happened 
before the paravirt_spinlocks_enabled jump label was set up. It occurs 
to me that call site patching is done the first time the call site is 
used. At least for those early unlock calls, there is no way to figure 
out if it should use the native fast path or the PV slow path. The only 
possible workaround that I can think of is to use a variable (if 
available) that signal the end of the bootup init phase, we can then 
defer the call site patching until the init phase has passed.

This is a rather complicated solution which may not worth the slight 
benefit of a faster unlock call in the native case.

>> @@ -354,7 +394,7 @@ queue:
>>   	 * if there was a previous node; link it and wait until reaching the
>>   	 * head of the waitqueue.
>>   	 */
>> -	if (old&  _Q_TAIL_MASK) {
>> +	if (!pv_link_and_wait_node(old, node)&&  (old&  _Q_TAIL_MASK)) {
>>   		prev = decode_tail(old);
>>   		ACCESS_ONCE(prev->next) = node;
>> @@ -369,9 +409,11 @@ queue:
>>   	 *
>>   	 * *,x,y ->  *,0,0
>>   	 */
>> -	while ((val = smp_load_acquire(&lock->val.counter))&
>> -			_Q_LOCKED_PENDING_MASK)
>> +	val = pv_wait_head(lock, node);
>> +	while (val&  _Q_LOCKED_PENDING_MASK) {
>>   		cpu_relax();
>> +		val = smp_load_acquire(&lock->val.counter);
>> +	}
>>
>>   	/*
>>   	 * claim the lock:
> Please make the pv_*() calls return void and reduce to NOPs. This keeps
> the logic invariant of the pv stuff.

In my patch, the two pv_*() calls above serve as replacements of the 
waiting code. Making them return void and reduce to NOPs will cause what 
Konrad said doing the same operation twice which is not ideal from a 
performance point of view for the PV version. Is putting the pre-PV code 
in the comment help to clarify what the code should be before the PV stuff?

-Longman
