From: Kamal Mostafa <kamal@canonical.com>
Subject: [4.2.y-ckt stable] Patch "asm-generic/futex: Re-enable preemption in futex_atomic_cmpxchg_inatomic()" has been added to the 4.2.y-ckt tree
Date: Mon, 25 Apr 2016 12:44:46 -0700
Message-ID: <1461613486-28371-1-git-send-email-kamal@canonical.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43957 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408AbcDYTow (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2016 15:44:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Romain Perier <romain.perier@free-electrons.com>
Cc: linux-arch@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    asm-generic/futex: Re-enable preemption in futex_atomic_cmpxchg_inatomic()

to the linux-4.2.y-queue branch of the 4.2.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-4.2.y-queue

This patch is scheduled to be released in version 4.2.8-ckt9.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 4.2.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

---8<------------------------------------------------------------

From cdfad9ed4667dcd1c50611495db26b59ebab1dd5 Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@free-electrons.com>
Date: Thu, 14 Apr 2016 15:36:03 +0200
Subject: asm-generic/futex: Re-enable preemption in
 futex_atomic_cmpxchg_inatomic()

commit fba7cd681b6155e2d93e7862fcd6f970336b83c3 upstream.

The recent decoupling of pagefault disable and preempt disable added an
explicit preempt_disable/enable() pair to the futex_atomic_cmpxchg_inatomic()
implementation in asm-generic/futex.h. But it forgot to add preempt_enable()
calls to the error handling code pathes, which results in a preemption count
imbalance.

This is observable on boot when the test for atomic_cmpxchg() is calling
futex_atomic_cmpxchg_inatomic() on a NULL pointer.

Add the missing preempt_enable() calls to the error handling code pathes.

[ tglx: Massaged changelog ]

Fixes: d9b9ff8c1889 ("sched/preempt, futex: Disable preemption in UP futex_atomic_cmpxchg_inatomic() explicitly")
Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Cc: linux-arch@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1460640963-690-1-git-send-email-romain.perier@free-electrons.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 include/asm-generic/futex.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index e56272c..bf2d34c 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -108,11 +108,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	u32 val;

 	preempt_disable();
-	if (unlikely(get_user(val, uaddr) != 0))
+	if (unlikely(get_user(val, uaddr) != 0)) {
+		preempt_enable();
 		return -EFAULT;
+	}

-	if (val == oldval && unlikely(put_user(newval, uaddr) != 0))
+	if (val == oldval && unlikely(put_user(newval, uaddr) != 0)) {
+		preempt_enable();
 		return -EFAULT;
+	}

 	*uval = val;
 	preempt_enable();
--
2.7.4
