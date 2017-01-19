From: Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Remove unnecessary atomic_long_t casts
Date: Thu, 19 Jan 2017 09:31:52 -0500
Message-ID: <1484836312-6656-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Since sem->count had been changed to a atomic_long_t type, it is no
longer necessary to use the atomic_long_t cast anymore. So they are
removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/rwsem.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/rwsem.h b/include/asm-generic/rwsem.h
index 5be122e..6c6a214 100644
--- a/include/asm-generic/rwsem.h
+++ b/include/asm-generic/rwsem.h
@@ -33,7 +33,7 @@
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire((atomic_long_t *)&sem->count) <= 0))
+	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
 		rwsem_down_read_failed(sem);
 }
 
@@ -58,7 +58,7 @@ static inline void __down_write(struct rw_semaphore *sem)
 	long tmp;
 
 	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-				     (atomic_long_t *)&sem->count);
+					     &sem->count);
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		rwsem_down_write_failed(sem);
 }
@@ -68,7 +68,7 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 	long tmp;
 
 	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-				     (atomic_long_t *)&sem->count);
+					     &sem->count);
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
@@ -91,7 +91,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	tmp = atomic_long_dec_return_release((atomic_long_t *)&sem->count);
+	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
 		rwsem_wake(sem);
 }
@@ -102,7 +102,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 static inline void __up_write(struct rw_semaphore *sem)
 {
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
-				 (atomic_long_t *)&sem->count) < 0))
+						    &sem->count) < 0))
 		rwsem_wake(sem);
 }
 
@@ -120,8 +120,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS,
-				     (atomic_long_t *)&sem->count);
+	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
 	if (tmp < 0)
 		rwsem_downgrade_wake(sem);
 }
-- 
1.8.3.1
