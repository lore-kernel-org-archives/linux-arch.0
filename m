From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 08:31:29 +1000
Message-ID: <1436826689.3948.233.camel@kernel.crashing.org>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37510 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbbGMWcS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 18:32:18 -0400
In-Reply-To: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <michaele@au1.ibm.com>

On Mon, 2015-07-13 at 13:15 +0100, Will Deacon wrote:
> smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> into a full memory barrier.
> 
> However:
> 
>   - This ordering guarantee is already provided without the barrier on
>     all architectures apart from PowerPC
> 
>   - The barrier only applies to UNLOCK + LOCK, not general
>     RELEASE + ACQUIRE operations
> 
>   - Locks are generally assumed to offer SC ordering semantics, so
>     having this additional barrier is error-prone and complicates the
>     callers of LOCK/UNLOCK primitives
> 
>   - The barrier is not well used outside of RCU and, because it was
>     retrofitted into the kernel, it's not clear whether other areas of
>     the kernel are incorrectly relying on UNLOCK + LOCK implying a full
>     barrier
> 
> This patch removes the barrier and instead requires architectures to
> provide full barrier semantics for an UNLOCK + LOCK sequence.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> This didn't go anywhere last time I posted it, but here it is again.
> I'd really appreciate some feedback from the PowerPC guys, especially as
> to whether this change requires them to add an additional barrier in
> arch_spin_unlock and what the cost of that would be.

We'd have to turn the lwsync in unlock or the isync in lock into a full
barrier. As it is, we *almost* have a full barrier semantic, but not
quite, as in things can get mixed up inside spin_lock between the LL and
the SC (things leaking in past LL and things leaking "out" up before SC
and then getting mixed up in there).

Michael, at some point you were experimenting a bit with that and tried
to get some perf numbers of the impact that would have, did that
solidify ? Otherwise, I'll have a look when I'm back next week.

Ben.

>  Documentation/memory-barriers.txt   | 77 ++-----------------------------------
>  arch/powerpc/include/asm/spinlock.h |  2 -
>  include/linux/spinlock.h            | 10 -----
>  kernel/locking/mcs_spinlock.h       |  9 -----
>  kernel/rcu/tree.c                   | 21 +---------
>  kernel/rcu/tree_plugin.h            | 11 ------
>  6 files changed, 4 insertions(+), 126 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 13feb697271f..fff21b632893 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1848,74 +1848,9 @@ RELEASE are to the same lock variable, but only from the perspective of
>  another CPU not holding that lock.  In short, a ACQUIRE followed by an
>  RELEASE may -not- be assumed to be a full memory barrier.
>  
> -Similarly, the reverse case of a RELEASE followed by an ACQUIRE does not
> -imply a full memory barrier.  If it is necessary for a RELEASE-ACQUIRE
> -pair to produce a full barrier, the ACQUIRE can be followed by an
> -smp_mb__after_unlock_lock() invocation.  This will produce a full barrier
> -if either (a) the RELEASE and the ACQUIRE are executed by the same
> -CPU or task, or (b) the RELEASE and ACQUIRE act on the same variable.
> -The smp_mb__after_unlock_lock() primitive is free on many architectures.
> -Without smp_mb__after_unlock_lock(), the CPU's execution of the critical
> -sections corresponding to the RELEASE and the ACQUIRE can cross, so that:
> -
> -	*A = a;
> -	RELEASE M
> -	ACQUIRE N
> -	*B = b;
> -
> -could occur as:
> -
> -	ACQUIRE N, STORE *B, STORE *A, RELEASE M
> -
> -It might appear that this reordering could introduce a deadlock.
> -However, this cannot happen because if such a deadlock threatened,
> -the RELEASE would simply complete, thereby avoiding the deadlock.
> -
> -	Why does this work?
> -
> -	One key point is that we are only talking about the CPU doing
> -	the reordering, not the compiler.  If the compiler (or, for
> -	that matter, the developer) switched the operations, deadlock
> -	-could- occur.
> -
> -	But suppose the CPU reordered the operations.  In this case,
> -	the unlock precedes the lock in the assembly code.  The CPU
> -	simply elected to try executing the later lock operation first.
> -	If there is a deadlock, this lock operation will simply spin (or
> -	try to sleep, but more on that later).	The CPU will eventually
> -	execute the unlock operation (which preceded the lock operation
> -	in the assembly code), which will unravel the potential deadlock,
> -	allowing the lock operation to succeed.
> -
> -	But what if the lock is a sleeplock?  In that case, the code will
> -	try to enter the scheduler, where it will eventually encounter
> -	a memory barrier, which will force the earlier unlock operation
> -	to complete, again unraveling the deadlock.  There might be
> -	a sleep-unlock race, but the locking primitive needs to resolve
> -	such races properly in any case.
> -
> -With smp_mb__after_unlock_lock(), the two critical sections cannot overlap.
> -For example, with the following code, the store to *A will always be
> -seen by other CPUs before the store to *B:
> -
> -	*A = a;
> -	RELEASE M
> -	ACQUIRE N
> -	smp_mb__after_unlock_lock();
> -	*B = b;
> -
> -The operations will always occur in one of the following orders:
> -
> -	STORE *A, RELEASE, ACQUIRE, smp_mb__after_unlock_lock(), STORE *B
> -	STORE *A, ACQUIRE, RELEASE, smp_mb__after_unlock_lock(), STORE *B
> -	ACQUIRE, STORE *A, RELEASE, smp_mb__after_unlock_lock(), STORE *B
> -
> -If the RELEASE and ACQUIRE were instead both operating on the same lock
> -variable, only the first of these alternatives can occur.  In addition,
> -the more strongly ordered systems may rule out some of the above orders.
> -But in any case, as noted earlier, the smp_mb__after_unlock_lock()
> -ensures that the store to *A will always be seen as happening before
> -the store to *B.
> +However, the reverse case of a RELEASE followed by an ACQUIRE _does_
> +imply a full memory barrier when these accesses are performed as a pair
> +of UNLOCK and LOCK operations, irrespective of the lock variable.
>  
>  Locks and semaphores may not provide any guarantee of ordering on UP compiled
>  systems, and so cannot be counted on in such a situation to actually achieve
> @@ -2158,7 +2093,6 @@ However, if the following occurs:
>  	RELEASE M	     [1]
>  	ACCESS_ONCE(*D) = d;		ACCESS_ONCE(*E) = e;
>  					ACQUIRE M		     [2]
> -					smp_mb__after_unlock_lock();
>  					ACCESS_ONCE(*F) = f;
>  					ACCESS_ONCE(*G) = g;
>  					RELEASE M	     [2]
> @@ -2176,11 +2110,6 @@ But assuming CPU 1 gets the lock first, CPU 3 won't see any of:
>  	*F, *G or *H preceding ACQUIRE M [2]
>  	*A, *B, *C, *E, *F or *G following RELEASE M [2]
>  
> -Note that the smp_mb__after_unlock_lock() is critically important
> -here: Without it CPU 3 might see some of the above orderings.
> -Without smp_mb__after_unlock_lock(), the accesses are not guaranteed
> -to be seen in order unless CPU 3 holds lock M.
> -
>  
>  ACQUIRES VS I/O ACCESSES
>  ------------------------
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 4dbe072eecbe..523673d7583c 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -28,8 +28,6 @@
>  #include <asm/synch.h>
>  #include <asm/ppc-opcode.h>
>  
> -#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
> -
>  #ifdef CONFIG_PPC64
>  /* use 0x800000yy when locked, where yy == CPU number */
>  #ifdef __BIG_ENDIAN__
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 0063b24b4f36..16c5ed5a627c 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -130,16 +130,6 @@ do {								\
>  #define smp_mb__before_spinlock()	smp_wmb()
>  #endif
>  
> -/*
> - * Place this after a lock-acquisition primitive to guarantee that
> - * an UNLOCK+LOCK pair act as a full barrier.  This guarantee applies
> - * if the UNLOCK and LOCK are executed by the same CPU or if the
> - * UNLOCK and LOCK operate on the same lock variable.
> - */
> -#ifndef smp_mb__after_unlock_lock
> -#define smp_mb__after_unlock_lock()	do { } while (0)
> -#endif
> -
>  /**
>   * raw_spin_unlock_wait - wait until the spinlock gets unlocked
>   * @lock: the spinlock in question.
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index fd91aaa4554c..2ea2fae2b477 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -43,15 +43,6 @@ do {									\
>  #endif
>  
>  /*
> - * Note: the smp_load_acquire/smp_store_release pair is not
> - * sufficient to form a full memory barrier across
> - * cpus for many architectures (except x86) for mcs_unlock and mcs_lock.
> - * For applications that need a full barrier across multiple cpus
> - * with mcs_unlock and mcs_lock pair, smp_mb__after_unlock_lock() should be
> - * used after mcs_lock.
> - */
> -
> -/*
>   * In order to acquire the lock, the caller should declare a local node and
>   * pass a reference of the node to this function in addition to the lock.
>   * If the lock has already been acquired, then this will proceed to spin
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 65137bc28b2b..6689fc0808c8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1513,10 +1513,8 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>  	 * hold it, acquire the root rcu_node structure's lock in order to
>  	 * start one (if needed).
>  	 */
> -	if (rnp != rnp_root) {
> +	if (rnp != rnp_root)
>  		raw_spin_lock(&rnp_root->lock);
> -		smp_mb__after_unlock_lock();
> -	}
>  
>  	/*
>  	 * Get a new grace-period number.  If there really is no grace
> @@ -1769,7 +1767,6 @@ static void note_gp_changes(struct rcu_state *rsp, struct rcu_data *rdp)
>  		local_irq_restore(flags);
>  		return;
>  	}
> -	smp_mb__after_unlock_lock();
>  	needwake = __note_gp_changes(rsp, rnp, rdp);
>  	raw_spin_unlock_irqrestore(&rnp->lock, flags);
>  	if (needwake)
> @@ -1794,7 +1791,6 @@ static int rcu_gp_init(struct rcu_state *rsp)
>  
>  	WRITE_ONCE(rsp->gp_activity, jiffies);
>  	raw_spin_lock_irq(&rnp->lock);
> -	smp_mb__after_unlock_lock();
>  	if (!READ_ONCE(rsp->gp_flags)) {
>  		/* Spurious wakeup, tell caller to go back to sleep.  */
>  		raw_spin_unlock_irq(&rnp->lock);
> @@ -1827,7 +1823,6 @@ static int rcu_gp_init(struct rcu_state *rsp)
>  	rcu_for_each_leaf_node(rsp, rnp) {
>  		rcu_gp_slow(rsp, gp_preinit_delay);
>  		raw_spin_lock_irq(&rnp->lock);
> -		smp_mb__after_unlock_lock();
>  		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
>  		    !rnp->wait_blkd_tasks) {
>  			/* Nothing to do on this leaf rcu_node structure. */
> @@ -1884,7 +1879,6 @@ static int rcu_gp_init(struct rcu_state *rsp)
>  	rcu_for_each_node_breadth_first(rsp, rnp) {
>  		rcu_gp_slow(rsp, gp_init_delay);
>  		raw_spin_lock_irq(&rnp->lock);
> -		smp_mb__after_unlock_lock();
>  		rdp = this_cpu_ptr(rsp->rda);
>  		rcu_preempt_check_blocked_tasks(rnp);
>  		rnp->qsmask = rnp->qsmaskinit;
> @@ -1935,7 +1929,6 @@ static int rcu_gp_fqs(struct rcu_state *rsp, int fqs_state_in)
>  	/* Clear flag to prevent immediate re-entry. */
>  	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
>  		raw_spin_lock_irq(&rnp->lock);
> -		smp_mb__after_unlock_lock();
>  		WRITE_ONCE(rsp->gp_flags,
>  			   READ_ONCE(rsp->gp_flags) & ~RCU_GP_FLAG_FQS);
>  		raw_spin_unlock_irq(&rnp->lock);
> @@ -1956,7 +1949,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
>  
>  	WRITE_ONCE(rsp->gp_activity, jiffies);
>  	raw_spin_lock_irq(&rnp->lock);
> -	smp_mb__after_unlock_lock();
>  	gp_duration = jiffies - rsp->gp_start;
>  	if (gp_duration > rsp->gp_max)
>  		rsp->gp_max = gp_duration;
> @@ -1982,7 +1974,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
>  	 */
>  	rcu_for_each_node_breadth_first(rsp, rnp) {
>  		raw_spin_lock_irq(&rnp->lock);
> -		smp_mb__after_unlock_lock();
>  		WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp));
>  		WARN_ON_ONCE(rnp->qsmask);
>  		WRITE_ONCE(rnp->completed, rsp->gpnum);
> @@ -1998,7 +1989,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
>  	}
>  	rnp = rcu_get_root(rsp);
>  	raw_spin_lock_irq(&rnp->lock);
> -	smp_mb__after_unlock_lock(); /* Order GP before ->completed update. */
>  	rcu_nocb_gp_set(rnp, nocb);
>  
>  	/* Declare grace period done. */
> @@ -2246,7 +2236,6 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
>  		rnp_c = rnp;
>  		rnp = rnp->parent;
>  		raw_spin_lock_irqsave(&rnp->lock, flags);
> -		smp_mb__after_unlock_lock();
>  		oldmask = rnp_c->qsmask;
>  	}
>  
> @@ -2294,7 +2283,6 @@ static void rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
>  	mask = rnp->grpmask;
>  	raw_spin_unlock(&rnp->lock);	/* irqs remain disabled. */
>  	raw_spin_lock(&rnp_p->lock);	/* irqs already disabled. */
> -	smp_mb__after_unlock_lock();
>  	rcu_report_qs_rnp(mask, rsp, rnp_p, gps, flags);
>  }
>  
> @@ -2317,7 +2305,6 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
>  
>  	rnp = rdp->mynode;
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	if ((rdp->passed_quiesce == 0 &&
>  	     rdp->rcu_qs_ctr_snap == __this_cpu_read(rcu_qs_ctr)) ||
>  	    rdp->gpnum != rnp->gpnum || rnp->completed == rnp->gpnum ||
> @@ -2544,7 +2531,6 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
>  		if (!rnp)
>  			break;
>  		raw_spin_lock(&rnp->lock); /* irqs already disabled. */
> -		smp_mb__after_unlock_lock(); /* GP memory ordering. */
>  		rnp->qsmaskinit &= ~mask;
>  		rnp->qsmask &= ~mask;
>  		if (rnp->qsmaskinit) {
> @@ -2573,7 +2559,6 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();	/* Enforce GP memory-order guarantee. */
>  	rnp->qsmaskinitnext &= ~mask;
>  	raw_spin_unlock_irqrestore(&rnp->lock, flags);
>  }
> @@ -2771,7 +2756,6 @@ static void force_qs_rnp(struct rcu_state *rsp,
>  		cond_resched_rcu_qs();
>  		mask = 0;
>  		raw_spin_lock_irqsave(&rnp->lock, flags);
> -		smp_mb__after_unlock_lock();
>  		if (rnp->qsmask == 0) {
>  			if (rcu_state_p == &rcu_sched_state ||
>  			    rsp != rcu_state_p ||
> @@ -2843,7 +2827,6 @@ static void force_quiescent_state(struct rcu_state *rsp)
>  
>  	/* Reached the root of the rcu_node tree, acquire lock. */
>  	raw_spin_lock_irqsave(&rnp_old->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	raw_spin_unlock(&rnp_old->fqslock);
>  	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
>  		rsp->n_force_qs_lh++;
> @@ -2967,7 +2950,6 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
>  			struct rcu_node *rnp_root = rcu_get_root(rsp);
>  
>  			raw_spin_lock(&rnp_root->lock);
> -			smp_mb__after_unlock_lock();
>  			needwake = rcu_start_gp(rsp);
>  			raw_spin_unlock(&rnp_root->lock);
>  			if (needwake)
> @@ -3810,7 +3792,6 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
>  	rnp = rdp->mynode;
>  	mask = rdp->grpmask;
>  	raw_spin_lock(&rnp->lock);		/* irqs already disabled. */
> -	smp_mb__after_unlock_lock();
>  	rnp->qsmaskinitnext |= mask;
>  	rdp->gpnum = rnp->completed; /* Make CPU later note any new GP. */
>  	rdp->completed = rnp->completed;
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 013485fb2b06..79793a7647cf 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -164,7 +164,6 @@ static void rcu_preempt_note_context_switch(void)
>  		rdp = this_cpu_ptr(rcu_state_p->rda);
>  		rnp = rdp->mynode;
>  		raw_spin_lock_irqsave(&rnp->lock, flags);
> -		smp_mb__after_unlock_lock();
>  		t->rcu_read_unlock_special.b.blocked = true;
>  		t->rcu_blocked_node = rnp;
>  
> @@ -324,7 +323,6 @@ void rcu_read_unlock_special(struct task_struct *t)
>  		for (;;) {
>  			rnp = t->rcu_blocked_node;
>  			raw_spin_lock(&rnp->lock);  /* irqs already disabled. */
> -			smp_mb__after_unlock_lock();
>  			if (rnp == t->rcu_blocked_node)
>  				break;
>  			WARN_ON_ONCE(1);
> @@ -598,7 +596,6 @@ static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
>  	unsigned long mask;
>  
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	for (;;) {
>  		if (!sync_rcu_preempt_exp_done(rnp)) {
>  			raw_spin_unlock_irqrestore(&rnp->lock, flags);
> @@ -616,7 +613,6 @@ static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
>  		raw_spin_unlock(&rnp->lock); /* irqs remain disabled */
>  		rnp = rnp->parent;
>  		raw_spin_lock(&rnp->lock); /* irqs already disabled */
> -		smp_mb__after_unlock_lock();
>  		rnp->expmask &= ~mask;
>  	}
>  }
> @@ -638,7 +634,6 @@ sync_rcu_preempt_exp_init1(struct rcu_state *rsp, struct rcu_node *rnp)
>  	struct rcu_node *rnp_up;
>  
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	WARN_ON_ONCE(rnp->expmask);
>  	WARN_ON_ONCE(rnp->exp_tasks);
>  	if (!rcu_preempt_has_tasks(rnp)) {
> @@ -655,7 +650,6 @@ sync_rcu_preempt_exp_init1(struct rcu_state *rsp, struct rcu_node *rnp)
>  		if (rnp_up->expmask & mask)
>  			break;
>  		raw_spin_lock(&rnp_up->lock); /* irqs already off */
> -		smp_mb__after_unlock_lock();
>  		rnp_up->expmask |= mask;
>  		raw_spin_unlock(&rnp_up->lock); /* irqs still off */
>  	}
> @@ -679,7 +673,6 @@ sync_rcu_preempt_exp_init2(struct rcu_state *rsp, struct rcu_node *rnp)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	if (!rnp->expmask) {
>  		/* Phase 1 didn't do anything, so Phase 2 doesn't either. */
>  		raw_spin_unlock_irqrestore(&rnp->lock, flags);
> @@ -1007,7 +1000,6 @@ static int rcu_boost(struct rcu_node *rnp)
>  		return 0;  /* Nothing left to boost. */
>  
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  
>  	/*
>  	 * Recheck under the lock: all tasks in need of boosting
> @@ -1195,7 +1187,6 @@ static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
>  	if (IS_ERR(t))
>  		return PTR_ERR(t);
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	rnp->boost_kthread_task = t;
>  	raw_spin_unlock_irqrestore(&rnp->lock, flags);
>  	sp.sched_priority = kthread_prio;
> @@ -1586,7 +1577,6 @@ static void rcu_prepare_for_idle(void)
>  			continue;
>  		rnp = rdp->mynode;
>  		raw_spin_lock(&rnp->lock); /* irqs already disabled. */
> -		smp_mb__after_unlock_lock();
>  		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
>  		raw_spin_unlock(&rnp->lock); /* irqs remain disabled. */
>  		if (needwake)
> @@ -2114,7 +2104,6 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
>  	struct rcu_node *rnp = rdp->mynode;
>  
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
> -	smp_mb__after_unlock_lock();
>  	needwake = rcu_start_future_gp(rnp, rdp, &c);
>  	raw_spin_unlock_irqrestore(&rnp->lock, flags);
>  	if (needwake)
