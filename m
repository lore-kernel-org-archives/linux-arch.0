Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbfCAOEs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:04:48 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 13/20] riscv/mmiowb: Hook up mmwiob() implementation to asm-generic code
Date: Fri,  1 Mar 2019 14:03:41 +0000
Message-ID: <20190301140348.25175-14-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140341.gABMXIou53Onpl50F0RInMkuhOxEPmZvEDnW47MGC2c@z>

In a bid to kill off explicit mmiowb() usage in driver code, hook up
the asm-generic mmiowb() tracking code for riscv, so that an mmiowb()
is automatically issued from spin_unlock() if an I/O write was performed
in the critical section.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/Kbuild   |  1 -
 arch/riscv/include/asm/io.h     | 15 ++-------------
 arch/riscv/include/asm/mmiowb.h | 14 ++++++++++++++
 4 files changed, 17 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/mmiowb.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 515fc3cc9687..08f4415203c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_MMIOWB
 
 config MMU
 	def_bool y
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 221cd2ec78a4..cccd12cf27d4 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -21,7 +21,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += mutex.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1d9c1376dc64..744fd92e77bc 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -20,6 +20,7 @@
 #define _ASM_RISCV_IO_H
 
 #include <linux/types.h>
+#include <asm/mmiowb.h>
 
 extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 
@@ -100,18 +101,6 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * FIXME: I'm flip-flopping on whether or not we should keep this or enforce
- * the ordering with I/O on spinlocks like PowerPC does.  The worry is that
- * drivers won't get this correct, but I also don't want to introduce a fence
- * into the lock code that otherwise only uses AMOs (and is essentially defined
- * by the ISA to be correct).   For now I'm leaving this here: "o,w" is
- * sufficient to ensure that all writes to the device have completed before the
- * write to the spinlock is allowed to commit.  I surmised this from reading
- * "ACQUIRES VS I/O ACCESSES" in memory-barriers.txt.
- */
-#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
-
-/*
  * Unordered I/O memory access primitives.  These are even more relaxed than
  * the relaxed versions, as they don't even order accesses between successive
  * operations to the I/O regions.
@@ -165,7 +154,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define __io_br()	do {} while (0)
 #define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory");
 #define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory");
-#define __io_aw()	do {} while (0)
+#define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
 #define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
new file mode 100644
index 000000000000..5d7e3a2b4e3b
--- /dev/null
+++ b/arch/riscv/include/asm/mmiowb.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_MMIOWB_H
+#define _ASM_RISCV_MMIOWB_H
+
+/*
+ * "o,w" is sufficient to ensure that all writes to the device have completed
+ * before the write to the spinlock is allowed to commit.
+ */
+#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* ASM_RISCV_MMIOWB_H */
-- 
2.11.0
