From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Thu, 17 Apr 2014 11:03:57 -0400
Message-ID: <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
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
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

When we allow for a max NR_CPUS < 2^14 we can optimize the pending
wait-acquire and the xchg_tail() operations.

By growing the pending bit to a byte, we reduce the tail to 16bit.
This means we can use xchg16 for the tail part and do away with all
the repeated compxchg() operations.

This in turn allows us to unconditionally acquire; the locked state
as observed by the wait loops cannot change. And because both locked
and pending are now a full byte we can use simple stores for the
state transition, obviating one atomic operation entirely.

All this is horribly broken on Alpha pre EV56 (and any other arch that
cannot do single-copy atomic byte stores).

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 include/asm-generic/qspinlock_types.h |   13 ++++
 kernel/locking/qspinlock.c            |  111 ++++++++++++++++++++++++++++++---
 2 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index ed5d89a..4914abe 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -38,6 +38,14 @@ typedef struct qspinlock {
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
@@ -50,7 +58,11 @@ typedef struct qspinlock {
 #define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
 
 #define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#if CONFIG_NR_CPUS < (1U << 14)
+#define _Q_PENDING_BITS		8
+#else
 #define _Q_PENDING_BITS		1
+#endif
 #define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
 
 #define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
@@ -61,6 +73,7 @@ typedef struct qspinlock {
 #define _Q_TAIL_CPU_BITS	(32 - _Q_TAIL_CPU_OFFSET)
 #define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
 
+#define _Q_TAIL_OFFSET		_Q_TAIL_IDX_OFFSET
 #define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
 
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index fcf06cb..55601b4 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -22,8 +22,13 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/mutex.h>
+#include <asm/byteorder.h>
 #include <asm/qspinlock.h>
 
+#if !defined(__LITTLE_ENDIAN) && !defined(__BIG_ENDIAN)
+#error "Missing either LITTLE_ENDIAN or BIG_ENDIAN definition."
+#endif
+
 /*
  * The basic principle of a queue-based spinlock can best be understood
  * by studying a classic queue-based spinlock implementation called the
@@ -48,6 +53,9 @@
  * We can further change the first spinner to spin on a bit in the lock word
  * instead of its node; whereby avoiding the need to carry a node from lock to
  * unlock, and preserving API.
+ *
+ * N.B. The current implementation only supports architectures that allow
+ *      atomic operations on smaller 8-bit and 16-bit data types.
  */
 
 #include "mcs_spinlock.h"
@@ -85,6 +93,87 @@ static inline struct mcs_spinlock *decode_tail(u32 tail)
 
 #define _Q_LOCKED_PENDING_MASK	(_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
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
+ * @val : Current value of the queue spinlock 32-bit word
+ *
+ * *,1,0 -> *,0,1
+ */
+static __always_inline void
+clear_pending_set_locked(struct qspinlock *lock, u32 val)
+{
+	struct __qspinlock *l = (void *)lock;
+
+	ACCESS_ONCE(l->locked_pending) = 1;
+}
+
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queue spinlock structure
+ * @tail : The new queue tail code word
+ * @pval : Pointer to current value of the queue spinlock 32-bit word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail)
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32
+xchg_tail(struct qspinlock *lock, u32 tail, u32 *pval)
+{
+	struct __qspinlock *l = (void *)lock;
+
+	return (u32)xchg(&l->tail, tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else /* _Q_PENDING_BITS == 8 */
+
+/**
+ * clear_pending_set_locked - take ownership and clear the pending bit.
+ * @lock: Pointer to queue spinlock structure
+ * @val : Current value of the queue spinlock 32-bit word
+ *
+ * *,1,0 -> *,0,1
+ */
+static __always_inline void
+clear_pending_set_locked(struct qspinlock *lock, u32 val)
+{
+	u32 new, old;
+
+	for (;;) {
+		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+}
+
 /**
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
  * @lock : Pointer to queue spinlock structure
@@ -112,12 +201,17 @@ xchg_tail(struct qspinlock *lock, u32 tail, u32 *pval)
 	*pval = new;
 	return old;
 }
+#endif /* _Q_PENDING_BITS == 8 */
 
 /**
  * trylock_pending - try to acquire queue spinlock using the pending bit
  * @lock : Pointer to queue spinlock structure
  * @pval : Pointer to value of the queue spinlock 32-bit word
  * Return: 1 if lock acquired, 0 otherwise
+ *
+ * The pending bit won't be set as soon as one or more tasks queue up.
+ * This function should only be called when lock stealing will not happen.
+ * Otherwise, it has to be disabled.
  */
 static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
 {
@@ -157,8 +251,13 @@ static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
 	 * we're pending, wait for the owner to go away.
 	 *
 	 * *,1,1 -> *,1,0
+	 *
+	 * this wait loop must be a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this because not all try_clear_pending_set_locked()
+	 * implementations imply full barriers.
 	 */
-	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_MASK)
+	while ((val = smp_load_acquire(&lock->val.counter)) & _Q_LOCKED_MASK)
 		arch_mutex_cpu_relax();
 
 	/*
@@ -166,15 +265,7 @@ static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
 	 *
 	 * *,1,0 -> *,0,1
 	 */
-	for (;;) {
-		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
-
-		old = atomic_cmpxchg(&lock->val, val, new);
-		if (old == val)
-			break;
-
-		val = old;
-	}
+	clear_pending_set_locked(lock, val);
 	return 1;
 }
 
-- 
1.7.1
