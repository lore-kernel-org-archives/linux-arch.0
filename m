Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43060 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbCPNf4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 09:35:56 -0400
Message-ID: <20150316133111.959110943@infradead.org>
Date: Mon, 16 Mar 2015 14:16:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/9] qspinlock: Add pending bit
References: <20150316131613.720617163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peter_zijlstra-qspinlock-add_pending_bit.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150316131616.Hn3b-UZEUXLUHYIlgU-Jt2gL--wYpVWceHpGJ6T4Pt0@z>

From: Peter Zijlstra <peterz@infradead.org>

Because the qspinlock needs to touch a second cacheline (the per-cpu
mcs_nodes[]); add a pending bit and allow a single in-word spinner
before we punt to the second cacheline.

It is possible so observe the pending bit without the locked bit when
the last owner has just released but the pending owner has not yet
taken ownership.

In this case we would normally queue -- because the pending bit is
already taken. However, in this case the pending bit is guaranteed
to be released 'soon', therefore wait for it and avoid queueing.

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
Link: http://lkml.kernel.org/r/1421784755-21945-4-git-send-email-Waiman.Long@hp.com
---
 include/asm-generic/qspinlock_types.h |   12 ++-
 kernel/locking/qspinlock.c            |  119 ++++++++++++++++++++++++++++------
 2 files changed, 107 insertions(+), 24 deletions(-)

--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -36,8 +36,9 @@ typedef struct qspinlock {
  * Bitfields in the atomic value:
  *
  *  0- 7: locked byte
- *  8- 9: tail index
- * 10-31: tail cpu (+1)
+ *     8: pending
+ *  9-10: tail index
+ * 11-31: tail cpu (+1)
  */
 #define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
 				      << _Q_ ## type ## _OFFSET)
@@ -45,7 +46,11 @@ typedef struct qspinlock {
 #define _Q_LOCKED_BITS		8
 #define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
 
-#define _Q_TAIL_IDX_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#define _Q_PENDING_BITS		1
+#define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
+
+#define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
 #define _Q_TAIL_IDX_BITS	2
 #define _Q_TAIL_IDX_MASK	_Q_SET_MASK(TAIL_IDX)
 
@@ -54,5 +59,6 @@ typedef struct qspinlock {
 #define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
 
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
+#define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -94,24 +94,28 @@ static inline struct mcs_spinlock *decod
 	return per_cpu_ptr(&mcs_nodes[idx], cpu);
 }
 
+#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
+
 /**
  * queue_spin_lock_slowpath - acquire the queue spinlock
  * @lock: Pointer to queue spinlock structure
  * @val: Current value of the queue spinlock 32-bit word
  *
- * (queue tail, lock value)
- *
- *              fast      :    slow                                  :    unlock
- *                        :                                          :
- * uncontended  (0,0)   --:--> (0,1) --------------------------------:--> (*,0)
- *                        :       | ^--------.                    /  :
- *                        :       v           \                   |  :
- * uncontended            :    (n,x) --+--> (n,0)                 |  :
- *   queue                :       | ^--'                          |  :
- *                        :       v                               |  :
- * contended              :    (*,x) --+--> (*,0) -----> (*,1) ---'  :
- *   queue                :         ^--'                             :
+ * (queue tail, pending bit, lock value)
  *
+ *              fast     :    slow                                  :    unlock
+ *                       :                                          :
+ * uncontended  (0,0,0) -:--> (0,0,1) ------------------------------:--> (*,*,0)
+ *                       :       | ^--------.------.             /  :
+ *                       :       v           \      \            |  :
+ * pending               :    (0,1,1) +--> (0,1,0)   \           |  :
+ *                       :       | ^--'              |           |  :
+ *                       :       v                   |           |  :
+ * uncontended           :    (n,x,y) +--> (n,0,0) --'           |  :
+ *   queue               :       | ^--'                          |  :
+ *                       :       v                               |  :
+ * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
+ *   queue               :         ^--'                             :
  */
 void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
@@ -121,6 +125,75 @@ void queue_spin_lock_slowpath(struct qsp
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	/*
+	 * wait for in-progress pending->locked hand-overs
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	if (val == _Q_PENDING_VAL) {
+		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
+			cpu_relax();
+	}
+
+	/*
+	 * trylock || pending
+	 *
+	 * 0,0,0 -> 0,0,1 ; trylock
+	 * 0,0,1 -> 0,1,1 ; pending
+	 */
+	for (;;) {
+		/*
+		 * If we observe any contention; queue.
+		 */
+		if (val & ~_Q_LOCKED_MASK)
+			goto queue;
+
+		new = _Q_LOCKED_VAL;
+		if (val == new)
+			new |= _Q_PENDING_VAL;
+
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+
+	/*
+	 * we won the trylock
+	 */
+	if (new == _Q_LOCKED_VAL)
+		return;
+
+	/*
+	 * we're pending, wait for the owner to go away.
+	 *
+	 * *,1,1 -> *,1,0
+	 */
+	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_MASK)
+		cpu_relax();
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * *,1,0 -> *,0,1
+	 */
+	for (;;) {
+		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+	return;
+
+	/*
+	 * End of pending bit optimistic spinning and beginning of MCS
+	 * queuing.
+	 */
+queue:
 	node = this_cpu_ptr(&mcs_nodes[0]);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -130,15 +203,18 @@ void queue_spin_lock_slowpath(struct qsp
 	node->next = NULL;
 
 	/*
+	 * We have already touched the queueing cacheline; don't bother with
+	 * pending stuff.
+	 *
 	 * trylock || xchg(lock, node)
 	 *
-	 * 0,0 -> 0,1 ; no tail, not locked -> no tail, locked.
-	 * p,x -> n,x ; tail was p -> tail is n; preserving locked.
+	 * 0,0,0 -> 0,0,1 ; no tail, not locked -> no tail, locked.
+	 * p,y,x -> n,y,x ; tail was p -> tail is n; preserving locked.
 	 */
 	for (;;) {
 		new = _Q_LOCKED_VAL;
 		if (val)
-			new = tail | (val & _Q_LOCKED_MASK);
+			new = tail | (val & _Q_LOCKED_PENDING_MASK);
 
 		old = atomic_cmpxchg(&lock->val, val, new);
 		if (old == val)
@@ -157,7 +233,7 @@ void queue_spin_lock_slowpath(struct qsp
 	 * if there was a previous node; link it and wait until reaching the
 	 * head of the waitqueue.
 	 */
-	if (old & ~_Q_LOCKED_MASK) {
+	if (old & ~_Q_LOCKED_PENDING_MASK) {
 		prev = decode_tail(old);
 		WRITE_ONCE(prev->next, node);
 
@@ -165,18 +241,19 @@ void queue_spin_lock_slowpath(struct qsp
 	}
 
 	/*
-	 * we're at the head of the waitqueue, wait for the owner to go away.
+	 * we're at the head of the waitqueue, wait for the owner & pending to
+	 * go away.
 	 *
-	 * *,x -> *,0
+	 * *,x,y -> *,0,0
 	 */
-	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_MASK)
+	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_PENDING_MASK)
 		cpu_relax();
 
 	/*
 	 * claim the lock:
 	 *
-	 * n,0 -> 0,1 : lock, uncontended
-	 * *,0 -> *,1 : lock, contended
+	 * n,0,0 -> 0,0,1 : lock, uncontended
+	 * *,0,0 -> *,0,1 : lock, contended
 	 */
 	for (;;) {
 		new = _Q_LOCKED_VAL;


