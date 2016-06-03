Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:40136 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176AbcFCIjB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2016 04:39:01 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Fri, 3 Jun 2016 02:39:00 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH] locking/qspinlock: Use atomic_sub_return_release in queued_spin_unlock
Date: Fri,  3 Jun 2016 16:38:14 +0800
Message-ID: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: arnd@arndb.de, peterz@infradead.org, waiman.long@hp.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Message-ID: <20160603083814.5fKpySxDg0KhI_HyqOD-MKwdIxeAO20o2xh3lgsVFf0@z>

The existing version uses a heavy barrier while only release semantics
is required. So use atomic_sub_return_release instead.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/asm-generic/qspinlock.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 35a52a8..8947cd2 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -92,10 +92,9 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 static __always_inline void queued_spin_unlock(struct qspinlock *lock)
 {
 	/*
-	 * smp_mb__before_atomic() in order to guarantee release semantics
-	 */
-	smp_mb__before_atomic();
-	atomic_sub(_Q_LOCKED_VAL, &lock->val);
+	* unlock() need release semantics
+	*/
+	(void)atomic_sub_return_release(_Q_LOCKED_VAL, &lock->val);
 }
 #endif
 
-- 
1.9.1

