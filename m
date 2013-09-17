From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/11] sched: Remove {set,clear}_need_resched
Date: Tue, 17 Sep 2013 11:10:49 +0200
Message-ID: <20130917091143.518797685@infradead.org>
References: <20130917082838.218329307@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:42994 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3IQJP2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 05:15:28 -0400
Content-Disposition: inline; filename=peterz-tif_need_resched.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>

Preemption semantics are going to change which mandate a change.

All DRM usage sites are already broken and will not be affected (much)
by this change. DRM people are aware and will remove the last few
stragglers.

For now, leave an empty stub that generates a warning, once all users
are gone we can remove this.

Cc: airlied@linux.ie
Cc: daniel.vetter@ffwll.ch
Cc: paulmck@linux.vnet.ibm.com
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/thread_info.h |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -104,8 +104,19 @@ static inline int test_ti_thread_flag(st
 #define test_thread_flag(flag) \
 	test_ti_thread_flag(current_thread_info(), flag)
 
-#define set_need_resched()	set_thread_flag(TIF_NEED_RESCHED)
-#define clear_need_resched()	clear_thread_flag(TIF_NEED_RESCHED)
+static inline __deprecated void set_need_resched(void)
+{
+	/*
+	 * Use of this function in deprecated.
+	 *
+	 * As of this writing there are only a few users in the DRM tree left
+	 * all of which are wrong and can be removed without causing too much
+	 * grief.
+	 *
+	 * The DRM people are aware and are working on removing the last few
+	 * instances.
+	 */
+}
 
 #if defined TIF_RESTORE_SIGMASK && !defined HAVE_SET_RESTORE_SIGMASK
 /*
