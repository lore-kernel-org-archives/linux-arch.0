Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbfCAOEF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:04:05 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
Date: Fri,  1 Mar 2019 14:03:29 +0000
Message-ID: <20190301140348.25175-2-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140329.SfDqpNgIQij1MWRdlczTdI_fjM6oNPywoTozkpb_uNA@z>

In preparation for removing all explicit mmiowb() calls from driver
code, implement a tracking system in asm-generic based loosely on the
PowerPC implementation. This allows architectures with a non-empty
mmiowb() definition to have the barrier automatically inserted in
spin_unlock() following a critical section containing an I/O write.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/mmiowb.h       | 63 ++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mmiowb_types.h | 12 ++++++++
 kernel/Kconfig.locks               |  7 +++++
 kernel/locking/spinlock.c          |  7 +++++
 4 files changed, 89 insertions(+)
 create mode 100644 include/asm-generic/mmiowb.h
 create mode 100644 include/asm-generic/mmiowb_types.h

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
new file mode 100644
index 000000000000..9439ff037b2d
--- /dev/null
+++ b/include/asm-generic/mmiowb.h
@@ -0,0 +1,63 @@
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
+ * 	1. Implement mmiowb() (and arch_mmiowb_state() if you're fancy)
+ *	   in asm/mmiowb.h, then #include this file
+ *	2. Ensure your I/O write accessors call mmiowb_set_pending()
+ *	3. Select ARCH_HAS_MMIOWB
+ *	4. Untangle the resulting mess of header files
+ *	5. Complain to your architects
+ */
+#ifdef CONFIG_MMIOWB
+
+#include <linux/compiler.h>
+#include <asm-generic/mmiowb_types.h>
+
+#ifndef arch_mmiowb_state
+#include <asm/percpu.h>
+#include <asm/smp.h>
+
+DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
+#define __mmiowb_state()	this_cpu_ptr(&__mmiowb_state)
+#else
+#define __mmiowb_state()	arch_mmiowb_state()
+#endif	/* arch_mmiowb_state */
+
+static inline void mmiowb_set_pending(void)
+{
+	struct mmiowb_state *ms = __mmiowb_state();
+	ms->mmiowb_pending = ms->nesting_count;
+}
+
+static inline void mmiowb_spin_lock(void)
+{
+	struct mmiowb_state *ms = __mmiowb_state();
+	ms->nesting_count++;
+}
+
+static inline void mmiowb_spin_unlock(void)
+{
+	struct mmiowb_state *ms = __mmiowb_state();
+
+	if (unlikely(ms->mmiowb_pending)) {
+		ms->mmiowb_pending = 0;
+		mmiowb();
+	}
+
+	ms->nesting_count--;
+}
+#else
+#define mmiowb_set_pending()		do { } while (0)
+#define mmiowb_spin_lock()		do { } while (0)
+#define mmiowb_spin_unlock()		do { } while (0)
+#endif	/* CONFIG_MMIOWB */
+#endif	/* __ASM_GENERIC_MMIOWB_H */
diff --git a/include/asm-generic/mmiowb_types.h b/include/asm-generic/mmiowb_types.h
new file mode 100644
index 000000000000..8eb0095655e7
--- /dev/null
+++ b/include/asm-generic/mmiowb_types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_MMIOWB_TYPES_H
+#define __ASM_GENERIC_MMIOWB_TYPES_H
+
+#include <linux/types.h>
+
+struct mmiowb_state {
+	u16	nesting_count;
+	u16	mmiowb_pending;
+};
+
+#endif	/* __ASM_GENERIC_MMIOWB_TYPES_H */
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 84d882f3e299..82fa481ecb78 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -248,3 +248,10 @@ config ARCH_USE_QUEUED_RWLOCKS
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
 	depends on SMP
+
+config ARCH_HAS_MMIOWB
+	bool
+
+config MMIOWB
+	def_bool y if ARCH_HAS_MMIOWB
+	depends on SMP
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d14dd6b..0ff08380f531 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -22,6 +22,13 @@
 #include <linux/debug_locks.h>
 #include <linux/export.h>
 
+#ifdef CONFIG_MMIOWB
+#ifndef arch_mmiowb_state
+DEFINE_PER_CPU(struct mmiowb_state, __mmiowb_state);
+EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
+#endif
+#endif
+
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
-- 
2.11.0
