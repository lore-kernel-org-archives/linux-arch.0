From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC v5 7/8] pvqspinlock, x86: Add qspinlock
	para-virtualization support
Date: Wed, 26 Feb 2014 12:54:56 -0500
Message-ID: <20140226175456.GD20775@phenom.dumpdata.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-8-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1393427668-60228-8-git-send-email-Waiman.Long@hp.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Cheg
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 26, 2014 at 10:14:27AM -0500, Waiman Long wrote:
> This patch adds para-virtualization support to the queue spinlock code
> by enabling the queue head to kick the lock holder CPU, if known,
> in when the lock isn't released for a certain amount of time. It
  ^^ - ?
> also enables the mutual monitoring of the queue head CPU and the
> following node CPU in the queue to make sure that their CPUs will
> stay scheduled in.

stay scheduled in? How are you influencing the hypervisor to schedule
them in next?  I see this patch "x86: Enable KVM to use qspinlock's PV support"
but that might not be the best choice.

What if the hypervisor has another CPU ready to go - which is also
a lock-holder. Wouldn't it be better to just provide a cpu mask of the
CPUs it could kick?

> 
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> ---
>  arch/x86/include/asm/paravirt.h       |    9 ++-
>  arch/x86/include/asm/paravirt_types.h |   12 +++
>  arch/x86/include/asm/pvqspinlock.h    |  176 +++++++++++++++++++++++++++++++++
>  arch/x86/kernel/paravirt-spinlocks.c  |    4 +
>  kernel/locking/qspinlock.c            |   41 +++++++-
>  5 files changed, 235 insertions(+), 7 deletions(-)
>  create mode 100644 arch/x86/include/asm/pvqspinlock.h
> 
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index cd6e161..06d3279 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -711,7 +711,12 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
>  }
>  
>  #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
> -
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +static __always_inline void __queue_kick_cpu(int cpu, enum pv_kick_type type)
> +{
> +	PVOP_VCALL2(pv_lock_ops.kick_cpu, cpu, type);
> +}
> +#else
>  static __always_inline void __ticket_lock_spinning(struct arch_spinlock *lock,
>  							__ticket_t ticket)
>  {
> @@ -723,7 +728,7 @@ static __always_inline void __ticket_unlock_kick(struct arch_spinlock *lock,
>  {
>  	PVOP_VCALL2(pv_lock_ops.unlock_kick, lock, ticket);
>  }
> -
> +#endif
>  #endif
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 7549b8b..87f8836 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -333,9 +333,21 @@ struct arch_spinlock;
>  typedef u16 __ticket_t;
>  #endif
>  
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +enum pv_kick_type {
> +	PV_KICK_LOCK_HOLDER,
> +	PV_KICK_QUEUE_HEAD,
> +	PV_KICK_NEXT_NODE
> +};
> +#endif
> +
>  struct pv_lock_ops {
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +	void (*kick_cpu)(int cpu, enum pv_kick_type);
> +#else
>  	struct paravirt_callee_save lock_spinning;
>  	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
> +#endif
>  };
>  
>  /* This contains all the paravirt structures: we get a convenient
> diff --git a/arch/x86/include/asm/pvqspinlock.h b/arch/x86/include/asm/pvqspinlock.h
> new file mode 100644
> index 0000000..45aae39
> --- /dev/null
> +++ b/arch/x86/include/asm/pvqspinlock.h
> @@ -0,0 +1,176 @@
> +#ifndef _ASM_X86_PVQSPINLOCK_H
> +#define _ASM_X86_PVQSPINLOCK_H
> +
> +/*
> + *	Queue Spinlock Para-Virtualization Support
> + *
> + *	+------+	    +-----+ nxtcpu_p1  +----+
> + *	| Lock |	    |Queue|----------->|Next|
> + *	|Holder|<-----------|Head |<-----------|Node|
> + *	+------+ prev_qcode +-----+ prev_qcode +----+
> + *
> + * As long as the current lock holder passes through the slowpath, the queue

Um, why would the the lock holder pass through the slowpath? It already
has the lock hasn't it? Or is this when it acquired it (either via fastpath
or slowpath) and it stashes this information somewhere?


> + * head CPU will have its CPU number stored in prev_qcode. The situation is
> + * the same for the node next to the queue head.
                       ^^^^^^^^         ^^^^^^^^^^

Do you mean to say next node's queue head?
> + *
> + * The next node, while setting up the next pointer in the queue head, can
> + * also store its CPU number in that node. With that change, the queue head

can or MUST?

> + * will have the CPU numbers of both its upstream and downstream neighbors.
> + *
> + * To make forward progress in lock acquisition and release, it is necessary
> + * that both the lock holder and the queue head virtual CPUs are present.
> + * The queue head can monitor the lock holder, but the lock holder can't
> + * monitor the queue head back. As a result, the next node is also brought
> + * into the picture to monitor the queue head. In the above diagram, all the
> + * 3 virtual CPUs should be present with the queue head and next node
> + * monitoring each other to make sure they are both present.

OK, that implies you must have those 3 VCPUs active right?
> + *
> + * Heartbeat counters are used to track if a neighbor is active. There are
> + * 3 different sets of heartbeat counter monitoring going on:
> + * 1) The queue head will wait until the number loop iteration exceeds a
> + *    certain threshold (HEAD_SPIN_THRESHOLD). In that case, it will send
> + *    a kick-cpu signal to the lock holder if it has the CPU number available.
> + *    The kick-cpu siginal will be sent only once as the real lock holder
> + *    may not be the same as what the queue head thinks it is.

Why would it not be the same?

Is there another patch I should read before asking these questions?

> + * 2) The queue head will periodically clear the active flag of the next node.
> + *    It will then check to see if the active flag remains cleared at the end
> + *    of the cycle. If it is, the next node CPU may be scheduled out. So it
> + *    send a kick-cpu signal to make sure that the next node CPU remain active.

So the next CPU can be scheduled out but you also kick it to make sure it is active
(aka scheduled in). Or maybe I am reading this wrong?

> + * 3) The next node CPU will monitor its own active flag to see if it gets
> + *    clear periodically. If it is not, the queue head CPU may be scheduled
         ^^^^ cleared                                             ^^^ have been?
> + *    out. It will then send the kick-cpu signal to the queue head CPU.
> + */
> +
> +/*
> + * Loop thresholds
> + */
> +#define	HEAD_SPIN_THRESHOLD	(1<<12)	/* Threshold to kick lock holder  */
> +#define	CLEAR_ACTIVE_THRESHOLD	(1<<8)	/* Threahold for clearing active flag */
> +#define CLEAR_ACTIVE_MASK	(CLEAR_ACTIVE_THRESHOLD - 1)

Something is off with the tabs here.
> +
> +/*
> + * PV macros
> + */
> +#define PV_SET_VAR(type, var, val)	type var = val
> +#define PV_VAR(var)			var
> +#define	PV_GET_NXTCPU(node)		(node)->pv.nxtcpu_p1

Ditto.
> +
> +/*
> + * Additional fields to be added to the qnode structure
> + *
> + * Try to cram the PV fields into a 32 bits so that it won't increase the
> + * qnode size in x86-64.
> + */
> +#if CONFIG_NR_CPUS >= (1 << 16)
> +#define _cpuid_t	u32
> +#else
> +#define _cpuid_t	u16
> +#endif
> +
> +struct pv_qvars {
> +	u8	 active;	/* Set if CPU active		*/
> +	u8	 prehead;	/* Set if next to queue head	*/
> +	_cpuid_t nxtcpu_p1;	/* CPU number of next node + 1	*/
> +};
> +
> +/**
> + * pv_init_vars - initialize fields in struct pv_qvars
> + * @pv: pointer to struct pv_qvars
> + */
> +static __always_inline void pv_init_vars(struct pv_qvars *pv)
> +{
> +	pv->active    = false;
> +	pv->prehead   = false;
> +	pv->nxtcpu_p1 = 0;
> +}
> +
> +/**
> + * head_spin_check - perform para-virtualization checks for queue head
> + * @count : loop count
> + * @qcode : queue code of the supposed lock holder
> + * @nxtcpu: CPU number of next node + 1
> + * @next  : pointer to the next node
> + * @offset: offset of the pv_qvars within the qnode
> + *
> + * 4 checks will be done:
> + * 1) See if it is time to kick the lock holder
> + * 2) Set the prehead flag of the next node
> + * 3) Clear the active flag of the next node periodically
> + * 4) If the active flag is not set after a while, assume the CPU of the
> + *    next-in-line node is offline and kick it back up again.
> + */
> +static __always_inline void
> +pv_head_spin_check(int *count, u32 qcode, int nxtcpu, void *next, int offset)
> +{
> +	if (!static_key_false(&paravirt_spinlocks_enabled))
> +		return;
> +	if ((++(*count) == HEAD_SPIN_THRESHOLD) && qcode) {
> +		/*
> +		 * Get the CPU number of the lock holder & kick it
> +		 * The lock may have been stealed by another CPU
                                          ^^^^^^ - stolen

> +		 * if PARAVIRT_UNFAIR_LOCKS is set, so the computed
> +		 * CPU number may not be the actual lock holder.
> +		 */
> +		int cpu = (qcode >> (_QCODE_VAL_OFFSET + 2)) - 1;
> +		__queue_kick_cpu(cpu, PV_KICK_LOCK_HOLDER);
> +	}
> +	if (next) {
> +		struct pv_qvars *pv = (struct pv_qvars *)
> +				      ((char *)next + offset);
> +
> +		if (!pv->prehead)
> +			pv->prehead = true;
> +		if ((*count & CLEAR_ACTIVE_MASK) == CLEAR_ACTIVE_MASK)
> +			pv->active = false;
> +		if (((*count & CLEAR_ACTIVE_MASK) == 0) &&
> +			!pv->active && nxtcpu)
> +			/*
> +			 * The CPU of the next node doesn't seem to be
> +			 * active, need to kick it to make sure that
> +			 * it is ready to be transitioned to queue head.
> +			 */
> +			__queue_kick_cpu(nxtcpu - 1, PV_KICK_NEXT_NODE);
> +	}
> +}
> +
> +/**
> + * head_spin_check - perform para-virtualization checks for queue member
> + * @pv   : pointer to struct pv_qvars
> + * @count: loop count
> + * @qcode: queue code of the previous node (queue head if pv->prehead set)
> + *
> + * Set the active flag if it is next to the queue head
> + */
> +static __always_inline void
> +pv_queue_spin_check(struct pv_qvars *pv, int *count, u32 qcode)
> +{
> +	if (!static_key_false(&paravirt_spinlocks_enabled))
> +		return;
> +	if (ACCESS_ONCE(pv->prehead)) {
> +		if (pv->active == false) {
> +			*count = 0;	/* Reset counter */
> +			pv->active = true;
> +		}
> +		if ((++(*count) >= 4 * CLEAR_ACTIVE_THRESHOLD) && qcode) {

This magic value could be wrapped in a macro.
> +			/*
> +			 * The queue head isn't clearing the active flag for
                                          ^^^^^^^^^^^^^ hadn't cleared
> +			 * too long. Need to kick it.
> +			 */
> +			int cpu = (qcode >> (_QCODE_VAL_OFFSET + 2)) - 1;
> +			__queue_kick_cpu(cpu, PV_KICK_QUEUE_HEAD);
> +			*count = 0;
> +		}
> +	}
> +}
> +
> +/**
> + * pv_set_cpu - set CPU # in the given pv_qvars structure
> + * @pv : pointer to struct pv_qvars to be set
> + * @cpu: cpu number to be set
> + */
> +static __always_inline void pv_set_cpu(struct pv_qvars *pv, int cpu)
> +{
> +	pv->nxtcpu_p1 = cpu + 1;
> +}
> +
> +#endif /* _ASM_X86_PVQSPINLOCK_H */
> diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
> index 8c67cbe..30d76f5 100644
> --- a/arch/x86/kernel/paravirt-spinlocks.c
> +++ b/arch/x86/kernel/paravirt-spinlocks.c
> @@ -11,9 +11,13 @@
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  struct pv_lock_ops pv_lock_ops = {
>  #ifdef CONFIG_SMP
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +	.kick_cpu = paravirt_nop,
> +#else
>  	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
>  	.unlock_kick = paravirt_nop,
>  #endif
> +#endif
>  };
>  EXPORT_SYMBOL(pv_lock_ops);
>  
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 22a63fa..f10446e 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -58,6 +58,26 @@
>   */
>  
>  /*
> + * Para-virtualized queue spinlock support
> + */
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +#include <asm/pvqspinlock.h>
> +#else
> +
> +#define PV_SET_VAR(type, var, val)
> +#define PV_VAR(var)			0
> +#define PV_GET_NXTCPU(node)		0
> +
> +struct pv_qvars {};
> +static __always_inline void pv_init_vars(struct pv_qvars *pv)		{}
> +static __always_inline void pv_head_spin_check(int *count, u32 qcode,
> +				int nxtcpu, void *next, int offset)	{}
> +static __always_inline void pv_queue_spin_check(struct pv_qvars *pv,
> +				int *count, u32 qcode)			{}
> +static __always_inline void pv_set_cpu(struct pv_qvars *pv, int cpu)	{}
> +#endif
> +
> +/*
>   * The 24-bit queue node code is divided into the following 2 fields:
>   * Bits 0-1 : queue node index (4 nodes)
>   * Bits 2-23: CPU number + 1   (4M - 1 CPUs)
> @@ -77,15 +97,13 @@
>  
>  /*
>   * The queue node structure
> - *
> - * This structure is essentially the same as the mcs_spinlock structure
> - * in mcs_spinlock.h file. This structure is retained for future extension
> - * where new fields may be added.

How come you are deleting this? Should that be a part of another patch?

>   */
>  struct qnode {
>  	u32		 wait;		/* Waiting flag		*/
> +	struct pv_qvars	 pv;		/* Para-virtualization  */
>  	struct qnode	*next;		/* Next queue node addr */
>  };
> +#define PV_OFFSET	offsetof(struct qnode, pv)
>  
>  struct qnode_set {
>  	struct qnode	nodes[MAX_QNODES];
> @@ -441,6 +459,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>  	unsigned int cpu_nr, qn_idx;
>  	struct qnode *node, *next;
>  	u32 prev_qcode, my_qcode;
> +	PV_SET_VAR(int, hcnt, 0);
>  
>  	/*
>  	 * Try the quick spinning code path
> @@ -468,6 +487,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>  	 */
>  	node->wait = true;
>  	node->next = NULL;
> +	pv_init_vars(&node->pv);
>  
>  	/*
>  	 * The lock may be available at this point, try again if no task was
> @@ -522,13 +542,22 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>  		 * and set up the "next" fields of the that node.
>  		 */
>  		struct qnode *prev = xlate_qcode(prev_qcode);
> +		PV_SET_VAR(int, qcnt, 0);
>  
>  		ACCESS_ONCE(prev->next) = node;
>  		/*
> +		 * Set current CPU number into the previous node
> +		 */
> +		pv_set_cpu(&prev->pv, cpu_nr);
> +
> +		/*
>  		 * Wait until the waiting flag is off
>  		 */
> -		while (smp_load_acquire(&node->wait))
> +		while (smp_load_acquire(&node->wait)) {
>  			arch_mutex_cpu_relax();
> +			pv_queue_spin_check(&node->pv, PV_VAR(&qcnt),
> +					    prev_qcode);
> +		}
>  	}
>  
>  	/*
> @@ -560,6 +589,8 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
>  				goto release_node;
>  		}
>  		arch_mutex_cpu_relax();
> +		pv_head_spin_check(PV_VAR(&hcnt), prev_qcode,
> +				PV_GET_NXTCPU(node), node->next, PV_OFFSET);
>  	}
>  
>  notify_next:
> -- 
> 1.7.1
> 
