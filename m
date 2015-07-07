From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5/9] locking/qrwlock: remove redundant cmpxchg barriers on writer slow-path
Date: Tue,  7 Jul 2015 18:24:21 +0100
Message-ID: <1436289865-2331-6-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50327 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757756AbbGGRZI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:08 -0400
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

When transitioning from unlocked - locked (for write), we notify readers
of our presence by setting the _QW_WAITING flag using a cmpxchg.

Given that we use another cmpxchg to transition to the _QW_LOCKED state,
we can drop the barriers from the intermediate step by offering
architectures the chance to implement cmpxchg_relaxed, in a similar
manner to the cmpxchg64_relaxed macro in the lockref code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qrwlock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index a1b63df19a04..e3c51c4635d3 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -113,6 +113,10 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  * queued_write_lock_slowpath - acquire write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
+#ifndef cmpxchg_relaxed
+# define cmpxchg_relaxed	cmpxchg
+#endif
+
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
 	u32 cnts;
@@ -133,7 +137,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		struct __qrwlock *l = (struct __qrwlock *)lock;
 
 		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
+		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
 			break;
 
 		cpu_relax_lowlatency();
-- 
2.1.4
