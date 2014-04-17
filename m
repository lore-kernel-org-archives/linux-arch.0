From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 03/19] qspinlock: Add pending bit
Date: Thu, 17 Apr 2014 17:42:00 +0200
Message-ID: <20140417154200.GN11096@twins.programming.kicks-ass.net>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-4-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1397747051-15401-4-git-send-email-Waiman.Long@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 17, 2014 at 11:03:55AM -0400, Waiman Long wrote:
> +/**
> + * trylock_pending - try to acquire queue spinlock using the pending bit
> + * @lock : Pointer to queue spinlock structure
> + * @pval : Pointer to value of the queue spinlock 32-bit word
> + * Return: 1 if lock acquired, 0 otherwise
> + */
> +static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
> +{
> +	u32 old, new, val = *pval;

I'm not thrilled about you breaking this into a separate function; the
compiler will put it right back and now you get to have that ugly
pointer stuff.

It also makes the function control flow not match the state diagram
anymore.

> +
> +	/*
> +	 * trylock || pending
> +	 *
> +	 * 0,0,0 -> 0,0,1 ; trylock
> +	 * 0,0,1 -> 0,1,1 ; pending
> +	 */
> +	for (;;) {
> +		/*
> +		 * If we observe any contention; queue.
> +		 */
> +		if (val & ~_Q_LOCKED_MASK)
> +			return 0;
> +
> +		new = _Q_LOCKED_VAL;
> +		if (val == new)
> +			new |= _Q_PENDING_VAL;
> +
> +		old = atomic_cmpxchg(&lock->val, val, new);
> +		if (old == val)
> +			break;
> +
> +		*pval = val = old;
> +	}
> +
> +	/*
> +	 * we won the trylock
> +	 */
> +	if (new == _Q_LOCKED_VAL)
> +		return 1;
> +
> +	/*
> +	 * we're pending, wait for the owner to go away.
> +	 *
> +	 * *,1,1 -> *,1,0
> +	 */
> +	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_MASK)
> +		arch_mutex_cpu_relax();

That was a cpu_relax().

> +
> +	/*
> +	 * take ownership and clear the pending bit.
> +	 *
> +	 * *,1,0 -> *,0,1
> +	 */
> +	for (;;) {
> +		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
> +
> +		old = atomic_cmpxchg(&lock->val, val, new);
> +		if (old == val)
> +			break;
> +
> +		val = old;
> +	}
> +	return 1;
> +}
