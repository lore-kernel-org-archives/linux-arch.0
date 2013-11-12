Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:20883 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab3KLOts (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2013 09:49:48 -0500
From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v6 5/5] qrwlock: Use smp_store_release() in write_unlock()
Date: Tue, 12 Nov 2013 09:48:55 -0500
Message-ID: <1384267735-43213-7-git-send-email-Waiman.Long@hp.com>
In-Reply-To: <1384267735-43213-1-git-send-email-Waiman.Long@hp.com>
References: <1384267735-43213-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Aswin Chandramouleeswaran\"" <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Waiman Long <Waiman.Long@hp.com>
Message-ID: <20131112144855.U4kO87wnY1eQgHR3e9LnBSoJBRjfvf0r6pD15SULHmU@z>

This patch modifies the queue_write_unlock() function to use the
new smp_store_release() function in another pending patch. This patch
should only be merged if the other patch was merged.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 include/asm-generic/qrwlock.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 288fb00..479c142 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -219,9 +219,7 @@ static inline void queue_write_unlock(struct qrwlock *lock)
 	/*
 	 * Make sure that none of the critical section will be leaked out.
 	 */
-	smp_mb__before_clear_bit();
-	ACCESS_ONCE(lock->cnts.writer) = 0;
-	smp_mb__after_clear_bit();
+	smp_store_release(&lock->cnts.writer, 0);
 }
 
 /*
-- 
1.7.1

