From: Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 17/22] locking/rwsem: Recheck owner if it is not on cpu
Date: Thu,  7 Feb 2019 14:07:21 -0500
Message-ID: <1549566446-27967-18-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

After merging the owner value directly into the count field, it was
found that the number of failed optimistic spinning operations increased
significantly during the boot up process.

The cause of this increased failures was tracked down to the condition
that a lock holder might have just released the lock and gone to sleep
right after its owner value was fetched by a spinner. So the task might
have slept, but it was no longer the lock holder. The merging of owner
into count increases the chance this condition can happen.

To close this failure mode, we are now rechecking the owner value again
to see if it has been changed in case it is not on cpu.

On a 1-socket x86-64 system, the lock event counts before the patch
were:

  rwsem_opt_fail=5847
  rwsem_opt_wlock=7880
  rwsem_wlock=5847

After the patch, the counts were:

  rwsem_opt_fail=225
  rwsem_opt_wlock=8541
  rwsem_wlock=225

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 16dc7a1..21d462f 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -263,13 +263,25 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
 	}
 }
 
-static inline bool owner_on_cpu(struct task_struct *owner)
+static inline bool owner_on_cpu(struct task_struct *owner,
+				struct rw_semaphore *sem)
 {
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
 	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+	bool oncpu = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+
+	/*
+	 * There is a slight chance that the lock holder might have
+	 * just release the rwsem and gone to sleep right after we
+	 * fetched the owner value. So we double-check the sem->owner
+	 * field again to see if it has been changed. The sem->owner
+	 * would have been cleared right before the lock was released.
+	 */
+	if (!oncpu && (READ_ONCE(sem->owner) != owner))
+		return true;	/* Assume the new owner is on cpu */
+	return oncpu;
 }
 
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
@@ -286,7 +298,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
+		      owner_on_cpu(owner, sem);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -323,7 +335,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * abort spinning when need_resched or owner is not running or
 		 * owner's cpu is preempted.
 		 */
-		if (need_resched() || !owner_on_cpu(owner)) {
+		if (need_resched() || !owner_on_cpu(owner, sem)) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
1.8.3.1
