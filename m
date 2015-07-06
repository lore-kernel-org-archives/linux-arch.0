From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock transfer latency
Date: Mon,  6 Jul 2015 11:43:04 -0400
Message-ID: <1436197386-58635-3-git-send-email-Waiman.Long@hp.com>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:58409 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbGFPnY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2015 11:43:24 -0400
In-Reply-To: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

Currently, a reader will check first to make sure that the writer mode
byte is cleared before incrementing the reader count. That waiting is
not really necessary. It increases the latency in the reader/writer
to reader transition and reduces readers performance.

This patch eliminates that waiting. It also has the side effect
of reducing the chance of writer lock stealing and improving the
fairness of the lock. Using a locking microbenchmark, a 10-threads 5M
locking loop of mostly readers (RW ratio = 10,000:1) has the following
performance numbers in a Haswell-EX box:

        Kernel          Locking Rate (Kops/s)
        ------          ---------------------
        4.1.1               15,063,081
        Patched 4.1.1       17,241,552

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qrwlock.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 81bae99..ecd2d19 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -88,15 +88,11 @@ void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	arch_spin_lock(&lock->lock);
 
 	/*
-	 * At the head of the wait queue now, wait until the writer state
-	 * goes to 0 and then try to increment the reader count and get
-	 * the lock. It is possible that an incoming writer may steal the
-	 * lock in the interim, so it is necessary to check the writer byte
-	 * to make sure that the write lock isn't taken.
+	 * At the head of the wait queue now, increment the reader count
+	 * and wait until the writer, if it has the lock, has gone away.
+	 * At ths stage, it is not possible for a writer to remain in the
+	 * waiting state (_QW_WAITING). So there won't be any deadlock.
 	 */
-	while (atomic_read(&lock->cnts) & _QW_WMASK)
-		cpu_relax_lowlatency();
-
 	cnts = atomic_add_return(_QR_BIAS, &lock->cnts) - _QR_BIAS;
 	rspin_until_writer_unlock(lock, cnts);
 
-- 
1.7.1
