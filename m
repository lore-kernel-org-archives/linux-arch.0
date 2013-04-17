Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:29171 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab3DQE2l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Apr 2013 00:28:41 -0400
From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v3 optional 3/5] mutex: back out architecture specific check for negative mutex count
Date: Wed, 17 Apr 2013 00:28:09 -0400
Message-ID: <1366172891-7729-4-git-send-email-Waiman.Long@hp.com>
In-Reply-To: <1366172891-7729-1-git-send-email-Waiman.Long@hp.com>
References: <1366172891-7729-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hp.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>
Message-ID: <20130417042809.qS8EWNAyeyXP_LB0VPsLFfRFF3GthbO4lOZtAv-xV6o@z>

If it is confirmed that all the supported architectures can allow a
negative mutex count without incorrect behavior, we can then back
out the architecture specific change and allow the mutex count to
go to any negative number. That should further reduce contention for
non-x86 architecture.

If this is not the case, this patch should be dropped.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/mutex.h |   10 ----------
 kernel/mutex.c               |    9 ++-------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/mutex.h b/arch/x86/include/asm/mutex.h
index bc2a0b0..7d3a482 100644
--- a/arch/x86/include/asm/mutex.h
+++ b/arch/x86/include/asm/mutex.h
@@ -3,13 +3,3 @@
 #else
 # include <asm/mutex_64.h>
 #endif
-
-#ifndef	__ASM_MUTEX_H
-#define	__ASM_MUTEX_H
-/*
- * For the x86 architecture, it allows any negative number (besides -1) in
- * the mutex count to indicate that some other threads are waiting on the
- * mutex.
- */
-#define __ARCH_ALLOW_ANY_NEGATIVE_MUTEX_COUNT	1
-#endif
diff --git a/kernel/mutex.c b/kernel/mutex.c
index e6a90de..5600bdf 100644
--- a/kernel/mutex.c
+++ b/kernel/mutex.c
@@ -38,15 +38,10 @@
 #endif
 
 /*
- * A mutex count of -1 indicates that waiters are sleeping waiting for the
- * mutex. Some architectures can allow any negative number, not just -1, for
- * this purpose.
+ * A negative mutex count indicates that waiters are sleeping waiting for the
+ * mutex.
  */
-#ifdef __ARCH_ALLOW_ANY_NEGATIVE_MUTEX_COUNT
 #define	MUTEX_SHOW_NO_WAITER(mutex)	(atomic_read(&(mutex)->count) >= 0)
-#else
-#define	MUTEX_SHOW_NO_WAITER(mutex)	(atomic_read(&(mutex)->count) != -1)
-#endif
 
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
-- 
1.7.1

