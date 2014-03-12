From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v6 04/11] qspinlock: Optimized code path for 2 contending tasks
Date: Wed, 12 Mar 2014 14:54:51 -0400
Message-ID: <1394650498-30118-5-git-send-email-Waiman.Long@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
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
       2	 1045/950	1120/1045	 +7%/+10%

In a multi-socketed server, the optimized code path also seems to
produce a pretty good performance improvement in cross-node contention
traffic at low contention level. The table below show the performance
with 1 contending task per node:

		[Standalone]
  # of nodes	Ticket lock	Queue lock	%Change
  ----------	-----------	----------	-------
       1	   135		  135		  0%
       2	  4452		 1736		-61%
       3	 10767		13432		+25%
       4	 20835		10796		-48%

Except some drop in performance at the 3 contending tasks level,
the queue spinlock performs much better than the ticket spinlock at
2 and 4 contending tasks level.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qspinlock.h |    3 +-
 kernel/locking/qspinlock.c       |  137 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 4 deletions(-)

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
index 52d3580..0030fad 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -112,6 +112,8 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
  *      o lock      - the lock byte					*
  *      o qcode     - the queue node code				*
  *      o qlcode    - the 32-bit qspinlock word				*
+ *      o wait      - the waiting byte					*
+ *      o lock_wait - the combined lock and waiting bytes		*
  *									*
  ************************************************************************
  */
@@ -122,8 +124,101 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
  * architectures that allows atomic 8/16 bit operations:
  *  1) The 16-bit queue code can be accessed or modified directly as a
  *     16-bit short value without disturbing the first 2 bytes.
+ *  2) The 2nd byte of the 32-bit lock word can be used as a pending bit
+ *     for waiting lock acquirer so that it won't need to go through the
+ *     MCS style locking queuing which has a higher overhead.
  */
+#define _QSPINLOCK_WAIT_SHIFT	8	/* Waiting bit position */
+#define _QSPINLOCK_WAITING	(1 << _QSPINLOCK_WAIT_SHIFT)
+/* Masks for lock & wait bits   */
+#define _QSPINLOCK_LWMASK	(_QSPINLOCK_WAITING | _QSPINLOCK_LOCKED)
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
+		if ((qsval & _QSPINLOCK_LWMASK) == _QSPINLOCK_LWMASK) {
+			/*
+			 * Both the lock and wait bits are set, wait a while
+			 * to see if that changes. It not, quit the quick path.
+			 */
+			cpu_relax();
+			cpu_relax();
+			qsval = atomic_read(&lock->qlcode);
+			if ((qsval >> _QCODE_OFFSET) ||
+			   ((qsval & _QSPINLOCK_LWMASK) == _QSPINLOCK_LWMASK))
+				return 0;
+		}
+
+		/*
+		 * Try to set the corresponding waiting bit
+		 */
+		if (xchg(&qlock->wait, _QSPINLOCK_WAITING >> 8)) {
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
+			arch_mutex_cpu_relax();
+			qsval = atomic_read(&lock->qlcode);
+			continue;
+		}
+
+		/*
+		 * Now wait until the lock bit is cleared
+		 */
+		while (smp_load_acquire(&qlock->qlcode) & _QSPINLOCK_LOCKED)
+			arch_mutex_cpu_relax();
+
+		/*
+		 * Set the lock bit & clear the waiting bit simultaneously
+		 * It is assumed that there is no lock stealing with this
+		 * quick path active.
+		 *
+		 * A direct memory store of _QSPINLOCK_LOCKED into the
+		 * lock_wait field causes problem with the lockref code, e.g.
+		 *   ACCESS_ONCE(qlock->lock_wait) = _QSPINLOCK_LOCKED;
+		 *
+		 * It is not currently clear why this happens. A workaround
+		 * is to use atomic instruction to store the new value.
+		 */
+		{
+			u16 lw = xchg(&qlock->lock_wait, _QSPINLOCK_LOCKED);
+			BUG_ON(lw != _QSPINLOCK_WAITING);
+		}
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
@@ -131,13 +226,40 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
  * @lock : Pointer to queue spinlock structure
  * @ocode: Old queue code in the lock [OUT]
  * @ncode: New queue code to be exchanged
- * Return: 0 is always returned
+ * Return: 1 if lock is taken and so can release the queue node, 0 otherwise.
  */
 static inline int queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode)
 {
 	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
 
 	*ocode = xchg(&qlock->qcode, (u16)ncode);
+	if (*ocode == 0) {
+		/*
+		 * When no one is waiting in the queue before, try to fall
+		 * back into the optimized 2-task contending code path.
+		 */
+		u32 qlcode = ACCESS_ONCE(qlock->qlcode);
+
+		if ((qlcode != ((ncode << _QCODE_OFFSET)|_QSPINLOCK_LOCKED)) ||
+		    (cmpxchg(&qlock->qlcode, qlcode,
+			     _QSPINLOCK_LOCKED|_QSPINLOCK_WAITING) != qlcode))
+			return 0;
+retry_lock:
+		/*
+		 * Successfully fall back to the optimized code path.
+		 * Now wait until the lock byte is cleared
+		 */
+		while (smp_load_acquire(&qlock->qlcode) & _QSPINLOCK_LOCKED)
+			arch_mutex_cpu_relax();
+		/*
+		 * Use cmpxchg to set the lock bit & clear the waiting bit
+		 */
+		if (cmpxchg(&qlock->lock_wait, _QSPINLOCK_WAITING,
+			    _QSPINLOCK_LOCKED) == _QSPINLOCK_WAITING)
+			return 1;	/* Got the lock */
+		arch_mutex_cpu_relax();
+		goto retry_lock;
+	}
 	return 0;
 }
 
@@ -172,7 +294,7 @@ queue_get_lock_qcode(struct qspinlock *lock, u32 *qcode, u32 mycode)
 	u32 qlcode = (u32)atomic_read(&lock->qlcode);
 
 	*qcode = qlcode >> _QCODE_OFFSET;
-	return qlcode & _QSPINLOCK_LOCKED;
+	return qlcode & _QSPINLOCK_LWMASK;
 }
 #endif /* _Q_MANY_CPUS */
 
@@ -185,7 +307,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
 {
 	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
 
-	return cmpxchg(&qlock->lock, 0, _QSPINLOCK_LOCKED) == 0;
+	return cmpxchg(&qlock->lock_wait, 0, _QSPINLOCK_LOCKED) == 0;
 }
 #else /*  _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS  */
 /*
@@ -214,6 +336,10 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
  * that may get superseded by a more optimized version.			*
  ************************************************************************
  */
+#ifndef queue_spin_trylock_quick
+static inline int queue_spin_trylock_quick(struct qspinlock *lock, int qsval)
+{ return 0; }
+#endif
 
 #ifndef queue_get_lock_qcode
 /**
@@ -372,6 +498,11 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, int qsval)
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
-- 
1.7.1
