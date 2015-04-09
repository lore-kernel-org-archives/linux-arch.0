From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
	for the qspinlock
Date: Thu, 9 Apr 2015 20:13:27 +0200
Message-ID: <20150409181327.GY5029@twins.programming.kicks-ass.net>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 06, 2015 at 10:55:44PM -0400, Waiman Long wrote:
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -0,0 +1,321 @@
> +#ifndef _GEN_PV_LOCK_SLOWPATH
> +#error "do not include this file"
> +#endif
> +
> +/*
> + * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
> + * of spinning them.
> + *
> + * This relies on the architecture to provide two paravirt hypercalls:
> + *
> + *   pv_wait(u8 *ptr, u8 val) -- suspends the vcpu if *ptr == val
> + *   pv_kick(cpu)             -- wakes a suspended vcpu
> + *
> + * Using these we implement __pv_queue_spin_lock_slowpath() and
> + * __pv_queue_spin_unlock() to replace native_queue_spin_lock_slowpath() and
> + * native_queue_spin_unlock().
> + */
> +
> +#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
> +
> +enum vcpu_state {
> +	vcpu_running = 0,
> +	vcpu_halted,
> +};
> +
> +struct pv_node {
> +	struct mcs_spinlock	mcs;
> +	struct mcs_spinlock	__res[3];
> +
> +	int			cpu;
> +	u8			state;
> +};
> +
> +/*
> + * Hash table using open addressing with an LFSR probe sequence.
> + *
> + * Since we should not be holding locks from NMI context (very rare indeed) the
> + * max load factor is 0.75, which is around the point where open addressing
> + * breaks down.
> + *
> + * Instead of probing just the immediate bucket we probe all buckets in the
> + * same cacheline.
> + *
> + * http://en.wikipedia.org/wiki/Hash_table#Open_addressing
> + *
> + * Dynamically allocate a hash table big enough to hold at least 4X the
> + * number of possible cpus in the system. Allocation is done on page
> + * granularity. So the minimum number of hash buckets should be at least
> + * 256 to fully utilize a 4k page.
> + */
> +#define LFSR_MIN_BITS	8
> +#define	LFSR_MAX_BITS	(2 + NR_CPUS_BITS)
> +#if LFSR_MAX_BITS < LFSR_MIN_BITS
> +#undef  LFSR_MAX_BITS
> +#define LFSR_MAX_BITS	LFSR_MIN_BITS
> +#endif
> +
> +struct pv_hash_bucket {
> +	struct qspinlock *lock;
> +	struct pv_node   *node;
> +};
> +#define PV_HB_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_bucket))
> +#define HB_RESERVED	((struct qspinlock *)1)

This is unused.

> +
> +static struct pv_hash_bucket *pv_lock_hash;
> +static unsigned int pv_lock_hash_bits __read_mostly;

static unsigned int pv_taps __read_mostly;

> +
> +#include <linux/hash.h>
> +#include <linux/lfsr.h>
> +#include <linux/bootmem.h>
> +
> +/*
> + * Allocate memory for the PV qspinlock hash buckets
> + *
> + * This function should be called from the paravirt spinlock initialization
> + * routine.
> + */
> +void __init __pv_init_lock_hash(void)
> +{
> +	int pv_hash_size = 4 * num_possible_cpus();
> +
> +	if (pv_hash_size < (1U << LFSR_MIN_BITS))
> +		pv_hash_size = (1U << LFSR_MIN_BITS);
> +	/*
> +	 * Allocate space from bootmem which should be page-size aligned
> +	 * and hence cacheline aligned.
> +	 */
> +	pv_lock_hash = alloc_large_system_hash("PV qspinlock",
> +					       sizeof(struct pv_hash_bucket),
> +					       pv_hash_size, 0, HASH_EARLY,
> +					       &pv_lock_hash_bits, NULL,
> +					       pv_hash_size, pv_hash_size);

	pv_taps = lfsr_taps(pv_lock_hash_bits);

> +}
> +
> +static inline u32 hash_align(u32 hash)
> +{
> +	return hash & ~(PV_HB_PER_LINE - 1);
> +}
> +
> +static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
> +{
> +	unsigned long init_hash, hash = hash_ptr(lock, pv_lock_hash_bits);
> +	struct pv_hash_bucket *hb, *end;
> +
> +	if (!hash)
> +		hash = 1;
> +
> +	init_hash = hash;
> +	hb = &pv_lock_hash[hash_align(hash)];
> +	for (;;) {
> +		for (end = hb + PV_HB_PER_LINE; hb < end; hb++) {
> +			if (!cmpxchg(&hb->lock, NULL, lock)) {
> +				WRITE_ONCE(hb->node, node);
> +				/*
> +				 * We haven't set the _Q_SLOW_VAL yet. So
> +				 * the order of writing doesn't matter.
> +				 */
> +				smp_wmb(); /* matches rmb from pv_hash_find */

This doesn't make sense. Both sites do ->lock first and ->node second.
No amount of ordering can 'fix' that.

I think we can safely remove this wmb and the rmb below, because the
required ordering is already provided by setting/observing l->locked ==
SLOW.

> +				goto done;
> +			}
> +		}
> +
> +		hash = lfsr(hash, pv_lock_hash_bits, 0);

Since pv_lock_hash_bits is a variable, you end up running through that
massive if() forest to find the corresponding tap every single time. It
cannot compile-time optimize it.

Hence:
		hash = lfsr(hash, pv_taps);

(I don't get the bits argument to the lfsr).

In any case, like I said before, I think we should try a linear probe
sequence first, the lfsr was over engineering from my side.

> +		hb = &pv_lock_hash[hash_align(hash)];
> +		BUG_ON(hash == init_hash);
> +	}
> +
> +done:
> +	return &hb->lock;
> +}
> +
> +static struct pv_node *pv_hash_find(struct qspinlock *lock)
> +{
> +	unsigned long init_hash, hash = hash_ptr(lock, pv_lock_hash_bits);
> +	struct pv_hash_bucket *hb, *end;
> +	struct pv_node *node = NULL;
> +
> +	if (!hash)
> +		hash = 1;
> +
> +	init_hash = hash;
> +	hb = &pv_lock_hash[hash_align(hash)];
> +	for (;;) {
> +		for (end = hb + PV_HB_PER_LINE; hb < end; hb++) {
> +			struct qspinlock *l = READ_ONCE(hb->lock);
> +
> +			if (l == lock) {
> +				smp_rmb(); /* matches wmb from pv_hash() */

per the above this can go, IF we observe SLOW we must also observe a
consistent bucket.

> +				node = READ_ONCE(hb->node);
> +				goto done;
> +			}
> +		}
> +
> +		hash = lfsr(hash, pv_lock_hash_bits, 0);

idem the previous lfsr comment.

> +		hb = &pv_lock_hash[hash_align(hash)];
> +		BUG_ON(hash == init_hash);
> +	}
> +done:
> +	/*
> +	 * Clear the hash bucket
> +	 */
> +	WRITE_ONCE(hb->lock, NULL);
> +	return node;
> +}

> +/*
> + * Wait for l->locked to become clear; halt the vcpu after a short spin.
> + * __pv_queue_spin_unlock() will wake us.
> + */
> +static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
> +{
> +	struct __qspinlock *l = (void *)lock;
> +	struct qspinlock **lp = NULL;
> +	struct pv_node *pn = (struct pv_node *)node;
> +	int slow_set = false;
> +	int loop;
> +
> +	for (;;) {
> +		for (loop = SPIN_THRESHOLD; loop; loop--) {
> +			if (!READ_ONCE(l->locked))
> +				return;
> +
> +			cpu_relax();
> +		}
> +
> +		WRITE_ONCE(pn->state, vcpu_halted);
> +		if (!lp)
> +			lp = pv_hash(lock, pn);
> +		/*
> +		 * lp must be set before setting _Q_SLOW_VAL
> +		 *
> +		 * [S] lp = lock                [RmW] l = l->locked = 0
> +		 *     MB                             MB
> +		 * [S] l->locked = _Q_SLOW_VAL  [L]   lp
> +		 *
> +		 * Matches the cmpxchg() in pv_queue_spin_unlock().
> +		 */
> +		if (!slow_set &&
> +		    !cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL)) {
> +			/*
> +			 * The lock is free and _Q_SLOW_VAL has never been
> +			 * set. Need to clear the hash bucket before getting
> +			 * the lock.
> +			 */
> +			WRITE_ONCE(*lp, NULL);
> +			return;
> +		} else if (slow_set && !READ_ONCE(l->locked))
> +			return;
> +		slow_set = true;

I'm somewhat puzzled by the slow_set thing; what is wrong with the thing
I had, namely:

		if (!lp) {
			lp = pv_hash(lock, pn);

			/*
			 * comment
			 */
			lv = cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL);
			if (lv != _Q_LOCKED_VAL) {
				/* we're woken, unhash and return */
				WRITE_ONCE(*lp, NULL);
				return;
			}
		}
> +
> +		pv_wait(&l->locked, _Q_SLOW_VAL);


If we get a spurious wakeup (due to device interrupts or random kick)
we'll loop around but ->locked will remain _Q_SLOW_VAL.

> +	}
> +	/*
> +	 * Lock is unlocked now; the caller will acquire it without waiting.
> +	 * As with pv_wait_node() we rely on the caller to do a load-acquire
> +	 * for us.
> +	 */
> +}
> +
> +/*
> + * To be used in stead of queue_spin_unlock() for paravirt locks. Wakes
> + * pv_wait_head() if appropriate.
> + */
> +__visible void __pv_queue_spin_unlock(struct qspinlock *lock)
> +{
> +	struct __qspinlock *l = (void *)lock;
> +	struct pv_node *node;
> +
> +	if (likely(cmpxchg(&l->locked, _Q_LOCKED_VAL, 0) == _Q_LOCKED_VAL))
> +		return;
> +
> +	/*
> +	 * The queue head has been halted. Need to locate it and wake it up.
> +	 */
> +	node = pv_hash_find(lock);
> +	smp_store_release(&l->locked, 0);

Ah yes, clever that.

> +	/*
> +	 * At this point the memory pointed at by lock can be freed/reused,
> +	 * however we can still use the PV node to kick the CPU.
> +	 */
> +	if (READ_ONCE(node->state) == vcpu_halted)
> +		pv_kick(node->cpu);
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);

However I feel the PV_CALLEE_SAVE_REGS_THUNK thing belongs in the x86
code.
