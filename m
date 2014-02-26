From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Wed, 26 Feb 2014 17:20:57 +0100
Message-ID: <20140226162057.GW6835@laptop.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org


You don't happen to have a proper state diagram for this thing do you?

I suppose I'm going to have to make one; this is all getting a bit
unwieldy, and those xchg() + fixup things are hard to read.

On Wed, Feb 26, 2014 at 10:14:23AM -0500, Waiman Long wrote:
> +static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
> +{
> +	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
> +	u16		     old;
> +
> +	/*
> +	 * Fall into the quick spinning code path only if no one is waiting
> +	 * or the lock is available.
> +	 */
> +	if (unlikely((qsval != _QSPINLOCK_LOCKED) &&
> +		     (qsval != _QSPINLOCK_WAITING)))
> +		return 0;
> +
> +	old = xchg(&qlock->lock_wait, _QSPINLOCK_WAITING|_QSPINLOCK_LOCKED);
> +
> +	if (old == 0) {
> +		/*
> +		 * Got the lock, can clear the waiting bit now
> +		 */
> +		smp_u8_store_release(&qlock->wait, 0);


So we just did an atomic op, and now you're trying to optimize this
write. Why do you need a whole byte for that?

Surely a cmpxchg loop with the right atomic op can't be _that_ much
slower? Its far more readable and likely avoids that steal fail below as
well.

> +		return 1;
> +	} else if (old == _QSPINLOCK_LOCKED) {
> +try_again:
> +		/*
> +		 * Wait until the lock byte is cleared to get the lock
> +		 */
> +		do {
> +			cpu_relax();
> +		} while (ACCESS_ONCE(qlock->lock));
> +		/*
> +		 * Set the lock bit & clear the waiting bit
> +		 */
> +		if (cmpxchg(&qlock->lock_wait, _QSPINLOCK_WAITING,
> +			   _QSPINLOCK_LOCKED) == _QSPINLOCK_WAITING)
> +			return 1;
> +		/*
> +		 * Someone has steal the lock, so wait again
> +		 */
> +		goto try_again;

That's just a fail.. steals should not ever be allowed. It's a fair lock
after all.

> +	} else if (old == _QSPINLOCK_WAITING) {
> +		/*
> +		 * Another task is already waiting while it steals the lock.
> +		 * A bit of unfairness here won't change the big picture.
> +		 * So just take the lock and return.
> +		 */
> +		return 1;
> +	}
> +	/*
> +	 * Nothing need to be done if the old value is
> +	 * (_QSPINLOCK_WAITING | _QSPINLOCK_LOCKED).
> +	 */
> +	return 0;
> +}




> @@ -296,6 +478,9 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>  		return;
>  	}
>  
> +#ifdef queue_code_xchg
> +	prev_qcode = queue_code_xchg(lock, my_qcode);
> +#else
>  	/*
>  	 * Exchange current copy of the queue node code
>  	 */
> @@ -329,6 +514,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>  	} else
>  		prev_qcode &= ~_QSPINLOCK_LOCKED;	/* Clear the lock bit */
>  	my_qcode &= ~_QSPINLOCK_LOCKED;
> +#endif /* queue_code_xchg */
>  
>  	if (prev_qcode) {
>  		/*

That's just horrible.. please just make the entire #else branch another
version of that same queue_code_xchg() function.
