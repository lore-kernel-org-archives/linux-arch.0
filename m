From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v2 2/2] locking/qrwlock: Reduce writer to writer lock transfer latency
Date: Thu,  9 Jul 2015 12:32:23 -0400
Message-ID: <1436459543-29126-3-git-send-email-Waiman.Long@hp.com>
References: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>
List-Id: linux-arch.vger.kernel.org

In most cases, a writer acquires the lock in two steps - first setting
the writer mode byte to _QW_WAITING and then to _QW_LOCKED. So two
atomic operations are required. This 2-step dance is only needed if
readers are present. This patch modifies the logic so that a writer
will try to acquire the lock in a single step as long as possible
until it see some readers.

Using a locking microbenchmark, a 10-threads 5M locking loop of only
writers has the following performance numbers in a Haswell-EX box:

        Kernel          Locking Rate (Kops/s)
        ------          ---------------------
        4.1.1               11,939,648
        Patched 4.1.1       12,906,593

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qrwlock.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 6a7a3b8..9f64493 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -109,15 +109,22 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
-	u32 cnts;
-
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->lock);
 
 	/* Try to acquire the lock directly if no reader is present */
-	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg(&lock->cnts, 0, _QW_LOCKED) == 0))
-		goto unlock;
+	for (;;) {
+		u32 cnts = atomic_read(&lock->cnts);
+
+		if (!cnts) {
+			cnts = atomic_cmpxchg(&lock->cnts, 0, _QW_LOCKED);
+			if (cnts == 0)
+				goto unlock;
+		}
+		if (cnts & ~_QW_WMASK)
+			break;	/* Reader is present */
+		cpu_relax_lowlatency();
+	}
 
 	/*
 	 * Set the waiting flag to notify readers that a writer is pending,
@@ -135,8 +142,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 
 	/* When no more readers, set the locked flag */
 	for (;;) {
-		cnts = atomic_read(&lock->cnts);
-		if ((cnts == _QW_WAITING) &&
+		if ((atomic_read(&lock->cnts) == _QW_WAITING) &&
 		    (atomic_cmpxchg(&lock->cnts, _QW_WAITING,
 				    _QW_LOCKED) == _QW_WAITING))
 			break;
-- 
1.7.1
