Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:14 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 11/20] ia64: Add unconditional mmiowb() to arch_spin_unlock()
Date: Fri, 22 Feb 2019 18:50:17 +0000
Message-ID: <20190222185026.10973-12-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185017.Z2HRY4_fM4aaYdAE7tXRo-xSkM6qQRvapQ4r2_4BFas@z>

The mmiowb() macro is horribly difficult to use and drivers will continue
to work most of the time if they omit a call when it is required.

Rather than rely on driver authors getting this right, push mmiowb() into
arch_spin_unlock() for ia64. If this is deemed to be a performance issue,
a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
the barrier in cases where no I/O writes were performned inside the
critical section.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/ia64/include/asm/Kbuild     |  1 -
 arch/ia64/include/asm/io.h       |  4 ----
 arch/ia64/include/asm/mmiowb.h   | 12 ++++++++++++
 arch/ia64/include/asm/spinlock.h |  2 ++
 4 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 arch/ia64/include/asm/mmiowb.h

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 3273d7aedfa0..43e21fe3499c 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 1e6fef69bb01..7f2371ba04a4 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -119,8 +119,6 @@ extern int valid_mmap_phys_addr_range (unsigned long pfn, size_t count);
  * Ensure ordering of I/O space writes.  This will make sure that writes
  * following the barrier will arrive after all previous writes.  For most
  * ia64 platforms, this is a simple 'mf.a' instruction.
- *
- * See Documentation/driver-api/device-io.rst for more information.
  */
 static inline void ___ia64_mmiowb(void)
 {
@@ -296,7 +294,6 @@ __outsl (unsigned long port, const void *src, unsigned long count)
 #define __outb		platform_outb
 #define __outw		platform_outw
 #define __outl		platform_outl
-#define __mmiowb	platform_mmiowb
 
 #define inb(p)		__inb(p)
 #define inw(p)		__inw(p)
@@ -310,7 +307,6 @@ __outsl (unsigned long port, const void *src, unsigned long count)
 #define outsb(p,s,c)	__outsb(p,s,c)
 #define outsw(p,s,c)	__outsw(p,s,c)
 #define outsl(p,s,c)	__outsl(p,s,c)
-#define mmiowb()	__mmiowb()
 
 /*
  * The address passed to these functions are ioremap()ped already.
diff --git a/arch/ia64/include/asm/mmiowb.h b/arch/ia64/include/asm/mmiowb.h
new file mode 100644
index 000000000000..238d56172c6f
--- /dev/null
+++ b/arch/ia64/include/asm/mmiowb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_IA64_MMIOWB_H
+#define _ASM_IA64_MMIOWB_H
+
+#include <asm/machvec.h>
+
+#define mmiowb()	platform_mmiowb()
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* _ASM_IA64_MMIOWB_H */
diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index afd0b3121b4c..5f620e66384e 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -73,6 +73,8 @@ static __always_inline void __ticket_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned short	*p = (unsigned short *)&lock->lock + 1, tmp;
 
+	/* This could be optimised with ARCH_HAS_MMIOWB */
+	mmiowb();
 	asm volatile ("ld2.bias %0=[%1]" : "=r"(tmp) : "r"(p));
 	WRITE_ONCE(*p, (tmp + 2) & ~1);
 }
-- 
2.11.0
