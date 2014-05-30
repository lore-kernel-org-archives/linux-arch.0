From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v11 08/16] qspinlock: Prepare for unfair lock support
Date: Fri, 30 May 2014 11:43:54 -0400
Message-ID: <1401464642-33890-9-git-send-email-Waiman.Long@hp.com>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
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

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2c7abe7..ae1b19d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -94,7 +94,7 @@ static inline struct mcs_spinlock *decode_tail(u32 tail)
  * can allow better optimization of the lock acquisition for the pending
  * bit holder.
  *
- * This internal structure is also used by the set_locked function which
+ * This internal structure is also used by the try_set_locked function which
  * is not restricted to _Q_PENDING_BITS == 8.
  */
 struct __qspinlock {
@@ -206,19 +206,21 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 #endif /* _Q_PENDING_BITS == 8 */
 
 /**
- * set_locked - Set the lock bit and own the lock
- * @lock: Pointer to queue spinlock structure
+ * try_set_locked - Try to set the lock bit and own the lock
+ * @lock : Pointer to queue spinlock structure
+ * Return: 1 if lock acquired, 0 otherwise
  *
  * This routine should only be called when the caller is the only one
  * entitled to acquire the lock.
  */
-static __always_inline void set_locked(struct qspinlock *lock)
+static __always_inline int try_set_locked(struct qspinlock *lock)
 {
 	struct __qspinlock *l = (void *)lock;
 
 	barrier();
 	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
 	barrier();
+	return 1;
 }
 
 /**
@@ -357,11 +359,12 @@ queue:
 	/*
 	 * we're at the head of the waitqueue, wait for the owner & pending to
 	 * go away.
-	 * Load-acquired is used here because the set_locked()
+	 * Load-acquired is used here because the try_set_locked()
 	 * function below may not be a full memory barrier.
 	 *
 	 * *,x,y -> *,0,0
 	 */
+retry_queue_wait:
 	while ((val = smp_load_acquire(&lock->val.counter))
 				       & _Q_LOCKED_PENDING_MASK)
 		arch_mutex_cpu_relax();
@@ -378,13 +381,20 @@ queue:
 	 */
 	for (;;) {
 		if (val != tail) {
-			set_locked(lock);
-			break;
+			/*
+			 * The try_set_locked function will only failed if the
+			 * lock was stolen.
+			 */
+			if (try_set_locked(lock))
+				break;
+			else
+				goto  retry_queue_wait;
 		}
 		old = atomic_cmpxchg(&lock->val, val, _Q_LOCKED_VAL);
 		if (old == val)
 			goto release;	/* No contention */
-
+		else if (old &  _Q_LOCKED_MASK)
+			goto retry_queue_wait;
 		val = old;
 	}
 
-- 
1.7.1
