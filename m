Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSui (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:50:38 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
Date: Fri, 22 Feb 2019 18:50:07 +0000
Message-ID: <20190222185026.10973-2-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185007.q-tGAltisH5ZFcmfnKopmj3wNZnGqPwAxteHfPwRGAo@z>

In preparation for removing all explicit mmiowb() calls from driver
code, implement a tracking system in asm-generic based on the PowerPC
implementation. This allows architectures with a non-empty mmiowb()
definition to automatically have the barrier inserted in spin_unlock()
following a critical section containing an I/O write.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/mmiowb.h | 60 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.locks         |  3 +++
 kernel/locking/spinlock.c    |  5 ++++
 3 files changed, 68 insertions(+)
 create mode 100644 include/asm-generic/mmiowb.h

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
new file mode 100644
index 000000000000..1cec8907806f
--- /dev/null
+++ b/include/asm-generic/mmiowb.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_MMIOWB_H
+#define __ASM_GENERIC_MMIOWB_H
+
+/*
+ * Generic implementation of mmiowb() tracking for spinlocks.
+ *
+ * If your architecture doesn't ensure that writes to an I/O peripheral
+ * within two spinlocked sections on two different CPUs are seen by the
+ * peripheral in the order corresponding to the lock handover, then you
+ * need to follow these FIVE easy steps:
+ *
+ * 	1. Implement mmiowb() in asm/mmiowb.h and then #include this file
+ *	2. Ensure your I/O write accessors call mmiowb_set_pending()
+ *	3. Select ARCH_HAS_MMIOWB
+ *	4. Untangle the resulting mess of header files
+ *	5. Complain to your architects
+ */
+#if defined(CONFIG_ARCH_HAS_MMIOWB) && defined(CONFIG_SMP)
+
+#include <linux/types.h>
+#include <asm/percpu.h>
+#include <asm/smp.h>
+
+struct mmiowb_state {
+	u16	nesting_count;
+	u16	mmiowb_pending;
+};
+DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
+
+#ifndef mmiowb_set_pending
+static inline void mmiowb_set_pending(void)
+{
+	__this_cpu_write(__mmiowb_state.mmiowb_pending, 1);
+}
+#endif
+
+#ifndef mmiowb_spin_lock
+static inline void mmiowb_spin_lock(void)
+{
+	if (__this_cpu_inc_return(__mmiowb_state.nesting_count) == 1)
+		__this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
+}
+#endif
+
+#ifndef mmiowb_spin_unlock
+static inline void mmiowb_spin_unlock(void)
+{
+	if (__this_cpu_xchg(__mmiowb_state.mmiowb_pending, 0))
+		mmiowb();
+	__this_cpu_dec_return(__mmiowb_state.nesting_count);
+}
+#endif
+
+#else
+#define mmiowb_set_pending()		do { } while (0)
+#define mmiowb_spin_lock()		do { } while (0)
+#define mmiowb_spin_unlock()		do { } while (0)
+#endif	/* CONFIG_ARCH_HAS_MMIOWB && CONFIG_SMP */
+#endif	/* __ASM_GENERIC_MMIOWB_H */
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 84d882f3e299..04976ae41176 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -248,3 +248,6 @@ config ARCH_USE_QUEUED_RWLOCKS
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
 	depends on SMP
+
+config ARCH_HAS_MMIOWB
+	bool
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d14dd6b..cbae365d7dd1 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -22,6 +22,11 @@
 #include <linux/debug_locks.h>
 #include <linux/export.h>
 
+#ifdef CONFIG_ARCH_HAS_MMIOWB
+DEFINE_PER_CPU(struct mmiowb_state, __mmiowb_state);
+EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
+#endif
+
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
-- 
2.11.0
