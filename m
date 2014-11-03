From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v13 09/11] pvqspinlock, x86: Add para-virtualization
	support
Date: Mon, 3 Nov 2014 11:35:05 +0100
Message-ID: <20141103103505.GZ23531@worktop.programming.kicks-ass.net>
References: <1414613951-32532-1-git-send-email-Waiman.Long@hp.com>
	<1414613951-32532-10-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1414613951-32532-10-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 29, 2014 at 04:19:09PM -0400, Waiman Long wrote:
>  arch/x86/include/asm/pvqspinlock.h    |  411 +++++++++++++++++++++++++++++++++

I do wonder why all this needs to live in x86..

>  
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +
> +static __always_inline void pv_kick_cpu(int cpu)
> +{
> +	PVOP_VCALLEE1(pv_lock_ops.kick_cpu, cpu);
> +}
> +
> +static __always_inline void pv_lockwait(u8 *lockbyte)
> +{
> +	PVOP_VCALLEE1(pv_lock_ops.lockwait, lockbyte);
> +}
> +
> +static __always_inline void pv_lockstat(enum pv_lock_stats type)
> +{
> +	PVOP_VCALLEE1(pv_lock_ops.lockstat, type);
> +}

Why are any of these PV ops? they're only called from other pv_*()
functions. What's the point of pv ops you only call from pv code?

> +/*
> + *	Queue Spinlock Para-Virtualization (PV) Support
> + *
> + * The PV support code for queue spinlock is roughly the same as that
> + * of the ticket spinlock.

Relative comments are bad, esp. since we'll make the ticket code go away
if this works, at which point this is a reference into a black hole.

>                             Each CPU waiting for the lock will spin until it
> + * reaches a threshold. When that happens, it will put itself to a halt state
> + * so that the hypervisor can reuse the CPU cycles in some other guests as
> + * well as returning other hold-up CPUs faster.




> +/**
> + * queue_spin_lock - acquire a queue spinlock
> + * @lock: Pointer to queue spinlock structure
> + *
> + * N.B. INLINE_SPIN_LOCK should not be enabled when PARAVIRT_SPINLOCK is on.

One should write a compile time fail for that, not a comment.

> + */
> +static __always_inline void queue_spin_lock(struct qspinlock *lock)
> +{
> +	u32 val;
> +
> +	val = atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL);
> +	if (likely(val == 0))
> +		return;
> +	if (static_key_false(&paravirt_spinlocks_enabled))
> +		pv_queue_spin_lock_slowpath(lock, val);
> +	else
> +		queue_spin_lock_slowpath(lock, val);
> +}

No, this is just vile.. _that_ is what we have PV ops for. And at that
point its the same function it was before the PV stuff, so that whole
inline thing is then gone.

> +extern void queue_spin_unlock_slowpath(struct qspinlock *lock);
> +
>  /**
>   * queue_spin_unlock - release a queue spinlock
>   * @lock : Pointer to queue spinlock structure
>   *
>   * An effective smp_store_release() on the least-significant byte.
> + *
> + * Inlining of the unlock function is disabled when CONFIG_PARAVIRT_SPINLOCKS
> + * is defined. So _raw_spin_unlock() will be the only call site that will
> + * have to be patched.

again if you hard rely on the not inlining make a build fail not a
comment.

>   */
>  static inline void queue_spin_unlock(struct qspinlock *lock)
>  {
>  	barrier();
> +	if (!static_key_false(&paravirt_spinlocks_enabled)) {
> +		native_spin_unlock(lock);
> +		return;
> +	}
>  
> +	/*
> +	 * Need to atomically clear the lock byte to avoid racing with
> +	 * queue head waiter trying to set _QLOCK_LOCKED_SLOWPATH.
> +	 */
> +	if (unlikely(cmpxchg((u8 *)lock, _Q_LOCKED_VAL, 0) != _Q_LOCKED_VAL))
> +		queue_spin_unlock_slowpath(lock);
> +}

Idem, that static key stuff is wrong, use PV ops to switch between
unlock paths.

> @@ -354,7 +394,7 @@ queue:
>  	 * if there was a previous node; link it and wait until reaching the
>  	 * head of the waitqueue.
>  	 */
> -	if (old & _Q_TAIL_MASK) {
> +	if (!pv_link_and_wait_node(old, node) && (old & _Q_TAIL_MASK)) {
>  		prev = decode_tail(old);
>  		ACCESS_ONCE(prev->next) = node;
> @@ -369,9 +409,11 @@ queue:
>  	 *
>  	 * *,x,y -> *,0,0
>  	 */
> -	while ((val = smp_load_acquire(&lock->val.counter)) &
> -			_Q_LOCKED_PENDING_MASK)
> +	val = pv_wait_head(lock, node);
> +	while (val & _Q_LOCKED_PENDING_MASK) {
>  		cpu_relax();
> +		val = smp_load_acquire(&lock->val.counter);
> +	}
>  
>  	/*
>  	 * claim the lock:

Please make the pv_*() calls return void and reduce to NOPs. This keeps
the logic invariant of the pv stuff.
