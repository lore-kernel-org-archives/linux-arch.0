From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 10/20] mips: Add unconditional mmiowb() to arch_spin_unlock()
Date: Fri, 22 Feb 2019 18:50:16 +0000
Message-ID: <20190222185026.10973-11-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

The mmiowb() macro is horribly difficult to use and drivers will continue
to work most of the time if they omit a call when it is required.

Rather than rely on driver authors getting this right, push mmiowb() into
arch_spin_unlock() for mips. If this is deemed to be a performance issue,
a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
the barrier in cases where no I/O writes were performned inside the
critical section.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/mips/include/asm/Kbuild     |  1 -
 arch/mips/include/asm/io.h       |  3 ---
 arch/mips/include/asm/mmiowb.h   | 11 +++++++++++
 arch/mips/include/asm/spinlock.h | 15 +++++++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/include/asm/mmiowb.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 5653b1e47dd0..f15d5db5dd67 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 845fbbc7a2e3..29997e42480e 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -102,9 +102,6 @@ static inline void set_io_port_base(unsigned long base)
 #define iobarrier_w() wmb()
 #define iobarrier_sync() iob()
 
-/* Some callers use this older API instead.  */
-#define mmiowb() iobarrier_w()
-
 /*
  *     virt_to_phys    -       map virtual addresses to physical
  *     @address: address to remap
diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
new file mode 100644
index 000000000000..a40824e3ef8e
--- /dev/null
+++ b/arch/mips/include/asm/mmiowb.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_MMIOWB_H
+#define _ASM_MMIOWB_H
+
+#include <asm/io.h>
+
+#define mmiowb()	iobarrier_w()
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* _ASM_MMIOWB_H */
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index ee81297d9117..8a88eb265516 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -11,6 +11,21 @@
 
 #include <asm/processor.h>
 #include <asm/qrwlock.h>
+
+#include <asm-generic/qspinlock_types.h>
+
+#define	queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ */
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	/* This could be optimised with ARCH_HAS_MMIOWB */
+	mmiowb();
+	smp_store_release(&lock->locked, 0);
+}
+
 #include <asm/qspinlock.h>
 
 #endif /* _ASM_SPINLOCK_H */
-- 
2.11.0
