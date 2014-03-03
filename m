From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Mon, 3 Mar 2014 18:43:05 +0100
Message-ID: <20140303174305.GK9987@twins.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<5310BB81.3090508@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5310BB81.3090508@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here are some numbers for my version -- also attached is the test code.
I found that booting big machines is tediously slow so I lifted the
whole lot to userspace.

I measure the cycles spend in arch_spin_lock() + arch_spin_unlock().

The machines used are a 4 node (2 socket) AMD Interlagos, and a 2 node
(2 socket) Intel Westmere-EP.

AMD (ticket)		AMD (qspinlock + pending + opt)

Local:                  Local:

1:    324.425530        1:    324.102142
2:  17141.324050        2:    620.185930
3:  52212.232343        3:  25242.574661
4:  93136.458314        4:  47982.037866
6: 167967.455965        6:  95345.011864
8: 245402.534869        8: 142412.451438

2 - nodes:              2 - nodes:

2:  12763.640956        2:   1879.460823
4:  94423.027123        4:  48278.719130
6: 167903.698361        6:  96747.767310
8: 257243.508294        8: 144672.846317

4 - nodes:              4 - nodes:

 4:  82408.853603        4:  49820.323075
 8: 260492.952355        8: 143538.264724
16: 630099.031148       16: 337796.553795



Intel (ticket)		Intel (qspinlock + pending + opt)

Local:                  Local:

1:    19.002249         1:    29.002844
2:  5093.275530         2:  1282.209519
3: 22300.859761         3: 22127.477388
4: 44929.922325         4: 44493.881832
6: 86338.755247         6: 86360.083940

2 - nodes:              2 - nodes:

2:   1509.193824        2:   1209.090219
4:  48154.495998        4:  48547.242379
8: 137946.787244        8: 141381.498125

---

There a few curious facts I found (assuming my test code is sane).

 - Intel seems to be an order of magnitude faster on uncontended LOCKed
   ops compared to AMD

 - On Intel the uncontended qspinlock fast path (cmpxchg) seems slower
   than the uncontended ticket xadd -- although both are plenty fast
   when compared to AMD.

 - In general, replacing cmpxchg loops with unconditional atomic ops
   doesn't seem to matter a whole lot when the thing is contended.

Below is the (rather messy) qspinlock slow path code (the only thing
that really differs between our versions.

I'll try and slot your version in tomorrow.

---


/*
 * Exactly fills one cacheline on 64bit.
 */
static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, mcs_nodes[4]);

static inline u32 encode_tail(int cpu, int idx)
{
	u32 code;

        code  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
	code |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */

	return code;
}

static inline struct mcs_spinlock *decode_tail(u32 code)
{
	int cpu = (code >> _Q_TAIL_CPU_OFFSET) - 1;
	int idx = (code >> _Q_TAIL_IDX_OFFSET) & _Q_TAIL_IDX_MASK;

	return per_cpu_ptr(&mcs_nodes[idx], cpu);
}

#define _QSPINLOCK_PENDING	(1U << _Q_PENDING_OFFSET)
#define _QSPINLOCK_MASK		(_QSPINLOCK_LOCKED | _QSPINLOCK_PENDING)

// PENDING - enables the pending bit logic
// OPT     - removes one atomic op at the cost of making pending a byte
// OPT2    - replaces some cmpxchg loops with unconditional atomic ops
//
// PENDING looks to be a win, even with 2 atomic ops on Intel, and a loss on AMD
// OPT is a full win
// OPT2 somehow doesn't seem to make much difference !?
//

/**
 * queue_spin_lock_slowpath - acquire the queue spinlock
 * @lock: Pointer to queue spinlock structure
 *
 *              fast      :    slow                                  :    unlock
 *                        :                                          :
 * uncontended  (0,0,0) --:--> (0,0,1) ------------------------------:--> (*,*,0)
 *                        :       | ^--------.------.             /  :
 *                        :       v           \      \            |  :
 * pending                :    (0,1,1) +--> (0,1,0)   \           |  :
 *                        :       | ^--'              |           |  :
 *                        :       v                   |           |  :
 * uncontended            :    (n,x,y) +--> (n,0,0) --'           |  :
 *   queue                :       | ^--'                          |  :
 *                        :       v                               |  :
 * contended              :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
 *   queue                :                                          :
 *
 */
void queue_spin_lock_slowpath(struct qspinlock *lock)
{
	struct mcs_spinlock *prev, *next, *node;
	u32 val, new, old, code;
	int idx;

#if PENDING
	/*
	 * trylock || pending
	 *
	 * 0,0,0 -> 0,0,1 ; trylock
	 * 0,0,1 -> 0,1,1 ; pending
	 */
	val = atomic_read(&lock->val);
#if !OPT2
	for (;;) {
		/*
		 * If we observe any contention; queue.
		 */
		if (val & ~_Q_LOCKED_MASK)
			goto queue;

		new = _QSPINLOCK_LOCKED;
		if (val == new)
			new |= _QSPINLOCK_PENDING;

		old = atomic_cmpxchg(&lock->val, val, new);
		if (old == val)
			break;

		val = old;
	}

	/*
	 * we won the trylock
	 */
	if (new == _QSPINLOCK_LOCKED)
		return;

#else
	/*
	 * we can ignore the (unlikely) trylock case and have a fall-through on
	 * the wait below.
	 */
	if (val & ~_Q_LOCKED_MASK)
		goto queue;

	if (xchg(&(((u8 *)lock)[1]), 1))
		goto queue;

// could not observe a significant difference
// between the one (xchg) and the other (bts) unconditional
// LOCKed op
//
//	if (atomic_test_and_set_bit(_Q_PENDING_OFFSET, &lock->val))
//		goto queue;
#endif

	/*
	 * we're pending, wait for the owner to go away.
	 */
	while ((val = atomic_read(&lock->val)) & _QSPINLOCK_LOCKED)
		cpu_relax();

	/*
	 * take ownership and clear the pending bit.
	 */
#if !OPT
	for (;;) {
		new = (val & ~_QSPINLOCK_PENDING) | _QSPINLOCK_LOCKED;

		old = atomic_cmpxchg(&lock->val, val, new);
		if (old == val)
			break;

		val = old;
	}
#else
	((u8 *)lock)[0] = 1; /* locked */
	smp_wmb();
	((u8 *)lock)[1] = 0; /* pending */

// there is a big difference between an atomic and
// no atomic op.
//
//	smp_mb__before_atomic_inc();
//	atomic_clear_bit(_Q_PENDING_OFFSET, &lock->val);
#endif

	return;

queue:
#endif
	node = this_cpu_ptr(&mcs_nodes[0]);
	idx = node->count++;
	code = encode_tail(smp_processor_id(), idx);

	node += idx;
	node->locked = 0;
	node->next = NULL;

	/*
	 * we already touched the queueing cacheline; don't bother with pending
	 * stuff.
	 *
	 * trylock || xchg(lock, node)
	 *
	 * 0,0,0 -> 0,0,1 ; trylock
	 * p,y,x -> n,y,x ; prev = xchg(lock, node)
	 */
	val = atomic_read(&lock->val);
#if !OPT2
	for (;;) {
		new = _QSPINLOCK_LOCKED;
		if (val)
			new = code | (val & _QSPINLOCK_MASK);

		old = atomic_cmpxchg(&lock->val, val, new);
		if (old == val)
			break;

		val = old;
	}

	/*
	 * we won the trylock; forget about queueing.
	 */
	if (new == _QSPINLOCK_LOCKED)
		goto release;
#else
	/*
	 * Like with the pending case; we can ignore the unlikely trylock case
	 * and have a fall-through on the wait.
	 */
	old = xchg(&((u16 *)lock)[1], code >> 16) << 16;
#endif

	/*
	 * if there was a previous node; link it and wait.
	 */
	if (old & ~_QSPINLOCK_MASK) {
		prev = decode_tail(old);
		ACCESS_ONCE(prev->next) = node;

		arch_mcs_spin_lock_contended(&node->locked);
	}

	/*
	 * we're at the head of the waitqueue, wait for the owner & pending to
	 * go away.
	 *
	 * *,x,y -> *,0,0
	 */
	while ((val = atomic_read(&lock->val)) & _QSPINLOCK_MASK)
		cpu_relax();

	/*
	 * claim the lock:
	 *
	 * n,0,0 -> 0,0,1 : lock, uncontended
	 * *,0,0 -> *,0,1 : lock, contended
	 */
	for (;;) {
		new = _QSPINLOCK_LOCKED;
		if (val != code)
			new |= val;

		old = atomic_cmpxchg(&lock->val, val, new);
		if (old == val)
			break;

		val = old;
	}

	/*
	 * contended path; wait for next, release.
	 */
	if (new != _QSPINLOCK_LOCKED) {
		while (!(next = ACCESS_ONCE(node->next)))
			arch_mutex_cpu_relax();

		arch_mcs_spin_unlock_contended(&next->locked);
	}

release:
	/*
	 * release the node
	 */
	this_cpu_ptr(&mcs_nodes[0])->count--;
//	this_cpu_dec(mcs_nodes[0].count);
}
EXPORT_SYMBOL(queue_spin_lock_slowpath);

--ibTvN161/egqYuK8
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="spinlocks.tar.bz2"
Content-Transfer-Encoding: base64

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
L/4u5IpwoSB8dmAC

--ibTvN161/egqYuK8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--ibTvN161/egqYuK8--
