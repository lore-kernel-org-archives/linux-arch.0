From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v7 05/11] pvqspinlock, x86: Allow unfair spinlock in a PV guest
Date: Wed, 19 Mar 2014 16:14:03 -0400
Message-ID: <1395260049-30839-6-git-send-email-Waiman.Long@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew
List-Id: linux-arch.vger.kernel.org

Locking is always an issue in a virtualized environment as the virtual
CPU that is waiting on a lock may get scheduled out and hence block
any progress in lock acquisition even when the lock has been freed.

One solution to this problem is to allow unfair lock in a
para-virtualized environment. In this case, a new lock acquirer can
come and steal the lock if the next-in-line CPU to get the lock is
scheduled out. Other CPUs queued behind the scheduled-out CPU may
also attempt to steal the lock, though at a lower frequency (1/16)
to give the queue head a higher chance of getting the lock.

An alternative is to use a simple unfair byte lock which can, in some
cases, provide a bit better performance than the queue unfair lock
mentioned above. However, the chance of lock starvation problem is
also likely to be higher.

Unfair lock in a native environment is generally not a good idea as
there is a possibility of lock starvation for a heavily contended lock.

This patch add a new configuration option for the x86 architecture to
enable the use of unfair queue spinlock (PARAVIRT_UNFAIR_LOCKS) in a
para-virtualized guest. A jump label (paravirt_unfairlocks_enabled)
is used to switch between a fair and an unfair version of the spinlock
code. This jump label will only be enabled in a PV guest.

Enabling this configuration feature causes a slight decrease the
performance of an uncontended lock-unlock operation by about 1-2%
mainly due to the use of a static key. However, uncontended lock-unlock
operation are really just a tiny percentage of a real workload. So
there should no noticeable change in application performance.

With the unfair locking activated on bare metal 4-socket Westmere-EX
box, the execution times (in ms) of a spinlock micro-benchmark were
as follows:

  # of    Ticket       Fair	    Unfair	  Unfair
  tasks    lock     queue lock    queue lock	byte lock
  ------  -------   ----------    ----------	---------
    1       135        135	     137	  137
    2      1045       1120	     462	  462
    3      1827       2345     	     794	  963
    4      2689       2934	    1323	 1706
    5      3736       3658	    1902	 2127
    6      4942       4434	    2733	 2980
    7      6304       5176          3416	 3491
    8      7736       5955          4342	 3955

Executing one task per node, the performance data were:

  # of    Ticket       Fair	    Unfair	  Unfair
  nodes    lock     queue lock    queue lock	byte lock
  ------  -------   ----------    ----------	---------
    1        135        135          137	  137
    2       4452       1736          715	  710
    3      10767      13432         1508	 1468
    4      20835      10796         2697	 2582

The performance of a simple unfair byte lock is pretty close to the
unfair queue lock. Of course there are pretty big variation in the
execution times of each individual task. For the 4 nodes case above,
the standard deviation was 785ms.

In general, the shorter the critical section, the better the
performance benefit of an unfair lock. For large critical section,
however, there may not be much benefit.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/Kconfig                     |   11 ++
 arch/x86/include/asm/qspinlock.h     |   72 +++++++++++
 arch/x86/kernel/Makefile             |    1 +
 arch/x86/kernel/paravirt-spinlocks.c |    7 +
 kernel/locking/qspinlock.c           |  227 +++++++++++++++++++++++++++++++++-
 5 files changed, 312 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index de573f9..010abc4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -629,6 +629,17 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
+config PARAVIRT_UNFAIR_LOCKS
+	bool "Enable unfair locks in a para-virtualized guest"
+	depends on PARAVIRT && SMP && QUEUE_SPINLOCK
+	depends on !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE
+	---help---
+	  This changes the kernel to use unfair locks in a
+	  para-virtualized guest. This will help performance in most
+	  cases. However, there is a possibility of lock starvation
+	  on a heavily contended lock especially in a large guest
+	  with many virtual CPUs.
+
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 7f3129c..3fdc0e2 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -51,4 +51,76 @@ static inline void queue_spin_unlock(struct qspinlock *lock)
 
 #include <asm-generic/qspinlock.h>
 
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+/**
+ * queue_spin_lock_unfair - acquire a queue spinlock unfairly
+ * @lock: Pointer to queue spinlock structure
+ */
+static __always_inline void queue_spin_lock_unfair(struct qspinlock *lock)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	if (likely(cmpxchg(&qlock->lock, 0, _QLOCK_LOCKED) == 0))
+		return;
+	/*
+	 * Since the lock is now unfair, we should not activate the 2-task
+	 * quick spinning code path which disallows lock stealing.
+	 */
+	queue_spin_lock_slowpath(lock, -1);
+}
+
+/**
+ * queue_spin_trylock_unfair - try to acquire the queue spinlock unfairly
+ * @lock : Pointer to queue spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static __always_inline int queue_spin_trylock_unfair(struct qspinlock *lock)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	if (!qlock->lock && (cmpxchg(&qlock->lock, 0, _QLOCK_LOCKED) == 0))
+		return 1;
+	return 0;
+}
+
+/*
+ * Redefine arch_spin_lock and arch_spin_trylock as inline functions that will
+ * jump to the unfair versions if the static key paravirt_unfairlocks_enabled
+ * is true.
+ */
+#undef arch_spin_lock
+#undef arch_spin_trylock
+#undef arch_spin_lock_flags
+
+extern struct static_key paravirt_unfairlocks_enabled;
+
+/**
+ * arch_spin_lock - acquire a queue spinlock
+ * @lock: Pointer to queue spinlock structure
+ */
+static inline void arch_spin_lock(struct qspinlock *lock)
+{
+	if (static_key_false(&paravirt_unfairlocks_enabled))
+		queue_spin_lock_unfair(lock);
+	else
+		queue_spin_lock(lock);
+}
+
+/**
+ * arch_spin_trylock - try to acquire the queue spinlock
+ * @lock : Pointer to queue spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static inline int arch_spin_trylock(struct qspinlock *lock)
+{
+	if (static_key_false(&paravirt_unfairlocks_enabled))
+		return queue_spin_trylock_unfair(lock);
+	else
+		return queue_spin_trylock(lock);
+}
+
+#define arch_spin_lock_flags(l, f)	arch_spin_lock(l)
+
+#endif /* CONFIG_PARAVIRT_UNFAIR_LOCKS */
+
 #endif /* _ASM_X86_QSPINLOCK_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index cb648c8..1107a20 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_$(BITS).o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
+obj-$(CONFIG_PARAVIRT_UNFAIR_LOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index bbb6c73..a50032a 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -8,6 +8,7 @@
 
 #include <asm/paravirt.h>
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
 	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
@@ -18,3 +19,9 @@ EXPORT_SYMBOL(pv_lock_ops);
 
 struct static_key paravirt_ticketlocks_enabled = STATIC_KEY_INIT_FALSE;
 EXPORT_SYMBOL(paravirt_ticketlocks_enabled);
+#endif
+
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+struct static_key paravirt_unfairlocks_enabled = STATIC_KEY_INIT_FALSE;
+EXPORT_SYMBOL(paravirt_unfairlocks_enabled);
+#endif
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index d2da0c0..309b0d6 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -86,13 +86,13 @@ enum exitval {
 
 /*
  * The queue node structure
- *
- * This structure is essentially the same as the mcs_spinlock structure
- * in mcs_spinlock.h file. It is retained for future extension where new
- * fields may be added.
  */
 struct qnode {
 	u32		 qhead;		/* Queue head flag		*/
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+	u32		 prev_qcode;	/* Queue code of previous node	*/
+	struct qnode    *qprev;		/* Previous queue node addr	*/
+#endif
 	struct qnode	*next;		/* Next queue node addr		*/
 };
 
@@ -280,6 +280,22 @@ queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode, int qsval)
 	return NORMAL_EXIT;
 }
 
+#define	cmpxchg_queue_code cmpxchg_queue_code
+/**
+ * cmpxchg_queue_code - compare and exchange a queue code value in the lock
+ * @lock : Pointer to queue spinlock structure
+ * @ocode: Old queue code value
+ * @ncode: New queue code value
+ * Return: true if compare and exchange successful, false otherwise
+ */
+static inline int
+cmpxchg_queue_code(struct qspinlock *lock, u32 ocode, u32 ncode)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	return cmpxchg(&qlock->qcode, (u16)ocode, (u16)ncode) == (u16)ocode;
+}
+
 #define queue_spin_trylock_and_clr_qcode queue_spin_trylock_and_clr_qcode
 /**
  * queue_spin_trylock_and_clr_qcode - Try to lock & clear qcode simultaneously
@@ -455,6 +471,184 @@ queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode, int qsval)
 }
 #endif /* queue_code_xchg */
 
+#ifndef cmpxchg_queue_code
+/**
+ * cmpxchg_queue_code - compare and exchange a queue code value in the lock
+ * @lock : Pointer to queue spinlock structure
+ * @ocode: Old queue code value
+ * @ncode: New queue code value
+ * Return: true if compare and exchange successful, false otherwise
+ */
+static inline int
+cmpxchg_queue_code(struct qspinlock *lock, u32 ocode, u32 ncode)
+{
+	u32 lockval = atomic_read(lock->qlcode) & _QLOCK_LOCK_MASK;
+
+	ocode |= lockval;
+	ncode |= lockval;
+	return atomic_cmpxchg(&lock->qlcode, ocode, ncode) == ocode;
+}
+#endif /* cmpxchg_queue_code */
+
+/*
+ ************************************************************************
+ * Inline functions for supporting unfair queue lock			*
+ ************************************************************************
+ */
+/*
+ * Unfair lock support in a paravirtualized guest
+ *
+ * With unfair lock enabled, lock stealing is allowed in the following
+ * places:
+ *  1) In the spin_lock and spin_trylock functiopns
+ *  2) When spinning in the waiter queue before becoming the queue head
+ *
+ * A lock acquirer has only one chance of stealing the lock in the spin_lock
+ * and spin_trylock function. If the attempt fails for spin_lock, the task
+ * will be queued in the wait queue. In there, the task will still attempt
+ * to steal the lock periodically at a lesser frequency to give the queue
+ * head a higher chance of getting the lock. This is to ensure that there
+ * will be some forward progress to avoid as much of the lock starvation
+ * problem as possible as well as reducing the load on the lock cacheline.
+ */
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+#define	DEF_LOOP_VAR(c)		int c = 0
+#define	INC_LOOP_VAR(c)		(c)++
+#define	LOOP_VAR(c)		c
+#define	LSTEAL_FREQ		(1 << 4)
+#define	LSTEAL_MASK		(LSTEAL_FREQ - 1)
+
+/**
+ * unfair_init_vars - initialize unfair relevant fields in queue node structure
+ * @node: Current queue node address
+ */
+static void unfair_init_vars(struct qnode *node)
+{
+	node->qprev	 = NULL;
+	node->prev_qcode = 0;
+}
+
+/**
+ * unfair_set_vars - set unfair related fields in the queue node structure
+ * @node      : Current queue node address
+ * @prev      : Previous queue node address
+ * @prev_qcode: Previous qcode value
+ */
+static void
+unfair_set_vars(struct qnode *node, struct qnode *prev, u32 prev_qcode)
+{
+	node->qprev	 = prev;
+	node->prev_qcode = prev_qcode;
+	/* Make sure the new fields are visible to others */
+	smp_wmb();
+}
+
+/**
+ * unfair_check_qcode - check the current to see if it is the last one
+ *			and need to be cleared.
+ * @lock    : Pointer to queue spinlock structure
+ * @my_qcode: My queue code value to be checked again
+ * Return   : Either RELEASE_NODE or NOTIFY_NEXT
+ */
+static enum exitval unfair_check_qcode(struct qspinlock *lock, u32 my_qcode)
+{
+	u32 qcode;
+
+	if (!static_key_false(&paravirt_unfairlocks_enabled))
+		return NOTIFY_NEXT;
+
+	(void)queue_get_lock_qcode(lock, &qcode);
+	/*
+	 * Try to clear the current queue code if it match my_qcode
+	 */
+	if ((qcode == my_qcode) && cmpxchg_queue_code(lock, my_qcode, 0))
+		return RELEASE_NODE;
+	return NOTIFY_NEXT;
+}
+
+/**
+ * unfair_get_lock - try to steal the lock periodically
+ * @lock    : Pointer to queue spinlock structure
+ * @node    : Current queue node address
+ * @my_qcode: My queue code value
+ * @count   : Loop count
+ * Return   : NORMAL_EXIT, RELEASE_NODE or NOTIFY_NEXT
+ */
+static enum exitval unfair_get_lock(struct qspinlock *lock, struct qnode *node,
+				    u32 my_qcode, int count)
+{
+	u32	     qcode, pqcode;
+	int	     qhead;
+	struct qnode *next;
+
+	if (!static_key_false(&paravirt_unfairlocks_enabled))
+		return NORMAL_EXIT;
+
+	if (((count & LSTEAL_MASK) != LSTEAL_MASK) ||
+	   !queue_spin_trylock_unfair(lock))
+		return NORMAL_EXIT;
+
+	/*
+	 * Have stolen the lock, need to remove itself from the wait queue
+	 * 1) If it is at the end of the queue, change the qcode in the lock
+	 *    word to the one before it.
+	 * 2) Change the next pointer in the previous queue node to point
+	 *    to the next one in queue or NULL if it is at the end of queue.
+	 * 3) If a next node is present, copy the prev_qcode and qprev values
+	 *    to the next node.
+	 */
+	(void)queue_get_lock_qcode(lock, &qcode);
+	qhead  = ACCESS_ONCE(node->qhead);
+	pqcode = qhead ? 0 : node->prev_qcode;
+
+	if ((qcode == my_qcode) && cmpxchg_queue_code(lock, my_qcode, pqcode)) {
+		/*
+		 * Successfully change the qcode back to the previous one.
+		 * Now need to clear the next pointer in the previous node
+		 * only if it contains my queue node address. Whether the
+		 * cmpxchg() call below fails or succeeds doesn't really
+		 * matter.
+		 */
+		(void)cmpxchg(&node->qprev->next, node, NULL);
+		return RELEASE_NODE;
+	}
+
+	/* Wait until the next pointer is set */
+	while (!(next = ACCESS_ONCE(node->next)))
+		arch_mutex_cpu_relax();
+
+	if (!qhead) {
+		/*
+		 * Change the node data only if it is not the queue head
+		 */
+		ACCESS_ONCE(node->qprev->next) = next;
+		ACCESS_ONCE(next->qprev)       = node->qprev;
+		ACCESS_ONCE(next->prev_qcode)  = node->prev_qcode;
+
+		/*
+		 * Make sure all the new node information are visible
+		 * before proceeding.
+		 */
+		smp_wmb();
+		return RELEASE_NODE;
+	}
+	return NOTIFY_NEXT;
+}
+
+#else /* CONFIG_PARAVIRT_UNFAIR_LOCKS */
+#define	DEF_LOOP_VAR(c)
+#define	INC_LOOP_VAR(c)
+#define	LOOP_VAR(c)		0
+
+static void unfair_init_vars(struct qnode *node)	{}
+static void unfair_set_vars(struct qnode *node, struct qnode *prev,
+		u32 prev_qcode)				{}
+static enum exitval unfair_get_lock(struct qspinlock *lock, struct qnode *node,
+		u32 my_qcode, int count)		{ return NORMAL_EXIT; }
+static enum exitval unfair_check_qcode(struct qspinlock *lock, u32 my_qcode)
+							{ return NORMAL_EXIT; }
+#endif /* CONFIG_PARAVIRT_UNFAIR_LOCKS */
+
 /*
  ************************************************************************
  * Other inline functions needed by the queue_spin_lock_slowpath()	*
@@ -539,6 +733,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	 */
 	node->qhead = false;
 	node->next  = NULL;
+	unfair_init_vars(node);
 
 	/*
 	 * The lock may be available at this point, try again if no task was
@@ -562,13 +757,23 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 		 * and set up the "next" fields of the that node.
 		 */
 		struct qnode *prev = xlate_qcode(prev_qcode);
+		DEF_LOOP_VAR(cnt);
 
+		unfair_set_vars(node, prev, prev_qcode);
 		ACCESS_ONCE(prev->next) = node;
 		/*
 		 * Wait until the queue head flag is on
 		 */
-		while (!smp_load_acquire(&node->qhead))
+		while (!smp_load_acquire(&node->qhead)) {
+			INC_LOOP_VAR(cnt);
 			arch_mutex_cpu_relax();
+			exitval = unfair_get_lock(lock, node, my_qcode,
+						 LOOP_VAR(cnt));
+			if (unlikely(exitval == RELEASE_NODE))
+				goto release_node;
+			else if (unlikely(exitval == NOTIFY_NEXT))
+				goto notify_next;
+		}
 	}
 
 	/*
@@ -584,8 +789,18 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 			 * Just get the lock with other spinners waiting
 			 * in the queue.
 			 */
-			if (queue_spin_setlock(lock))
+			if (queue_spin_setlock(lock)) {
+				/*
+				 * The unfair lock stealing code may have the
+				 * next one get the lock first and thus don't
+				 * need to be notify.
+				 * Need to recheck the qcode value in the lock
+				 */
+				if (unlikely(unfair_check_qcode(lock, my_qcode)
+						== RELEASE_NODE))
+					goto release_node;
 				goto notify_next;
+			}
 		} else {
 			/*
 			 * Get the lock & clear the queue code simultaneously
-- 
1.7.1
