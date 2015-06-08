From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH 2/2] locking/qrwlock: Don't contend with readers when setting _QW_WAITING
Date: Mon,  8 Jun 2015 18:20:44 -0400
Message-ID: <1433802045-21298-3-git-send-email-Waiman.Long@hp.com>
References: <1433802045-21298-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:38314 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbFHWVA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2015 18:21:00 -0400
In-Reply-To: <1433802045-21298-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

The current cmpxchg() loop in setting the _QW_WAITING flag for writers
in queue_write_lock_slowpath() will contend with incoming readers
causing possibly extra cmpxchg() operations that are wasteful. This
patch changes the code to do a byte cmpxchg() to eliminate contention
with new readers.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qrwlock.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index d7d7557..559198a 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -22,6 +22,26 @@
 #include <linux/hardirq.h>
 #include <asm/qrwlock.h>
 
+/*
+ * This internal data structure is used for optimizing access to some of
+ * the subfields within the atomic_t cnts.
+ */
+struct __qrwlock {
+	union {
+		atomic_t cnts;
+		struct {
+#ifdef __LITTLE_ENDIAN
+			u8 wmode;	/* Writer mode   */
+			u8 rcnts[3];	/* Reader counts */
+#else
+			u8 rcnts[3];	/* Reader counts */
+			u8 wmode;	/* Writer mode   */
+#endif
+		};
+	};
+	arch_spinlock_t	lock;
+};
+
 /**
  * rspin_until_writer_unlock - inc reader count & spin until writer is gone
  * @lock  : Pointer to queue rwlock structure
@@ -109,10 +129,10 @@ void queue_write_lock_slowpath(struct qrwlock *lock)
 	 * or wait for a previous writer to go away.
 	 */
 	for (;;) {
-		cnts = atomic_read(&lock->cnts);
-		if (!(cnts & _QW_WMASK) &&
-		    (atomic_cmpxchg(&lock->cnts, cnts,
-				    cnts | _QW_WAITING) == cnts))
+		struct __qrwlock *l = (struct __qrwlock *)lock;
+
+		if (!READ_ONCE(l->wmode) &&
+		   (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
 			break;
 
 		cpu_relax_lowlatency();
-- 
1.7.1
