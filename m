From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/9] qspinlock: Extract out code snippets for
	the next patch
Date: Mon, 16 Mar 2015 14:16:17 +0100
Message-ID: <20150316133112.027716523@infradead.org>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline;
	filename=waiman_long-qspinlock-extract_out_code_snippets_for_the_next_patch.patch
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Waiman.Long@hp.com
Cc: raghavendra.kt@linux.vnet.ibm.com, kvm@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, x86@kernel.org, mingo@redhat.com, doug.hatch@hp.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, scott.norton@hp.com, paolo.bonzini@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, oleg@redhat.com, luto@amacapital.net, david.vrabel@citrix.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

From: Waiman Long <Waiman.Long@hp.com>

This is a preparatory patch that extracts out the following 2 code
snippets to prepare for the next performance optimization patch.

 1) the logic for the exchange of new and previous tail code words
    into a new xchg_tail() function.
 2) the logic for clearing the pending bit and setting the locked bit
    into a new clear_pending_set_locked() function.

This patch also simplifies the trylock operation before queuing by
calling queue_spin_trylock() directly.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Scott J Norton <scott.norton@hp.com>
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>
Cc: Douglas Hatch <doug.hatch@hp.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1421784755-21945-5-git-send-email-Waiman.Long@hp.com
---
 include/asm-generic/qspinlock_types.h |    2 
 kernel/locking/qspinlock.c            |   91 ++++++++++++++++++++++------------
 2 files changed, 62 insertions(+), 31 deletions(-)

--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -58,6 +58,8 @@ typedef struct qspinlock {
 #define _Q_TAIL_CPU_BITS	(32 - _Q_TAIL_CPU_OFFSET)
 #define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
 
+#define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
+
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -97,6 +97,54 @@ static inline struct mcs_spinlock *decod
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
 /**
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
+/**
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
+	u32 old, new, val = atomic_read(&lock->val);
+
+	for (;;) {
+		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+	return old;
+}
+
+/**
  * queue_spin_lock_slowpath - acquire the queue spinlock
  * @lock: Pointer to queue spinlock structure
  * @val: Current value of the queue spinlock 32-bit word
@@ -178,15 +226,7 @@ void queue_spin_lock_slowpath(struct qsp
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
 	return;
 
 	/*
@@ -203,37 +243,26 @@ void queue_spin_lock_slowpath(struct qsp
 	node->next = NULL;
 
 	/*
-	 * We have already touched the queueing cacheline; don't bother with
-	 * pending stuff.
-	 *
-	 * trylock || xchg(lock, node)
-	 *
-	 * 0,0,0 -> 0,0,1 ; no tail, not locked -> no tail, locked.
-	 * p,y,x -> n,y,x ; tail was p -> tail is n; preserving locked.
+	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
+	 * attempt the trylock once more in the hope someone let go while we
+	 * weren't watching.
 	 */
-	for (;;) {
-		new = _Q_LOCKED_VAL;
-		if (val)
-			new = tail | (val & _Q_LOCKED_PENDING_MASK);
-
-		old = atomic_cmpxchg(&lock->val, val, new);
-		if (old == val)
-			break;
-
-		val = old;
-	}
+	if (queue_spin_trylock(lock))
+		goto release;
 
 	/*
-	 * we won the trylock; forget about queueing.
+	 * We have already touched the queueing cacheline; don't bother with
+	 * pending stuff.
+	 *
+	 * p,*,* -> n,*,*
 	 */
-	if (new == _Q_LOCKED_VAL)
-		goto release;
+	old = xchg_tail(lock, tail);
 
 	/*
 	 * if there was a previous node; link it and wait until reaching the
 	 * head of the waitqueue.
 	 */
-	if (old & ~_Q_LOCKED_PENDING_MASK) {
+	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
 		WRITE_ONCE(prev->next, node);
