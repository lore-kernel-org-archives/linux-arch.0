From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 05/15] qspinlock: Optimize for smaller NR_CPUS
Date: Mon,  6 Apr 2015 22:55:40 -0400
Message-ID: <1428375350-9213-6-git-send-email-Waiman.Long@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

When we allow for a max NR_CPUS < 2^14 we can optimize the pending
wait-acquire and the xchg_tail() operations.

By growing the pending bit to a byte, we reduce the tail to 16bit.
This means we can use xchg16 for the tail part and do away with all
the repeated compxchg() operations.

This in turn allows us to unconditionally acquire; the locked state
as observed by the wait loops cannot change. And because both locked
and pending are now a full byte we can use simple stores for the
state transition, obviating one atomic operation entirely.

This optimization is needed to make the qspinlock achieve performance
parity with ticket spinlock at light load.

All this is horribly broken on Alpha pre EV56 (and any other arch that
cannot do single-copy atomic byte stores).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 include/asm-generic/qspinlock_types.h |   13 ++++++
 kernel/locking/qspinlock.c            |   69 ++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index ef36613..f01b55d 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -35,6 +35,14 @@ typedef struct qspinlock {
 /*
  * Bitfields in the atomic value:
  *
+ * When NR_CPUS < 16K
+ *  0- 7: locked byte
+ *     8: pending
+ *  9-15: not used
+ * 16-17: tail index
+ * 18-31: tail cpu (+1)
+ *
+ * When NR_CPUS >= 16K
  *  0- 7: locked byte
  *     8: pending
  *  9-10: tail index
@@ -47,7 +55,11 @@ typedef struct qspinlock {
 #define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
 
 #define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#if CONFIG_NR_CPUS < (1U << 14)
+#define _Q_PENDING_BITS		8
+#else
 #define _Q_PENDING_BITS		1
+#endif
 #define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
 
 #define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
@@ -58,6 +70,7 @@ typedef struct qspinlock {
 #define _Q_TAIL_CPU_BITS	(32 - _Q_TAIL_CPU_OFFSET)
 #define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
 
+#define _Q_TAIL_OFFSET		_Q_TAIL_IDX_OFFSET
 #define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
 
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 11f6ad9..bcc99e6 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/mutex.h>
+#include <asm/byteorder.h>
 #include <asm/qspinlock.h>
 
 /*
@@ -56,6 +57,10 @@
  * node; whereby avoiding the need to carry a node from lock to unlock, and
  * preserving existing lock API. This also makes the unlock code simpler and
  * faster.
+ *
+ * N.B. The current implementation only supports architectures that allow
+ *      atomic operations on smaller 8-bit and 16-bit data types.
+ *
  */
 
 #include "mcs_spinlock.h"
@@ -96,6 +101,62 @@ static inline struct mcs_spinlock *decode_tail(u32 tail)
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
+/*
+ * By using the whole 2nd least significant byte for the pending bit, we
+ * can allow better optimization of the lock acquisition for the pending
+ * bit holder.
+ */
+#if _Q_PENDING_BITS == 8
+
+struct __qspinlock {
+	union {
+		atomic_t val;
+		struct {
+#ifdef __LITTLE_ENDIAN
+			u16	locked_pending;
+			u16	tail;
+#else
+			u16	tail;
+			u16	locked_pending;
+#endif
+		};
+	};
+};
+
+/**
+ * clear_pending_set_locked - take ownership and clear the pending bit.
+ * @lock: Pointer to queue spinlock structure
+ *
+ * *,1,0 -> *,0,1
+ *
+ * Lock stealing is not allowed if this function is used.
+ */
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+{
+	struct __qspinlock *l = (void *)lock;
+
+	WRITE_ONCE(l->locked_pending, _Q_LOCKED_VAL);
+}
+
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queue spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail)
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	struct __qspinlock *l = (void *)lock;
+
+	return (u32)xchg(&l->tail, tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else /* _Q_PENDING_BITS == 8 */
+
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queue spinlock structure
@@ -131,6 +192,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	}
 	return old;
 }
+#endif /* _Q_PENDING_BITS == 8 */
 
 /**
  * queue_spin_lock_slowpath - acquire the queue spinlock
@@ -205,8 +267,13 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * we're pending, wait for the owner to go away.
 	 *
 	 * *,1,1 -> *,1,0
+	 *
+	 * this wait loop must be a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because not all clear_pending_set_locked()
+	 * implementations imply full barriers.
 	 */
-	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_MASK)
+	while ((val = smp_load_acquire(&lock->val.counter)) & _Q_LOCKED_MASK)
 		cpu_relax();
 
 	/*
-- 
1.7.1
