From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v6 tip/core/locking 5/8] locking: Add an smp_mb__after_unlock_lock() for UNLOCK+LOCK barrier
Date: Wed, 11 Dec 2013 13:59:08 -0800
Message-ID: <1386799151-2219-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20131211215850.GA810@linux.vnet.ibm.com>
 <1386799151-2219-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386799151-2219-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, darren@dvhart.com, fweisbec@gmail.com, oleg@redhat.com, sbw@mit.edu, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

The Linux kernel has traditionally required that an UNLOCK+LOCK pair
act as a full memory barrier when either (1) that UNLOCK+LOCK pair
was executed by the same CPU or task, or (2) the same lock variable
was used for the UNLOCK and LOCK.  It now seems likely that very few
places in the kernel rely on this full-memory-barrier semantic, and
with the advent of queued locks, providing this semantic either requires
complex reasoning, or for some architectures, added overhead.

This commit therefore adds a smp_mb__after_unlock_lock(), which may be
placed after a LOCK primitive to restore the full-memory-barrier semantic.
All definitions are currently no-ops, but will be upgraded for some
architectures when queued locks arrive.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/spinlock.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 75f34949d9ab..3f2867ff0ced 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -130,6 +130,16 @@ do {								\
 #define smp_mb__before_spinlock()	smp_wmb()
 #endif
 
+/*
+ * Place this after a lock-acquisition primitive to guarantee that
+ * an UNLOCK+LOCK pair act as a full barrier.  This guarantee applies
+ * if the UNLOCK and LOCK are executed by the same CPU or if the
+ * UNLOCK and LOCK operate on the same lock variable.
+ */
+#ifndef smp_mb__after_unlock_lock
+#define smp_mb__after_unlock_lock()	do { } while (0)
+#endif
+
 /**
  * raw_spin_unlock_wait - wait until the spinlock gets unlocked
  * @lock: the spinlock in question.
-- 
1.8.1.5
