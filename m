From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 0/5] MCS Lock: MCS lock code cleanup and optimizations
Date: Wed, 20 Nov 2013 17:00:17 +0000
Message-ID: <20131120170017.GI19352@mudshark.cambridge.arm.com>
References: <cover.1384885312.git.tim.c.chen@linux.intel.com>
 <1384911446.11046.450.camel@schen9-DESK>
 <20131120101957.GA19352@mudshark.cambridge.arm.com>
 <20131120125023.GC4138@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131120125023.GC4138@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@hori>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 20, 2013 at 12:50:23PM +0000, Paul E. McKenney wrote:
> On Wed, Nov 20, 2013 at 10:19:57AM +0000, Will Deacon wrote:
> > On Wed, Nov 20, 2013 at 01:37:26AM +0000, Tim Chen wrote:
> > > Will, do you want to take a crack at adding implementation for ARM
> > > with wfe instruction?
> > 
> > Sure, I'll have a go this week. Thanks for keeping that as a consideration!
> > 
> > As an aside: what are you using to test this code, so that I can make sure I
> > don't break it?
> 
> +1 to that!  In fact, it would be nice to have the test code in-tree,
> especially if it can test a wide variety of locks.  (/me needs to look
> at what test code for locks might already be in tree, for that matter...)

Well, in the absence of those tests, I've implemented something that I think
will work for ARM and could be easily extended to arm64.

Tim: I reverted your final patch and went with Paul's suggestion just to
look into the contended case. I'm also not sure about adding
asm/mcs_spinlock.h. This stuff might be better in asm/spinlock.h, which
already exists and contains both spinlocks and rwlocks. Depends on how much
people dislike the Kconfig symbol + conditional #include.

Anyway, patches below. I included the ARM bits for reference, but please
don't include them in your series!

Cheers,

Will

--->8

From 074f4cdf9ddc97454467b9ad9f85128ee67c5604 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 20 Nov 2013 16:14:04 +0000
Subject: [PATCH 1/3] MCS Lock: allow architectures to hook in to contended
 paths

When contended, architectures may be able to reduce the polling overhead
in ways which aren't expressible using a simple relax() primitive.

This patch allows architectures to hook into the mcs_{lock,unlock}
functions for the contended cases only.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/mcs_spinlock.c | 47 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.c b/kernel/locking/mcs_spinlock.c
index 6f2ce8efb006..853070b8a86d 100644
--- a/kernel/locking/mcs_spinlock.c
+++ b/kernel/locking/mcs_spinlock.c
@@ -7,19 +7,34 @@
  * It avoids expensive cache bouncings that common test-and-set spin-lock
  * implementations incur.
  */
-/*
- * asm/processor.h may define arch_mutex_cpu_relax().
- * If it is not defined, cpu_relax() will be used.
- */
+
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
 #include <asm/processor.h>
 #include <linux/compiler.h>
 #include <linux/mcs_spinlock.h>
+#include <linux/mutex.h>
 #include <linux/export.h>
 
-#ifndef arch_mutex_cpu_relax
-# define arch_mutex_cpu_relax() cpu_relax()
+#ifndef arch_mcs_spin_lock_contended
+/*
+ * Using smp_load_acquire() provides a memory barrier that ensures
+ * subsequent operations happen after the lock is acquired.
+ */
+#define arch_mcs_spin_lock_contended(l)					\
+	while (!(smp_load_acquire(l))) {				\
+		arch_mutex_cpu_relax();					\
+	}
+#endif
+
+#ifndef arch_mcs_spin_unlock_contended
+/*
+ * smp_store_release() provides a memory barrier to ensure all
+ * operations in the critical section has been completed before
+ * unlocking.
+ */
+#define arch_mcs_spin_unlock_contended(l)				\
+	smp_store_release((l), 1)
 #endif
 
 /*
@@ -44,13 +59,9 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 		return;
 	}
 	ACCESS_ONCE(prev->next) = node;
-	/*
-	 * Wait until the lock holder passes the lock down.
-	 * Using smp_load_acquire() provides a memory barrier that
-	 * ensures subsequent operations happen after the lock is acquired.
-	 */
-	while (!(smp_load_acquire(&node->locked)))
-		arch_mutex_cpu_relax();
+
+	/* Wait until the lock holder passes the lock down. */
+	arch_mcs_spin_lock_contended(&node->locked);
 }
 EXPORT_SYMBOL_GPL(mcs_spin_lock);
 
@@ -72,12 +83,8 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 		while (!(next = ACCESS_ONCE(node->next)))
 			arch_mutex_cpu_relax();
 	}
-	/*
-	 * Pass lock to next waiter.
-	 * smp_store_release() provides a memory barrier to ensure
-	 * all operations in the critical section has been completed
-	 * before unlocking.
-	 */
-	smp_store_release(&next->locked, 1);
+
+	/* Pass lock to next waiter. */
+	arch_mcs_spin_unlock_contended(&next->locked);
 }
 EXPORT_SYMBOL_GPL(mcs_spin_unlock);
-- 
1.8.2.2


From faa48f77a17cfd99562b1e36de278367aa4d389c Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 20 Nov 2013 16:10:57 +0000
Subject: [PATCH 2/3] MCS Lock: add Kconfig entries to allow arch-specific
 hooks

This patch adds Kconfig entries to allow architectures to hook into the
MCS lock/unlock functions in the contended case.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/Kconfig                 | 3 +++
 include/linux/mcs_spinlock.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index f1cf895c040f..ae738f706325 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -303,6 +303,9 @@ config HAVE_CMPXCHG_LOCAL
 config HAVE_CMPXCHG_DOUBLE
 	bool
 
+config HAVE_ARCH_MCS_LOCK
+	bool
+
 config ARCH_WANT_IPC_PARSE_VERSION
 	bool
 
diff --git a/include/linux/mcs_spinlock.h b/include/linux/mcs_spinlock.h
index d54bb232a238..d2c02adb0bbd 100644
--- a/include/linux/mcs_spinlock.h
+++ b/include/linux/mcs_spinlock.h
@@ -12,6 +12,14 @@
 #ifndef __LINUX_MCS_SPINLOCK_H
 #define __LINUX_MCS_SPINLOCK_H
 
+/*
+ * An architecture may provide its own lock/unlock functions for the
+ * contended case.
+ */
+#ifdef CONFIG_HAVE_ARCH_MCS_LOCK
+#include <asm/mcs_spinlock.h>
+#endif
+
 struct mcs_spinlock {
 	struct mcs_spinlock *next;
 	int locked; /* 1 if lock acquired */
-- 
1.8.2.2


From 21f047d40002ec4f1b780eee88f16a1870ab00ef Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 20 Nov 2013 16:15:31 +0000
Subject: [PATCH 3/3] ARM: mcs lock: implement wfe-based polling for MCS
 locking

This patch introduces a wfe-based polling loop for spinning on contended
MCS locks and waking up corresponding waiters when the lock is released.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                    |  1 +
 arch/arm/include/asm/mcs_spinlock.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm/include/asm/mcs_spinlock.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 214b698cefea..ab9fb84599ac 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -25,6 +25,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_MCS_LOCK
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
new file mode 100644
index 000000000000..f32f97e81471
--- /dev/null
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_MCS_LOCK_H
+#define __ASM_MCS_LOCK_H
+
+/* MCS spin-locking. */
+#define arch_mcs_spin_lock_contended(lock)				\
+do {									\
+	/* Ensure prior stores are observed before we enter wfe. */	\
+	smp_mb();							\
+	while (!(smp_load_acquire(lock)))				\
+		wfe();							\
+} while (0)								\
+
+#define arch_mcs_spin_unlock_contended(lock)				\
+do {									\
+	smp_store_release(lock, 1);					\
+	dsb(ishst);							\
+	sev();								\
+} while (0)
+
+#endif	/* __ASM_MCS_LOCK_H */
-- 
1.8.2.2

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
