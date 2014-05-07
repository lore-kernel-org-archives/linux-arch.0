From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v10 09/19] qspinlock: Prepare for unfair lock support
Date: Wed,  7 May 2014 11:01:37 -0400
Message-ID: <1399474907-22206-10-git-send-email-Waiman.Long@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

If unfair lock is supported, the lock acquisition loop at the end of
the queue_spin_lock_slowpath() function may need to detect the fact
the lock can be stolen. Code are added for the stolen lock detection.

A new qhead macro is also defined as a shorthand for mcs.locked.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index e98d7d4..9e7659e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -64,6 +64,7 @@
 struct qnode {
 	struct mcs_spinlock mcs;
 };
+#define qhead	mcs.locked	/* The queue head flag */
 
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
@@ -216,18 +217,20 @@ xchg_tail(struct qspinlock *lock, u32 tail, u32 *pval)
 
 /**
  * get_qlock - Set the lock bit and own the lock
- * @lock: Pointer to queue spinlock structure
+ * @lock : Pointer to queue spinlock structure
+ * Return: 1 if lock acquired, 0 otherwise
  *
  * This routine should only be called when the caller is the only one
  * entitled to acquire the lock.
  */
-static __always_inline void get_qlock(struct qspinlock *lock)
+static __always_inline int get_qlock(struct qspinlock *lock)
 {
 	struct __qspinlock *l = (void *)lock;
 
 	barrier();
 	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
 	barrier();
+	return 1;
 }
 
 /**
@@ -365,7 +368,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	tail = encode_tail(smp_processor_id(), idx);
 
 	node += idx;
-	node->mcs.locked = 0;
+	node->qhead = 0;
 	node->mcs.next = NULL;
 
 	/*
@@ -391,7 +394,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		prev = decode_tail(old);
 		ACCESS_ONCE(prev->mcs.next) = (struct mcs_spinlock *)node;
 
-		while (!smp_load_acquire(&node->mcs.locked))
+		while (!smp_load_acquire(&node->qhead))
 			arch_mutex_cpu_relax();
 	}
 
@@ -403,6 +406,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * *,x,y -> *,0,0
 	 */
+retry_queue_wait:
 	while ((val = smp_load_acquire(&lock->val.counter))
 				       & _Q_LOCKED_PENDING_MASK)
 		arch_mutex_cpu_relax();
@@ -419,12 +423,20 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	for (;;) {
 		if (val != tail) {
-			get_qlock(lock);
-			break;
+			/*
+			 * The get_qlock function will only failed if the
+			 * lock was stolen.
+			 */
+			if (get_qlock(lock))
+				break;
+			else
+				goto retry_queue_wait;
 		}
 		old = atomic_cmpxchg(&lock->val, val, _Q_LOCKED_VAL);
 		if (old == val)
 			goto release;	/* No contention */
+		else if (old & _Q_LOCKED_MASK)
+			goto retry_queue_wait;
 
 		val = old;
 	}
@@ -435,7 +447,7 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	while (!(next = (struct qnode *)ACCESS_ONCE(node->mcs.next)))
 		arch_mutex_cpu_relax();
 
-	arch_mcs_spin_unlock_contended(&next->mcs.locked);
+	arch_mcs_spin_unlock_contended(&next->qhead);
 
 release:
 	/*
-- 
1.7.1
