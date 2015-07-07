From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 6/9] locking/qrwlock: allow architectures to hook in to contended paths
Date: Tue,  7 Jul 2015 18:24:22 +0100
Message-ID: <1436289865-2331-7-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50340 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932393AbbGGRZk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:40 -0400
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

When contended, architectures may be able to reduce the polling overhead
in ways which aren't expressible using a simple relax() primitive.

This patch allows architectures to override the use of
cpu_relax_lowlatency() in the qrwlock code and also implement their own
unlock macros in case explicit signalling is required to wake up a
`relaxed' CPU spinning on an unlock event.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qrwlock.h |  4 ++++
 kernel/locking/qrwlock.c      | 12 ++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index eb673dde8879..dbaac5f2af8f 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -125,6 +125,7 @@ static inline void queued_write_lock(struct qrwlock *lock)
  * queued_read_unlock - release read lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
+#ifndef queued_read_unlock
 static inline void queued_read_unlock(struct qrwlock *lock)
 {
 	/*
@@ -133,15 +134,18 @@ static inline void queued_read_unlock(struct qrwlock *lock)
 	smp_mb__before_atomic();
 	atomic_sub(_QR_BIAS, &lock->cnts);
 }
+#endif
 
 /**
  * queued_write_unlock - release write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
+#ifndef queued_write_unlock
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
 	smp_store_release((u8 *)&lock->cnts, 0);
 }
+#endif
 
 /*
  * Remapping rwlock architecture specific functions to the corresponding
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index e3c51c4635d3..45fbb48f83f6 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -23,6 +23,10 @@
 #include <linux/spinlock.h>
 #include <asm/qrwlock.h>
 
+#ifndef arch_qrwlock_relax
+# define arch_qrwlock_relax(lock)	cpu_relax_lowlatency()
+#endif
+
 /*
  * This internal data structure is used for optimizing access to some of
  * the subfields within the atomic_t cnts.
@@ -56,7 +60,7 @@ rspin_until_writer_unlock(struct qrwlock *lock)
 	u32 cnts = smp_load_acquire((u32 *)&lock->cnts);
 
 	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
-		cpu_relax_lowlatency();
+		arch_qrwlock_relax(lock);
 		cnts = smp_load_acquire((u32 *)&lock->cnts);
 	}
 }
@@ -97,7 +101,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	 * to make sure that the write lock isn't taken.
 	 */
 	while (atomic_read(&lock->cnts) & _QW_WMASK)
-		cpu_relax_lowlatency();
+		arch_qrwlock_relax(lock);
 
 	atomic_add(_QR_BIAS, &lock->cnts);
 	rspin_until_writer_unlock(lock);
@@ -140,7 +144,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
 			break;
 
-		cpu_relax_lowlatency();
+		arch_qrwlock_relax(lock);
 	}
 
 	/* When no more readers, set the locked flag */
@@ -151,7 +155,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 				    _QW_LOCKED) == _QW_WAITING))
 			break;
 
-		cpu_relax_lowlatency();
+		arch_qrwlock_relax(lock);
 	}
 unlock:
 	arch_spin_unlock(&lock->lock);
-- 
2.1.4
