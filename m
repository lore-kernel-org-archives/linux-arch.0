From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v7 04/11] qspinlock: Optimized code path for 2 contending tasks
Date: Wed, 19 Mar 2014 16:14:02 -0400
Message-ID: <1395260049-30839-5-git-send-email-Waiman.Long@hp.com>
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

A major problem with the queue spinlock patch is its performance at
low contention level (2-4 contending tasks) where it is slower than
the corresponding ticket spinlock code. The following table shows the
execution time (in ms) of a micro-benchmark where 5M iterations of
the lock/unlock cycles were run on a 10-core Westere-EX x86-64 CPU
with 2 different types loads - standalone (lock and protected data
in different cachelines) and embedded (lock and protected data in
the same cacheline).

		  [Standalone/Embedded]
  # of tasks	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       1	  135/111	 135/102	  0%/-8%
       2	 1045/950	1943/2022	+86%/+113%
       3	 1827/1783	2372/2428	+30%/+36%
       4	 2689/2725	2934/2934	 +9%/+8%
       5	 3736/3748	3658/3652	 -2%/-3%
       6	 4942/4984	4434/4428	-10%/-11%
       7	 6304/6319	5176/5163	-18%/-18%
       8	 7736/7629	5955/5944	-23%/-22%

It can be seen that the performance degradation is particular bad
with 2 and 3 contending tasks. To reduce that performance deficit
at low contention level, a special specific optimized code path
for 2 contending tasks was added. This special code path can only be
activated with less than 16K of configured CPUs because it uses a byte
in the 32-bit lock word to hold a waiting bit for the 2nd contending
tasks instead of queuing the waiting task in the queue.

With the change, the performance data became:

		  [Standalone/Embedded]
  # of tasks	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       2	 1045/950	1070/1061	 +2%/+12%

In a multi-socketed server, the optimized code path also seems to
produce a pretty good performance improvement in cross-node contention
traffic at low contention level. The table below show the performance
with 1 contending task per node:

		[Standalone]
  # of nodes	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       1	   135		  135		  0%
       2	  4452		 1483		-67%
       3	 10767		13432		+25%
       4	 20835		10796		-48%

Except some drop in performance at the 3 contending tasks level,
the queue spinlock performs much better than the ticket spinlock at
2 and 4 contending tasks level.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qspinlock.h |    3 +-
 kernel/locking/qspinlock.c       |  149 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index acbe155..7f3129c 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -21,9 +21,10 @@ union arch_qspinlock {
 	struct qspinlock slock;
 	struct {
 		u8  lock;	/* Lock bit	*/
-		u8  reserved;
+		u8  wait;	/* Waiting bit	*/
 		u16 qcode;	/* Queue code	*/
 	};
+	u16 lock_wait;		/* Lock and wait bits */
 	u32 qlcode;		/* Complete lock word */
 };
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b093a97..d2da0c0 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -121,6 +121,8 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
  *      o lock      - the lock byte					*
  *      o qcode     - the queue node code				*
  *      o qlcode    - the 32-bit qspinlock word				*
+ *      o wait      - the waiting byte					*
+ *      o lock_wait - the combined lock and waiting bytes		*
  *									*
  ************************************************************************
  */
@@ -131,8 +133,109 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
  * architectures that allows atomic 8/16 bit operations:
  *  1) The 16-bit queue code can be accessed or modified directly as a
  *     16-bit short value without disturbing the first 2 bytes.
+ *  2) The 2nd byte of the 32-bit lock word can be used as a pending bit
+ *     for waiting lock acquirer so that it won't need to go through the
+ *     MCS style locking queuing which has a higher overhead.
  */
+
+/*
+ * Masks for the lock and wait bits
+ */
+#define _QLOCK_WAIT_SHIFT	8	/* Waiting bit position */
+#define _QLOCK_WAITING		(1 << _QLOCK_WAIT_SHIFT)
+#define _QLOCK_LW_MASK		(_QLOCK_WAITING | _QLOCK_LOCKED)
+
 #define queue_encode_qcode(cpu, idx)	(((cpu) + 1) << 2 | (idx))
+#define queue_get_qcode(lock)	(atomic_read(&(lock)->qlcode) >> _QCODE_OFFSET)
+
+#define queue_spin_trylock_quick queue_spin_trylock_quick
+/**
+ * queue_spin_trylock_quick - quick spinning on the queue spinlock
+ * @lock : Pointer to queue spinlock structure
+ * @qsval: Old queue spinlock value
+ * Return: 1 if lock acquired, 0 if failed
+ *
+ * This is an optimized contention path for 2 contending tasks. It
+ * should only be entered if no task is waiting in the queue.
+ *
+ * The lock and wait bits can be in one of following 4 states:
+ *
+ * State lock wait
+ * ----- ---------
+ *  [0]   0    0	Lock is free and no one is waiting
+ *  [1]   1    0	Lock is not available, but no one is waiting
+ *  [2]   0    1	Lock is free, but a waiter is present
+ *  [3]   1    1	Lock is not available and a waiter is present
+ *
+ * A task entering the quick path will set the wait bit and be in either
+ * either states 2 or 3. The allowable transitions are:
+ *
+ *   [3] => [2] => [1] => [0]
+ *    ^             |
+ *    +-------------+
+ */
+static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	/*
+	 * Fall into the quick spinning code path only if no task is waiting
+	 * in the queue.
+	 */
+	while (likely(!(qsval >> _QCODE_OFFSET))) {
+		if ((qsval & _QLOCK_LW_MASK) == _QLOCK_LW_MASK) {
+			/*
+			 * Both the lock and wait bits are set, wait a while
+			 * to see if that changes. It not, quit the quick path.
+			 */
+			arch_mutex_cpu_relax();
+			cpu_relax();
+			qsval = atomic_read(&lock->qlcode);
+			if ((qsval >> _QCODE_OFFSET) ||
+			   ((qsval & _QLOCK_LW_MASK) == _QLOCK_LW_MASK))
+				return 0;
+		}
+
+		/*
+		 * Try to set the corresponding waiting bit
+		 */
+		if (xchg(&qlock->wait, _QLOCK_WAITING >> 8)) {
+			/*
+			 * Wait bit was set already, try again after some delay
+			 * as the waiter will probably get the lock & clear
+			 * the wait bit.
+			 *
+			 * There are 2 cpu_relax() calls to make sure that
+			 * the wait is longer than that of the
+			 * smp_load_acquire() loop below.
+			 */
+			arch_mutex_cpu_relax();
+			cpu_relax();
+			qsval = atomic_read(&lock->qlcode);
+			continue;
+		}
+
+		/*
+		 * Now wait until the lock bit is cleared
+		 */
+		while (smp_load_acquire(&qlock->qlcode) & _QLOCK_LOCKED)
+			arch_mutex_cpu_relax();
+
+		/*
+		 * Set the lock bit & clear the waiting bit simultaneously
+		 * No lock stealing is allowed when this quick path is active.
+		 */
+		ACCESS_ONCE(qlock->lock_wait) = _QLOCK_LOCKED;
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * With the qspinlock quickpath logic activated, disable the trylock logic
+ * in the slowpath as it will be redundant.
+ */
+#define queue_spin_trylock(lock)	(0)
 
 #define queue_code_xchg queue_code_xchg
 /**
@@ -140,14 +243,40 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
  * @lock : Pointer to queue spinlock structure
  * @ocode: Old queue code in the lock [OUT]
  * @ncode: New queue code to be exchanged
- * Return: NORMAL_EXIT is always returned
+ * @qsval: Old queue spinlock value
+ * Return: Either NORMAL_EXIT or RELEASE_NODE
  */
 static inline enum exitval
-queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode)
+queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode, int qsval)
 {
 	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
 
 	*ocode = xchg(&qlock->qcode, (u16)ncode);
+	if ((*ocode == 0) && ((qsval & _QLOCK_LW_MASK) != _QLOCK_LW_MASK)) {
+		/*
+		 * When no one is waiting in the queue before, try to fall
+		 * back into the optimized 2-task contending code path.
+		 */
+		u32 qlcode = ACCESS_ONCE(qlock->qlcode);
+
+		if ((qlcode != ((ncode << _QCODE_OFFSET)|_QLOCK_LOCKED)) ||
+		    (cmpxchg(&qlock->qlcode, qlcode,
+			     _QLOCK_LOCKED|_QLOCK_WAITING) != qlcode))
+			return NORMAL_EXIT;
+		/*
+		 * Successfully fall back to the optimized code path.
+		 * Now wait until the lock byte is cleared
+		 */
+		while (smp_load_acquire(&qlock->qlcode) & _QLOCK_LOCKED)
+			arch_mutex_cpu_relax();
+
+		/*
+		 * Set the lock bit & clear the waiting bit simultaneously
+		 * No lock stealing is allowed when this quick path is active.
+		 */
+		ACCESS_ONCE(qlock->lock_wait) = _QLOCK_LOCKED;
+		return RELEASE_NODE;
+	}
 	return NORMAL_EXIT;
 }
 
@@ -194,7 +323,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
 {
 	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
 
-	return cmpxchg(&qlock->lock, 0, _QLOCK_LOCKED) == 0;
+	return cmpxchg(&qlock->lock_wait, 0, _QLOCK_LOCKED) == 0;
 }
 #else /*  _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS  */
 /*
@@ -223,6 +352,10 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
  * that may get superseded by a more optimized version.			*
  ************************************************************************
  */
+#ifndef queue_spin_trylock_quick
+static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
+{ return 0; }
+#endif
 
 #ifndef queue_get_lock_qcode
 /**
@@ -275,10 +408,11 @@ static inline u32 queue_encode_qcode(u32 cpu_nr, u8 qn_idx)
  * @lock : Pointer to queue spinlock structure
  * @ocode: Old queue code in the lock [OUT]
  * @ncode: New queue code to be exchanged
+ * @qsval: Old queue spinlock value (not used)
  * Return: An enum exitval value
  */
 static inline enum exitval
-queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode)
+queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode, int qsval)
 {
 	ncode |= _QLOCK_LOCKED;	/* Set lock bit */
 
@@ -380,6 +514,11 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	enum exitval exitval;
 
 	/*
+	 * Try the quick spinning code path
+	 */
+	if (queue_spin_trylock_quick(lock, qsval))
+		return;
+	/*
 	 * Get the queue node
 	 */
 	cpu_nr = smp_processor_id();
@@ -411,7 +550,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	/*
 	 * Exchange current copy of the queue node code
 	 */
-	exitval = queue_code_xchg(lock, &prev_qcode, my_qcode);
+	exitval = queue_code_xchg(lock, &prev_qcode, my_qcode, qsval);
 	if (unlikely(exitval == NOTIFY_NEXT))
 		goto notify_next;
 	else if (unlikely(exitval == RELEASE_NODE))
-- 
1.7.1
