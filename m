From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC v6 09/11] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Wed, 12 Mar 2014 14:54:56 -0400
Message-ID: <1394650498-30118-10-git-send-email-Waiman.Long@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Scott J Norton <scott.norton@hp.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linu
List-Id: linux-arch.vger.kernel.org

This patch adds para-virtualization support to the queue spinlock in
the same way as was done in the PV ticket lock code. In essence, the
lock waiters will spin for a specified number of times (QSPIN_THRESHOLD
= 2^14) and then halted itself. The queue head waiter will spins
2*QSPIN_THRESHOLD times before halting itself. When it has spinned
QSPIN_THRESHOLD times, the queue head will assume that the lock
holder may be scheduled out and attempt to kick the lock holder CPU
if it has the CPU number on hand. Before being halted, the queue head
waiter will set a flag (_QSPINLOCK_LOCKED_SLOWPATH) in the lock byte
to indicate that the unlock slowpath has to be invoked.

In the unlock slowpath, the current lock holder will find the queue
head by following the previous node pointer links stored in the
queue node structure until it finds one that has the wait flag turned
off. It then attempt to kick the CPU of the queue head.

After the queue head acquired the lock, it will also check the status
of the next node and set _QSPINLOCK_LOCKED_SLOWPATH if it has been
halted.

Enabling the PV code does have a performance impact on spinlock
acquisitions and releases. The following table shows the execution
time (in ms) of a spinlock micro-benchmark that does lock/unlock
operations 5M times for each task versus the number of contending
tasks on a Westmere-EX system.

  # of        Ticket lock	     Queue lock
  tasks   PV off/PV on/%Change 	  PV off/PV on/%Change
  ------  --------------------   ---------------------
    1	     135/  179/+33%	     137/  169/+23%
    2	    1045/ 1103/ +6%	    1120/ 1536/+37%
    3	    1827/ 2683/+47%	    2313/ 2425/ +5%
    4       2689/ 4191/+56%	    2914/ 3128/ +7%
    5       3736/ 5830/+56%	    3715/ 3762/ +1%
    6       4942/ 7609/+54%	    4504/ 4558/ +2%
    7       6304/ 9570/+52%	    5292/ 5351/ +1%
    8       7736/11323/+46%	    6037/ 6097/ +1%

It can be seen that the ticket lock PV code has a fairly big decrease
in performance when there are 3 or more contending tasks. The
queue spinlock PV code, on the other hand, only has a minor drop in
performance for 3 or more contending tasks.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/paravirt.h       |   12 ++-
 arch/x86/include/asm/paravirt_types.h |   12 ++
 arch/x86/include/asm/pvqspinlock.h    |  232 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/qspinlock.h      |   35 +++++
 arch/x86/kernel/paravirt-spinlocks.c  |    5 +
 kernel/locking/qspinlock.c            |   96 ++++++++++++++-
 6 files changed, 390 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/pvqspinlock.h

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cd6e161..cabc37a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -711,7 +711,17 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+#ifdef CONFIG_QUEUE_SPINLOCK
+static __always_inline void __queue_kick_cpu(int cpu, enum pv_kick_type type)
+{
+	PVOP_VCALL2(pv_lock_ops.kick_cpu, cpu, type);
+}
 
+static __always_inline void __queue_hibernate(void)
+{
+	PVOP_VCALL0(pv_lock_ops.hibernate);
+}
+#else
 static __always_inline void __ticket_lock_spinning(struct arch_spinlock *lock,
 							__ticket_t ticket)
 {
@@ -723,7 +733,7 @@ static __always_inline void __ticket_unlock_kick(struct arch_spinlock *lock,
 {
 	PVOP_VCALL2(pv_lock_ops.unlock_kick, lock, ticket);
 }
-
+#endif
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 7549b8b..fa16aa6 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -333,9 +333,21 @@ struct arch_spinlock;
 typedef u16 __ticket_t;
 #endif
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+enum pv_kick_type {
+	PV_KICK_LOCK_HOLDER,
+	PV_KICK_QUEUE_HEAD
+};
+#endif
+
 struct pv_lock_ops {
+#ifdef CONFIG_QUEUE_SPINLOCK
+	void (*kick_cpu)(int cpu, enum pv_kick_type);
+	void (*hibernate)(void);
+#else
 	struct paravirt_callee_save lock_spinning;
 	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
+#endif
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/include/asm/pvqspinlock.h b/arch/x86/include/asm/pvqspinlock.h
new file mode 100644
index 0000000..13cbc4f
--- /dev/null
+++ b/arch/x86/include/asm/pvqspinlock.h
@@ -0,0 +1,232 @@
+#ifndef _ASM_X86_PVQSPINLOCK_H
+#define _ASM_X86_PVQSPINLOCK_H
+
+/*
+ *	Queue Spinlock Para-Virtualization (PV) Support
+ *
+ *	+------+	    +-----+ nxtcpu_p1  +----+
+ *	| Lock |	    |Queue|----------->|Next|
+ *	|Holder|<-----------|Head |<-----------|Node|
+ *	+------+ prev_qcode +-----+ prev_qcode +----+
+ *
+ * As long as the current lock holder passes through the slowpath, the queue
+ * head CPU will have its CPU number stored in prev_qcode. The situation is
+ * the same for the node next to the queue head.
+ *
+ * The next node, while setting up the next pointer in the queue head, can
+ * also store its CPU number in that node. With that change, the queue head
+ * will have the CPU numbers of both its upstream and downstream neighbors.
+ *
+ * The PV support code for queue spinlock is roughly the same as that
+ * of the ticket spinlock. Each CPU waiting for the lock will spin until it
+ * reaches a threshold. When that happens, it will put itself to halt so
+ * that the hypervisor can reuse the CPU in some other guests.
+ *
+ * The differences between the two versions of PV support are:
+ * 1) The queue head will spin twice as long as the other nodes before it
+ *    puts itself to halt.
+ * 2) The queue head will also attempt to kick the lock holder, if it has
+ *    the CPU number, in the half way point.
+ */
+
+/*
+ * Spin threshold for queue spinlock
+ * This is half of the ticket lock's SPIN_THRESHOLD. The queue head will
+ * be halted after 2*QSPIN_THRESHOLD whereas the other nodes will be
+ * halted after QSPIN_THRESHOLD.
+ */
+#define	QSPIN_THRESHOLD	(1U<<14)
+
+/*
+ * PV macros
+ */
+#define PV_SET_VAR(type, var, val)	type var = val
+#define PV_VAR(var)			var
+
+/*
+ * CPU state flags
+ */
+#define	PV_CPU_ACTIVE	1	/* This CPU is active		 */
+#define	PV_CPU_KICKING	2	/* This CPU is kicking other CPU */
+#define PV_CPU_KICKED   3	/* This CPU is being kicked	 */
+#define PV_CPU_HALTED	-1	/* This CPU is halted		 */
+
+/*
+ * Additional fields to be added to the qnode structure
+ */
+#if CONFIG_NR_CPUS >= (1 << 16)
+#define _cpuid_t	u32
+#else
+#define _cpuid_t	u16
+#endif
+
+struct qnode;
+
+struct pv_qvars {
+	s16	      cpustate;		/* CPU status flag		*/
+	_cpuid_t      nxtcpu_p1;	/* CPU number of next node + 1	*/
+	_cpuid_t      mycpu;		/* CPU number of this node	*/
+	struct qnode *prev;		/* Pointer to previous node	*/
+};
+
+/**
+ * pv_init_vars - initialize fields in struct pv_qvars
+ * @pv : pointer to struct pv_qvars
+ * @cpu: current CPU number
+ */
+static __always_inline void pv_init_vars(struct pv_qvars *pv, int cpu)
+{
+	pv->cpustate  = PV_CPU_ACTIVE;
+	pv->prev      = NULL;
+	pv->nxtcpu_p1 = 0;
+	pv->mycpu     = cpu;
+}
+
+/**
+ * pv_head_spin_check - perform para-virtualization checks for queue head
+ * @pv    : pointer to struct pv_qvars
+ * @count : loop count
+ * @qcode : queue code of the supposed lock holder
+ * @lock  : pointer to the qspinlock structure
+ *
+ * The following checks will be done:
+ * 1) Attempt to kick the lock holder, if known, after QSPIN_THRESHOLD
+ * 2) Halt itself if lock is still not available after 2*QSPIN_THRESHOLD
+ */
+static __always_inline void pv_head_spin_check(struct pv_qvars *pv, int *count,
+				u32 qcode, struct qspinlock *lock)
+{
+	if (!static_key_false(&paravirt_spinlocks_enabled))
+		return;
+	if (unlikely((++(*count) == QSPIN_THRESHOLD) && qcode)) {
+		/*
+		 * Get the CPU number of the lock holder & kick it
+		 * The lock may have been stealed by another CPU
+		 * if PARAVIRT_UNFAIR_LOCKS is set, so the computed
+		 * CPU number may not be the actual lock holder.
+		 */
+		int cpu = (qcode >> (_QCODE_VAL_OFFSET + 2)) - 1;
+
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_KICKING;
+		__queue_kick_cpu(cpu, PV_KICK_LOCK_HOLDER);
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
+	}
+	if (unlikely(*count >= 2*QSPIN_THRESHOLD)) {
+		u8 lockval;
+
+		/*
+		 * Set the lock byte to _QSPINLOCK_LOCKED_SLOWPATH before
+		 * trying to hibernate itself. It is possible that the
+		 * lock byte had been set to _QSPINLOCK_LOCKED_SLOWPATH
+		 * already. In this case, just proceeds to sleeping.
+		 */
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_HALTED;
+		lockval = cmpxchg(&((union arch_qspinlock *)lock)->lock,
+			  _QSPINLOCK_LOCKED, _QSPINLOCK_LOCKED_SLOWPATH);
+		if (lockval == 0) {
+			/*
+			 * Can exit now as the lock is free
+			 */
+			ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
+			*count = 0;
+			return;
+		}
+		__queue_hibernate();
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
+		*count = 0;	/* Reset count */
+	}
+}
+
+/**
+ * pv_queue_spin_check - perform para-virtualization checks for queue member
+ * @pv   : pointer to struct pv_qvars
+ * @count: loop count
+ */
+static __always_inline void pv_queue_spin_check(struct pv_qvars *pv, int *count)
+{
+	if (!static_key_false(&paravirt_spinlocks_enabled))
+		return;
+	/*
+	 * Attempt to halt oneself after QSPIN_THRESHOLD spins
+	 */
+	if (unlikely(++(*count) >= QSPIN_THRESHOLD)) {
+		/*
+		 * Time to hibernate itself
+		 */
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_HALTED;
+		__queue_hibernate();
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
+		*count = 0;	/* Reset count */
+	}
+}
+
+/**
+ * pv_next_node_check - set _QSPINLOCK_LOCKED_SLOWPATH flag if the next node
+ *			is halted
+ * @pv   : pointer to struct pv_qvars
+ * @count: loop count
+ *
+ * The current CPU should have gotten the lock before calling this function.
+ */
+static __always_inline void
+pv_next_node_check(struct pv_qvars *pv, struct qspinlock *lock)
+{
+	if (!static_key_false(&paravirt_spinlocks_enabled))
+		return;
+	if (ACCESS_ONCE(pv->cpustate) == PV_CPU_HALTED)
+		ACCESS_ONCE(((union arch_qspinlock *)lock)->lock)
+			= _QSPINLOCK_LOCKED_SLOWPATH;
+}
+
+/**
+ * pv_set_vars - set nxtcpu_p1 in previous PV and prev in current PV
+ * @pv  : pointer to struct pv_qvars
+ * @ppv : pointer to struct pv_qvars of previous node
+ * @cpu : cpu number
+ * @prev: pointer to the previous queue node
+ */
+static __always_inline void pv_set_vars(struct pv_qvars *pv,
+			struct pv_qvars *ppv, int cpu, struct qnode *prev)
+{
+	ppv->nxtcpu_p1 = cpu + 1;
+	pv->prev       = prev;
+}
+
+/**
+ * pv_set_prev - set previous queue node pointer
+ * @pv  : pointer to struct pv_qvars to be set
+ * @prev: pointer to the previous node
+ */
+static __always_inline void pv_set_prev(struct pv_qvars *pv, struct qnode *prev)
+{
+	ACCESS_ONCE(pv->prev) = prev;
+}
+
+/*
+ * The following inlined functions are being used by the
+ * queue_spin_unlock_slowpath() function.
+ */
+
+/**
+ * pv_get_prev - get previous queue node pointer
+ * @pv   : pointer to struct pv_qvars to be set
+ * Return: the previous queue node pointer
+ */
+static __always_inline struct qnode *pv_get_prev(struct pv_qvars *pv)
+{
+	return ACCESS_ONCE(pv->prev);
+}
+
+/**
+ * pv_kick_node - kick up the CPU of the given node
+ * @pv  : pointer to struct pv_qvars of the node to be kicked
+ */
+static __always_inline void pv_kick_node(struct pv_qvars *pv)
+{
+	if (pv->cpustate != PV_CPU_HALTED)
+		return;
+	ACCESS_ONCE(pv->cpustate) = PV_CPU_KICKED;
+	__queue_kick_cpu(pv->mycpu, PV_KICK_QUEUE_HEAD);
+}
+
+#endif /* _ASM_X86_PVQSPINLOCK_H */
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 0e6740a..4f85c33 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -38,7 +38,11 @@ union arch_qspinlock {
  * that the clearing the lock bit is done ASAP without artificial delay
  * due to compiler optimization.
  */
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+static __always_inline void __queue_spin_unlock(struct qspinlock *lock)
+#else
 static inline void queue_spin_unlock(struct qspinlock *lock)
+#endif
 {
 	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
 
@@ -47,6 +51,37 @@ static inline void queue_spin_unlock(struct qspinlock *lock)
 	barrier();
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/*
+ * The lock byte can have a value of _QSPINLOCK_LOCKED_SLOWPATH to indicate
+ * that it needs to go through the slowpath to do the unlocking.
+ */
+#define _QSPINLOCK_LOCKED_SLOWPATH	3	/* Set both bits 0 & 1 */
+
+extern void queue_spin_unlock_slowpath(struct qspinlock *lock);
+
+static inline void queue_spin_unlock(struct qspinlock *lock)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	barrier();
+	if (static_key_false(&paravirt_spinlocks_enabled)) {
+		/*
+		 * Need to atomically clear the lock byte to avoid racing with
+		 * queue head waiter trying to set _QSPINLOCK_LOCKED_SLOWPATH.
+		 */
+		if (likely(cmpxchg(&qlock->lock, _QSPINLOCK_LOCKED, 0)
+				== _QSPINLOCK_LOCKED))
+			return;
+		else
+			queue_spin_unlock_slowpath(lock);
+
+	} else {
+		__queue_spin_unlock(lock);
+	}
+}
+#endif
+
 #endif /* !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE */
 
 #include <asm-generic/qspinlock.h>
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 8c67cbe..d98547f 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -11,9 +11,14 @@
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
+#ifdef CONFIG_QUEUE_SPINLOCK
+	.kick_cpu = paravirt_nop,
+	.hibernate = paravirt_nop,
+#else
 	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
 	.unlock_kick = paravirt_nop,
 #endif
+#endif
 };
 EXPORT_SYMBOL(pv_lock_ops);
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 0030fad..a07cf8c 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -58,6 +58,31 @@
  */
 
 /*
+ * Para-virtualized queue spinlock support
+ */
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#include <asm/pvqspinlock.h>
+#else
+
+#define PV_SET_VAR(type, var, val)
+#define PV_VAR(var)			0
+
+struct qnode;
+struct pv_qvars {};
+static inline void pv_init_vars(struct pv_qvars *pv, int cpu_nr)	{}
+static inline void pv_set_vars(struct pv_qvars *pv, struct pv_qvars *ppv,
+			int cpu, struct qnode *prev)			{}
+static inline void pv_head_spin_check(struct pv_qvars *pv, int *count,
+			u32 qcode, struct qspinlock *lock)		{}
+static inline void pv_queue_spin_check(struct pv_qvars *pv, int *count)	{}
+static inline void pv_next_node_check(struct pv_qvars *pv, void *lock)	{}
+static inline void pv_kick_node(struct pv_qvars *pv)			{}
+static inline void pv_set_prev(struct pv_qvars *pv, struct qnode *prev)	{}
+static inline struct qnode *pv_get_prev(struct pv_qvars *pv)
+{ return NULL; }
+#endif
+
+/*
  * The 24-bit queue node code is divided into the following 2 fields:
  * Bits 0-1 : queue node index (4 nodes)
  * Bits 2-23: CPU number + 1   (4M - 1 CPUs)
@@ -84,6 +109,7 @@
  */
 struct qnode {
 	u32		 wait;		/* Waiting flag		*/
+	struct pv_qvars	 pv;		/* Para-virtualization	*/
 	struct qnode	*next;		/* Next queue node addr */
 };
 
@@ -341,6 +367,11 @@ static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
 { return 0; }
 #endif
 
+#ifndef queue_get_qcode
+#define queue_get_qcode(lock)	(atomic_read(&(lock)->qlcode) &\
+				 ~_QSPINLOCK_LOCKED)
+#endif
+
 #ifndef queue_get_lock_qcode
 /**
  * queue_get_lock_qcode - get the lock & qcode values
@@ -496,6 +527,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	unsigned int cpu_nr, qn_idx;
 	struct qnode *node, *next;
 	u32 prev_qcode, my_qcode;
+	PV_SET_VAR(int, hcnt, 0);
 
 	/*
 	 * Try the quick spinning code path
@@ -523,6 +555,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	 */
 	node->wait = true;
 	node->next = NULL;
+	pv_init_vars(&node->pv, cpu_nr);
 
 	/*
 	 * The lock may be available at this point, try again if no task was
@@ -552,13 +585,25 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 		 * and set up the "next" fields of the that node.
 		 */
 		struct qnode *prev = xlate_qcode(prev_qcode);
+		PV_SET_VAR(int, qcnt, 0);
 
 		ACCESS_ONCE(prev->next) = node;
+
+		/*
+		 * Set current CPU number into the previous node and the
+		 * previous node address into the current node.
+		 */
+		pv_set_vars(&node->pv, &prev->pv, cpu_nr, prev);
+
 		/*
 		 * Wait until the waiting flag is off
 		 */
-		while (smp_load_acquire(&node->wait))
+		while (smp_load_acquire(&node->wait)) {
 			arch_mutex_cpu_relax();
+			pv_queue_spin_check(&node->pv, PV_VAR(&qcnt));
+		}
+	} else {
+		ACCESS_ONCE(node->wait) = false;	/* At queue head */
 	}
 
 	/*
@@ -585,6 +630,11 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 				goto release_node;
 		}
 		arch_mutex_cpu_relax();
+
+		/*
+		 * Perform para-virtualization checks
+		 */
+		pv_head_spin_check(&node->pv, PV_VAR(&hcnt), prev_qcode, lock);
 	}
 
 notify_next:
@@ -596,9 +646,53 @@ notify_next:
 	/*
 	 * The next one in queue is now at the head
 	 */
+	pv_next_node_check(&next->pv, lock);
 	smp_store_release(&next->wait, false);
 
 release_node:
 	put_qnode();
 }
 EXPORT_SYMBOL(queue_spin_lock_slowpath);
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/**
+ * queue_spin_unlock_slowpath - kick up the CPU of the queue head
+ * @lock : Pointer to queue spinlock structure
+ *
+ * The lock is released after finding the queue head to avoid racing
+ * condition between the queue head and the lock holder.
+ */
+void queue_spin_unlock_slowpath(struct qspinlock *lock)
+{
+	struct qnode *node, *prev;
+	u32 qcode = (u32)queue_get_qcode(lock);
+
+	/*
+	 * Get the queue tail node
+	 */
+	node = xlate_qcode(qcode);
+
+	/*
+	 * Locate the queue head node by following the prev pointer from
+	 * tail to head.
+	 * It is assumed that the PV guests won't have that many CPUs so
+	 * that it won't take a long time to follow the pointers.
+	 */
+	while (ACCESS_ONCE(node->wait)) {
+		prev = pv_get_prev(&node->pv);
+		if (prev)
+			node = prev;
+		else
+			/*
+			 * Delay a bit to allow the prev pointer to be set up
+			 */
+			arch_mutex_cpu_relax();
+	}
+	/*
+	 * Found the queue head, now release the lock before waking it up
+	 */
+	__queue_spin_unlock(lock);
+	pv_kick_node(&node->pv);
+}
+EXPORT_SYMBOL(queue_spin_unlock_slowpath);
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
-- 
1.7.1
