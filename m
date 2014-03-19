From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v7 09/11] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Wed, 19 Mar 2014 16:14:07 -0400
Message-ID: <1395260049-30839-10-git-send-email-Waiman.Long@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
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
= 2^14) and then halted itself. The queue head waiter, unlike the
other waiter, will spins 2*QSPIN_THRESHOLD times before halting
itself.  Before being halted, the queue head waiter will set a flag
(_QLOCK_LOCKED_SLOWPATH) in the lock byte to indicate that the unlock
slowpath has to be invoked.

In the unlock slowpath, the current lock holder will find the queue
head by following the previous node pointer links stored in the queue
node structure until it finds one that has the qhead flag turned
on. It then attempt to kick the CPU of the queue head.

After the queue head acquired the lock, it will also check the status
of the next node and set _QLOCK_LOCKED_SLOWPATH if it has been halted.

Enabling the PV code does have a performance impact on spinlock
acquisitions and releases. The following table shows the execution
time (in ms) of a spinlock micro-benchmark that does lock/unlock
operations 5M times for each task versus the number of contending
tasks on a Westmere-EX system.

  # of        Ticket lock	     Queue lock
  tasks   PV off/PV on/%Change 	  PV off/PV on/%Change
  ------  --------------------   ---------------------
    1	     135/  179/+33%	     137/  169/+23%
    2	    1045/ 1103/ +6%	    1120/ 1574/+41%
    3	    1827/ 2683/+47%	    2313/ 2664/+15%
    4       2689/ 4191/+56%	    2914/ 3208/+10%
    5       3736/ 5830/+56%	    3715/ 3776/ +2%
    6       4942/ 7609/+54%	    4504/ 4536/ +1%
    7       6304/ 9570/+52%	    5292/ 5294/  0%
    8       7736/11323/+46%	    6037/ 6028/  0%

It can be seen that the ticket lock PV code has a fairly big decrease
in performance when there are 3 or more contending tasks. The queue
spinlock PV code, on the other hand, only has a relatively minor drop
in performance for 3 or more contending tasks. At 5 or more contending
tasks, there is practically no difference in performance. When coupled
with unfair lock, the queue spinlock can be much faster than the PV
ticket lock.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/paravirt.h       |   12 ++-
 arch/x86/include/asm/paravirt_types.h |    5 +
 arch/x86/include/asm/pvqspinlock.h    |  249 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/qspinlock.h      |   35 +++++
 arch/x86/kernel/paravirt-spinlocks.c  |    5 +
 kernel/locking/qspinlock.c            |  121 +++++++++++++++-
 6 files changed, 420 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/include/asm/pvqspinlock.h

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cd6e161..ab32020 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -711,7 +711,17 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+#ifdef CONFIG_QUEUE_SPINLOCK
+static __always_inline void __queue_kick_cpu(int cpu)
+{
+	PVOP_VCALL1(pv_lock_ops.kick_cpu, cpu);
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
index 7549b8b..2879b32 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -334,8 +334,13 @@ typedef u16 __ticket_t;
 #endif
 
 struct pv_lock_ops {
+#ifdef CONFIG_QUEUE_SPINLOCK
+	void (*kick_cpu)(int cpu);
+	void (*hibernate)(void);
+#else
 	struct paravirt_callee_save lock_spinning;
 	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
+#endif
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/include/asm/pvqspinlock.h b/arch/x86/include/asm/pvqspinlock.h
new file mode 100644
index 0000000..67dd163
--- /dev/null
+++ b/arch/x86/include/asm/pvqspinlock.h
@@ -0,0 +1,249 @@
+#ifndef _ASM_X86_PVQSPINLOCK_H
+#define _ASM_X86_PVQSPINLOCK_H
+
+/*
+ *	Queue Spinlock Para-Virtualization (PV) Support
+ *
+ *	+------+	    +-----+   next     +----+
+ *	| Lock |	    |Queue|----------->|Next|
+ *	|Holder|<-----------|Head |<-----------|Node|
+ *	+------+ prev_qcode +-----+ prev_qcode +----+
+ *
+ * The PV support code for queue spinlock is roughly the same as that
+ * of the ticket spinlock. Each CPU waiting for the lock will spin until it
+ * reaches a threshold. When that happens, it will put itself to halt so
+ * that the hypervisor can reuse the CPU cycles in some other guests.
+ *
+ * A major difference between the two versions of PV support is the fact
+ * that the queue head will spin twice as long as the other nodes before it
+ * puts itself to halt.
+ *
+ * There are 2 places where race can happen:
+ *  1) Halting of the queue head CPU (in pv_head_spin_check) and the CPU
+ *     kicking by the lock holder (in pv_kick_node).
+ *  2) Halting of the queue node CPU (in pv_queue_spin_check) and the
+ *     the status check by the previous queue head (in pv_next_node_check).
+ * See the comments on those functions to see how the races are being
+ * addressed.
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
+ * CPU state flags
+ */
+#define PV_CPU_ACTIVE	1	/* This CPU is active		 */
+#define PV_CPU_KICKED   2	/* This CPU is being kicked	 */
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
+	s8	      cpustate;		/* CPU status flag		*/
+	s8	      qhead;		/* Becoming queue head		*/
+	_cpuid_t      mycpu;		/* CPU number of this node	*/
+	struct qnode *prev;		/* Pointer to previous node	*/
+};
+
+/*
+ * Macro to be used by the unfair lock code to access the previous node pointer
+ * in the pv structure.
+ */
+#define qprev	pv.prev
+
+/**
+ * pv_init_vars - initialize fields in struct pv_qvars
+ * @pv : pointer to struct pv_qvars
+ * @cpu: current CPU number
+ */
+static __always_inline void pv_init_vars(struct pv_qvars *pv, int cpu)
+{
+	pv->cpustate = PV_CPU_ACTIVE;
+	pv->prev     = NULL;
+	pv->qhead    = 0;
+	pv->mycpu    = cpu;
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
+ * 2) Halt itself if lock is still not available after 2*QSPIN_THRESHOLD
+ */
+static __always_inline void pv_head_spin_check(struct pv_qvars *pv, int *count,
+				u32 qcode, struct qspinlock *lock)
+{
+	if (!static_key_false(&paravirt_spinlocks_enabled))
+		return;
+
+	if (unlikely(*count >= 2*QSPIN_THRESHOLD)) {
+		u8 lockval;
+
+		/*
+		 * Set the lock byte to _QLOCK_LOCKED_SLOWPATH before
+		 * trying to hibernate itself. It is possible that the
+		 * lock byte had been set to _QLOCK_LOCKED_SLOWPATH
+		 * already (spurious wakeup of queue head after a halt).
+		 * In this case, just proceeds to sleeping.
+		 *
+		 *     queue head		    lock holder
+		 *     ----------		    -----------
+		 *     cpustate = PV_CPU_HALTED
+		 * [1] cmpxchg(_QLOCK_LOCKED	[2] cmpxchg(_QLOCK_LOCKED => 0)
+		 * => _QLOCK_LOCKED_SLOWPATH)	    if (cmpxchg fails &&
+		 *     if (cmpxchg succeeds)	    cpustate == PV_CPU_HALTED)
+		 *        halt()		       kick()
+		 *
+		 * Sequence:
+		 * 1,2 - slowpath flag set, queue head halted & lock holder
+		 *	 will call slowpath
+		 * 2,1 - queue head cmpxchg fails, halt is aborted
+		 *
+		 * If the queue head CPU is woken up by a spurious interrupt
+		 * at the same time as the lock holder check the cpustate,
+		 * it is possible that the lock holder will try to kick
+		 * the queue head CPU which isn't halted.
+		 */
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_HALTED;
+		lockval = cmpxchg(&((union arch_qspinlock *)lock)->lock,
+			  _QLOCK_LOCKED, _QLOCK_LOCKED_SLOWPATH);
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
+	if (unlikely(*count >= QSPIN_THRESHOLD)) {
+		/*
+		 * Time to hibernate itself
+		 */
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_HALTED;
+		/*
+		 * In order to avoid the racing between pv_next_node_check()
+		 * and pv_queue_spin_check(), 2 variables handshake is used
+		 * to make sure that pv_next_node_check() won't miss setting
+		 * the _QLOCK_LOCKED_SLOWPATH when the CPU is about to be
+		 * halted.
+		 *
+		 * pv_next_node_check		pv_queue_spin_check
+		 * ------------------		-------------------
+		 * [1] qhead = true		[3] cpustate = PV_CPU_HALTED
+		 *     barrier()		    barrier()
+		 * [2] if (cpustate		[4] if (qhead)
+		 *        == PV_CPU_HALTED)
+		 *
+		 * Sequence:
+		 * *,1,*,4,* - halt is aborted as the qhead flag is set,
+		 *	       _QLOCK_LOCKED_SLOWPATH may or may not be set
+		 * 3,4,1,2 - the CPU is halt and _QLOCK_LOCKED_SLOWPATH is set
+		 */
+		barrier();
+		if (!ACCESS_ONCE(pv->qhead))
+			__queue_hibernate();
+		else
+			pv->qhead = false;
+		ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
+		*count = 0;	/* Reset count */
+	}
+}
+
+/**
+ * pv_next_node_check - set _QLOCK_LOCKED_SLOWPATH flag if the next node
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
+	pv->qhead = true;
+	/*
+	 * Make sure qhead flag is visible before checking the cpustate flag
+	 */
+	barrier();
+	if (ACCESS_ONCE(pv->cpustate) == PV_CPU_HALTED)
+		ACCESS_ONCE(((union arch_qspinlock *)lock)->lock)
+			= _QLOCK_LOCKED_SLOWPATH;
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
+	__queue_kick_cpu(pv->mycpu);
+}
+
+#endif /* _ASM_X86_PVQSPINLOCK_H */
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 3fdc0e2..d1685d1 100644
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
+ * The lock byte can have a value of _QLOCK_LOCKED_SLOWPATH to indicate
+ * that it needs to go through the slowpath to do the unlocking.
+ */
+#define _QLOCK_LOCKED_SLOWPATH	3	/* Set both bits 0 & 1 */
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
+		 * queue head waiter trying to set _QLOCK_LOCKED_SLOWPATH.
+		 */
+		if (likely(cmpxchg(&qlock->lock, _QLOCK_LOCKED, 0)
+				== _QLOCK_LOCKED))
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
index 309b0d6..820217e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -58,6 +58,29 @@
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
@@ -86,13 +109,19 @@ enum exitval {
 
 /*
  * The queue node structure
+ *
+ * If CONFIG_PARAVIRT_SPINLOCKS, the previous node pointer in the pv structure
+ * will be used by the unfair lock code.
  */
 struct qnode {
 	u32		 qhead;		/* Queue head flag		*/
 #ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
 	u32		 prev_qcode;	/* Queue code of previous node	*/
+#ifndef CONFIG_PARAVIRT_SPINLOCKS
 	struct qnode    *qprev;		/* Previous queue node addr	*/
 #endif
+#endif
+	struct pv_qvars  pv;		/* Para-virtualization		*/
 	struct qnode	*next;		/* Next queue node addr		*/
 };
 
@@ -102,6 +131,20 @@ struct qnode_set {
 };
 
 /*
+ * Allow spinning loop count only if either PV spinlock or unfair lock is
+ * configured.
+ */
+#if defined(CONFIG_PARAVIRT_UNFAIR_LOCKS) || defined(CONFIG_PARAVIRT_SPINLOCKS)
+#define	DEF_LOOP_VAR(c)		int c = 0
+#define	INC_LOOP_VAR(c)		(c)++
+#define	LOOP_VAR(c)		c
+#else
+#define	DEF_LOOP_VAR(c)
+#define	INC_LOOP_VAR(c)
+#define	LOOP_VAR(c)		0
+#endif
+
+/*
  * Per-CPU queue node structures
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
@@ -373,6 +416,10 @@ static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
 { return 0; }
 #endif
 
+#ifndef queue_get_qcode
+#define queue_get_qcode(lock)	(atomic_read(&(lock)->qlcode) & ~_QLOCK_LOCKED)
+#endif
+
 #ifndef queue_get_lock_qcode
 /**
  * queue_get_lock_qcode - get the lock & qcode values
@@ -512,9 +559,6 @@ cmpxchg_queue_code(struct qspinlock *lock, u32 ocode, u32 ncode)
  * problem as possible as well as reducing the load on the lock cacheline.
  */
 #ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
-#define	DEF_LOOP_VAR(c)		int c = 0
-#define	INC_LOOP_VAR(c)		(c)++
-#define	LOOP_VAR(c)		c
 #define	LSTEAL_FREQ		(1 << 4)
 #define	LSTEAL_MASK		(LSTEAL_FREQ - 1)
 
@@ -636,9 +680,6 @@ static enum exitval unfair_get_lock(struct qspinlock *lock, struct qnode *node,
 }
 
 #else /* CONFIG_PARAVIRT_UNFAIR_LOCKS */
-#define	DEF_LOOP_VAR(c)
-#define	INC_LOOP_VAR(c)
-#define	LOOP_VAR(c)		0
 
 static void unfair_init_vars(struct qnode *node)	{}
 static void unfair_set_vars(struct qnode *node, struct qnode *prev,
@@ -706,6 +747,17 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	struct qnode *node, *next;
 	u32 prev_qcode, my_qcode;
 	enum exitval exitval;
+	DEF_LOOP_VAR(hcnt);
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	/*
+	 * Disable the quick spinning code path if PV spinlock is enabled to
+	 * make sure that all the spinning CPUs can be halted when the lock
+	 * holder is somehow scheduled out.
+	 */
+	if (static_key_false(&paravirt_spinlocks_enabled))
+		qsval = -1;
+#endif
 
 	/*
 	 * Try the quick spinning code path
@@ -734,6 +786,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	node->qhead = false;
 	node->next  = NULL;
 	unfair_init_vars(node);
+	pv_init_vars(&node->pv, cpu_nr);
 
 	/*
 	 * The lock may be available at this point, try again if no task was
@@ -760,7 +813,9 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 		DEF_LOOP_VAR(cnt);
 
 		unfair_set_vars(node, prev, prev_qcode);
+		pv_set_prev(&node->pv, prev);
 		ACCESS_ONCE(prev->next) = node;
+
 		/*
 		 * Wait until the queue head flag is on
 		 */
@@ -773,7 +828,10 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 				goto release_node;
 			else if (unlikely(exitval == NOTIFY_NEXT))
 				goto notify_next;
+			pv_queue_spin_check(&node->pv, LOOP_VAR(&cnt));
 		}
+	} else {
+		ACCESS_ONCE(node->qhead) = true;
 	}
 
 	/*
@@ -782,6 +840,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	while (true) {
 		u32 qcode;
 
+		INC_LOOP_VAR(hcnt);
 		if (queue_get_lock_qcode(lock, &qcode))
 			;	/* Lock not available yet */
 		else if (qcode != my_qcode) {
@@ -810,6 +869,12 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 				goto release_node;
 		}
 		arch_mutex_cpu_relax();
+
+		/*
+		 * Perform para-virtualization checks
+		 */
+		pv_head_spin_check(&node->pv, LOOP_VAR(&hcnt), prev_qcode,
+				   lock);
 	}
 
 notify_next:
@@ -821,9 +886,53 @@ notify_next:
 	/*
 	 * The next one in queue is now at the head
 	 */
+	pv_next_node_check(&next->pv, lock);
 	smp_store_release(&next->qhead, true);
 
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
+	while (!ACCESS_ONCE(node->qhead)) {
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
