From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 3/8] qspinlock,
	x86: Add x86 specific optimization for 2 contending tasks
Date: Wed, 26 Feb 2014 23:32:42 -0500
Message-ID: <1393475567-4453-4-git-send-email-Waiman.Long@hp.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
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
the corresponding ticket spinlock code path. The following table shows
the execution time (in ms) of a micro-benchmark where 5M iterations
of the lock/unlock cycles were run on a 10-core Westere-EX CPU with
2 different types loads - standalone (lock and protected data in
different cachelines) and embedded (lock and protected data in the
same cacheline).

		  [Standalone/Embedded]
  # of tasks	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       1	  135/111	 135/102	  0%/-8%
       2	  732/950	1315/1573	+80%/+66%
       3	 1827/1783	2372/2428	+30%/+36%
       4	 2689/2725	2934/2934	 +9%/+8%
       5	 3736/3748	3658/3652	 -2%/-3%
       6	 4942/4984	4434/4428	-10%/-11%
       7	 6304/6319	5176/5163	-18%/-18%
       8	 7736/7629	5955/5944	-23%/-22%

It can be seen that the performance degradation is particular bad
with 2 and 3 contending tasks. To reduce that performance deficit
at low contention level, a special x86 specific optimized code path
for 2 contending tasks was added. This special code path will only
be activated with less than 16K of configured CPUs because it uses
a byte in the 32-bit lock word to hold a waiting bit for the 2nd
contending tasks instead of queuing the waiting task in the queue.

With the change, the performance data became:

		  [Standalone/Embedded]
  # of tasks	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       2	  732/950	 523/528	-29%/-44%
       3	 1827/1783	2366/2384	+30%/+34%

The queue spinlock code path is now a bit faster with 2 contending
tasks.  There is also a very slight improvement with 3 contending
tasks.

The performance of the optimized code path can vary depending on which
of the several different code paths is taken. It is also not as fair as
the ticket spinlock and some variations on the execution times of the
2 contending tasks.  Testing with different pairs of cores within the
same CPUs shows an execution time that varies from 400ms to 1194ms.
The ticket spinlock code also shows a variation of 718-1146ms which
is probably due to the CPU topology within a socket.

In a multi-socketed server, the optimized code path also seems to
produce a big performance improvement in cross-node contention traffic
at low contention level. The table below show the performance with
1 contending task per node:

		[Standalone]
  # of nodes	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       1	   135		 135		  0%
       2	  4452		 528		-88%
       3	 10767		2369		-78%
       4	 20835		2921		-86%

The micro-benchmark was also run on a 4-core Ivy-Bridge PC. The table
below shows the collected performance data:

		  [Standalone/Embedded]
  # of tasks	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       1	  197/178	  181/150	 -8%/-16%
       2	 1109/928    435-1417/697-2125
       3	 1836/1702  1372-3112/1379-3138
       4	 2717/2429  1842-4158/1846-4170

The performance of the queue lock patch varied from run to run whereas
the performance of the ticket lock was more consistent. The queue
lock figures above were the range of values that were reported.

This optimization can also be easily used by other architectures as
long as they support 8 and 16 bits atomic operations.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qspinlock.h      |   20 ++++-
 include/asm-generic/qspinlock_types.h |    8 ++-
 kernel/locking/qspinlock.c            |  192 ++++++++++++++++++++++++++++++++-
 3 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 44cefee..98db42e 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -7,12 +7,30 @@
 
 #define _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
 
+#define smp_u8_store_release(p, v)	\
+do {					\
+	barrier();			\
+	ACCESS_ONCE(*p) = (v);		\
+} while (0)
+
+/*
+ * As the qcode will be accessed as a 16-bit word, no offset is needed
+ */
+#define _QCODE_VAL_OFFSET	0
+
 /*
  * x86-64 specific queue spinlock union structure
+ * Besides the slock and lock fields, the other fields are only
+ * valid with less than 16K CPUs.
  */
 union arch_qspinlock {
 	struct qspinlock slock;
-	u8		 lock;	/* Lock bit	*/
+	struct {
+		u8  lock;	/* Lock bit	*/
+		u8  wait;	/* Waiting bit	*/
+		u16 qcode;	/* Queue code	*/
+	};
+	u16 lock_wait;		/* Lock and wait bits */
 };
 
 #define	queue_spin_unlock queue_spin_unlock
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index df981d0..3a02a9e 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -48,7 +48,13 @@ typedef struct qspinlock {
 	atomic_t	qlcode;	/* Lock + queue code */
 } arch_spinlock_t;
 
-#define _QCODE_OFFSET		8
+#if CONFIG_NR_CPUS >= (1 << 14)
+# define _Q_MANY_CPUS
+# define _QCODE_OFFSET	8
+#else
+# define _QCODE_OFFSET	16
+#endif
+
 #define _QSPINLOCK_LOCKED	1U
 #define	_QSPINLOCK_LOCK_MASK	0xff
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ed5efa7..22a63fa 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -109,8 +109,11 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { {{0}}, 0 };
  *  2) A smp_u8_store_release() macro for byte size store operation	*
  *  3) A "union arch_qspinlock" structure that include the individual	*
  *     fields of the qspinlock structure, including:			*
- *      o slock - the qspinlock structure				*
- *      o lock  - the lock byte						*
+ *      o slock     - the qspinlock structure				*
+ *      o lock      - the lock byte					*
+ *      o wait      - the waiting byte					*
+ *      o qcode     - the queue node code				*
+ *      o lock_wait - the combined lock and waiting bytes		*
  *									*
  ************************************************************************
  */
@@ -129,6 +132,176 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
 		return 1;
 	return 0;
 }
+
+#ifndef _Q_MANY_CPUS
+/*
+ * With less than 16K CPUs, the following optimizations are possible with
+ * the x86 architecture:
+ *  1) The 2nd byte of the 32-bit lock word can be used as a pending bit
+ *     for waiting lock acquirer so that it won't need to go through the
+ *     MCS style locking queuing which has a higher overhead.
+ *  2) The 16-bit queue code can be accessed or modified directly as a
+ *     16-bit short value without disturbing the first 2 bytes.
+ */
+#define	_QSPINLOCK_WAITING	0x100U	/* Waiting bit in 2nd byte   */
+#define	_QSPINLOCK_LWMASK	0xffff	/* Mask for lock & wait bits */
+
+#define queue_encode_qcode(cpu, idx)	(((cpu) + 1) << 2 | (idx))
+
+#define queue_spin_trylock_quick queue_spin_trylock_quick
+/**
+ * queue_spin_trylock_quick - fast spinning on the queue spinlock
+ * @lock : Pointer to queue spinlock structure
+ * @qsval: Old queue spinlock value
+ * Return: 1 if lock acquired, 0 if failed
+ *
+ * This is an optimized contention path for 2 contending tasks. It
+ * should only be entered if no task is waiting in the queue. This
+ * optimized path is not as fair as the ticket spinlock, but it offers
+ * slightly better performance. The regular MCS locking path for 3 or
+ * more contending tasks, however, is fair.
+ *
+ * Depending on the exact timing, there are several different paths where
+ * a contending task can take. The actual contention performance depends
+ * on which path is taken. So it can be faster or slower than the
+ * corresponding ticket spinlock path. On average, it is probably on par
+ * with ticket spinlock.
+ */
+static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+	u16		     old;
+
+	/*
+	 * Fall into the quick spinning code path only if no one is waiting
+	 * or the lock is available.
+	 */
+	if (unlikely((qsval != _QSPINLOCK_LOCKED) &&
+		     (qsval != _QSPINLOCK_WAITING)))
+		return 0;
+
+	old = xchg(&qlock->lock_wait, _QSPINLOCK_WAITING|_QSPINLOCK_LOCKED);
+
+	if (old == 0) {
+		/*
+		 * Got the lock, can clear the waiting bit now
+		 */
+		smp_u8_store_release(&qlock->wait, 0);
+		return 1;
+	} else if (old == _QSPINLOCK_LOCKED) {
+try_again:
+		/*
+		 * Wait until the lock byte is cleared to get the lock
+		 */
+		do {
+			cpu_relax();
+		} while (ACCESS_ONCE(qlock->lock));
+		/*
+		 * Set the lock bit & clear the waiting bit
+		 */
+		if (cmpxchg(&qlock->lock_wait, _QSPINLOCK_WAITING,
+			   _QSPINLOCK_LOCKED) == _QSPINLOCK_WAITING)
+			return 1;
+		/*
+		 * Someone has steal the lock, so wait again
+		 */
+		goto try_again;
+	} else if (old == _QSPINLOCK_WAITING) {
+		/*
+		 * Another task is already waiting while it steals the lock.
+		 * A bit of unfairness here won't change the big picture.
+		 * So just take the lock and return.
+		 */
+		return 1;
+	}
+	/*
+	 * Nothing need to be done if the old value is
+	 * (_QSPINLOCK_WAITING | _QSPINLOCK_LOCKED).
+	 */
+	return 0;
+}
+
+#define queue_code_xchg queue_code_xchg
+/**
+ * queue_code_xchg - exchange a queue code value
+ * @lock : Pointer to queue spinlock structure
+ * @qcode: New queue code to be exchanged
+ * Return: The original qcode value in the queue spinlock
+ */
+static inline u32 queue_code_xchg(struct qspinlock *lock, u32 qcode)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	return (u32)xchg(&qlock->qcode, (u16)qcode);
+}
+
+#define queue_spin_trylock_and_clr_qcode queue_spin_trylock_and_clr_qcode
+/**
+ * queue_spin_trylock_and_clr_qcode - Try to lock & clear qcode simultaneously
+ * @lock : Pointer to queue spinlock structure
+ * @qcode: The supposedly current qcode value
+ * Return: true if successful, false otherwise
+ */
+static inline int
+queue_spin_trylock_and_clr_qcode(struct qspinlock *lock, u32 qcode)
+{
+	qcode <<= _QCODE_OFFSET;
+	return atomic_cmpxchg(&lock->qlcode, qcode, _QSPINLOCK_LOCKED) == qcode;
+}
+
+#define queue_get_lock_qcode queue_get_lock_qcode
+/**
+ * queue_get_lock_qcode - get the lock & qcode values
+ * @lock  : Pointer to queue spinlock structure
+ * @qcode : Pointer to the returned qcode value
+ * @mycode: My qcode value
+ * Return : > 0 if lock is not available
+ *	   = 0 if lock is free
+ *	   < 0 if lock is taken & can return after cleanup
+ *
+ * It is considered locked when either the lock bit or the wait bit is set.
+ */
+static inline int
+queue_get_lock_qcode(struct qspinlock *lock, u32 *qcode, u32 mycode)
+{
+	u32 qlcode;
+
+	qlcode = (u32)atomic_read(&lock->qlcode);
+	/*
+	 * With the special case that qlcode contains only _QSPINLOCK_LOCKED
+	 * and mycode. It will try to transition back to the quick spinning
+	 * code by clearing the qcode and setting the _QSPINLOCK_WAITING
+	 * bit.
+	 */
+	if (qlcode == (_QSPINLOCK_LOCKED | (mycode << _QCODE_OFFSET))) {
+		u32 old = qlcode;
+
+		qlcode = atomic_cmpxchg(&lock->qlcode, old,
+				_QSPINLOCK_LOCKED|_QSPINLOCK_WAITING);
+		if (qlcode == old) {
+			union arch_qspinlock *slock =
+				(union arch_qspinlock *)lock;
+try_again:
+			/*
+			 * Wait until the lock byte is cleared
+			 */
+			do {
+				cpu_relax();
+			} while (ACCESS_ONCE(slock->lock));
+			/*
+			 * Set the lock bit & clear the waiting bit
+			 */
+			if (cmpxchg(&slock->lock_wait, _QSPINLOCK_WAITING,
+				    _QSPINLOCK_LOCKED) == _QSPINLOCK_WAITING)
+				return -1;	/* Got the lock */
+			goto try_again;
+		}
+	}
+	*qcode = qlcode >> _QCODE_OFFSET;
+	return qlcode & _QSPINLOCK_LWMASK;
+}
+#endif /* _Q_MANY_CPUS */
+
 #else /*  _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS  */
 /*
  * Generic functions for architectures that do not support atomic
@@ -144,7 +317,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
 	int qlcode = atomic_read(lock->qlcode);
 
 	if (!(qlcode & _QSPINLOCK_LOCKED) && (atomic_cmpxchg(&lock->qlcode,
-		qlcode, qlcode|_QSPINLOCK_LOCKED) == qlcode))
+		qlcode, code|_QSPINLOCK_LOCKED) == qlcode))
 			return 1;
 	return 0;
 }
@@ -156,6 +329,10 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
  * that may get superseded by a more optimized version.			*
  ************************************************************************
  */
+#ifndef queue_spin_trylock_quick
+static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
+{ return 0; }
+#endif
 
 #ifndef queue_get_lock_qcode
 /**
@@ -266,6 +443,11 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	u32 prev_qcode, my_qcode;
 
 	/*
+	 * Try the quick spinning code path
+	 */
+	if (queue_spin_trylock_quick(lock, qsval))
+		return;
+	/*
 	 * Get the queue node
 	 */
 	cpu_nr = smp_processor_id();
@@ -296,6 +478,9 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 		return;
 	}
 
+#ifdef queue_code_xchg
+	prev_qcode = queue_code_xchg(lock, my_qcode);
+#else
 	/*
 	 * Exchange current copy of the queue node code
 	 */
@@ -329,6 +514,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
 	} else
 		prev_qcode &= ~_QSPINLOCK_LOCKED;	/* Clear the lock bit */
 	my_qcode &= ~_QSPINLOCK_LOCKED;
+#endif /* queue_code_xchg */
 
 	if (prev_qcode) {
 		/*
-- 
1.7.1
