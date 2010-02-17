From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/5] seqlock: Remove old style init
Date: Wed, 17 Feb 2010 18:47:42 -0000
Message-ID: <20100217184155.809849840@linutronix.de>
References: <20100217183740.486724334@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42307 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab0BQSsS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Feb 2010 13:48:18 -0500
Content-Disposition: inline; filename=seqlock-remove-oldstyle-init.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, John Stultz <johnstul@us.ibm.com>

Now that the last users of SEQLOCK_UNLOCKED are gone, remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/seqlock.h |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6-tip/include/linux/seqlock.h
===================================================================
--- linux-2.6-tip.orig/include/linux/seqlock.h
+++ linux-2.6-tip/include/linux/seqlock.h
@@ -41,9 +41,6 @@ typedef struct {
 #define __SEQLOCK_UNLOCKED(lockname) \
 		 { 0, __SPIN_LOCK_UNLOCKED(lockname) }
 
-#define SEQLOCK_UNLOCKED \
-		 __SEQLOCK_UNLOCKED(old_style_seqlock_init)
-
 #define seqlock_init(x)					\
 	do {						\
 		(x)->sequence = 0;			\
