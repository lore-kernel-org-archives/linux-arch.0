Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbfDEOAf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 10:00:35 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 12/21] ia64/mmiowb: Add unconditional mmiowb() to arch_spin_unlock()
Date: Fri,  5 Apr 2019 14:59:27 +0100
Message-ID: <20190405135936.7266-13-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405135927.1MCjj5zwccAX-i48g926hpjjk12bvvGwU9whzAXUmdk@z>

The mmiowb() macro is horribly difficult to use and drivers will continue
to work most of the time if they omit a call when it is required.

Rather than rely on driver authors getting this right, push mmiowb() into
arch_spin_unlock() for ia64. If this is deemed to be a performance issue,
a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
the barrier in cases where no I/O writes were performed inside the
critical section.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/ia64/include/asm/Kbuild     |  1 -
 arch/ia64/include/asm/io.h       | 17 -----------------
 arch/ia64/include/asm/mmiowb.h   | 25 +++++++++++++++++++++++++
 arch/ia64/include/asm/spinlock.h |  2 ++
 4 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 arch/ia64/include/asm/mmiowb.h

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index cabfe0280c33..11f191689c9e 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -5,7 +5,6 @@ generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 1e6fef69bb01..a511d62d447a 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -113,20 +113,6 @@ extern int valid_mmap_phys_addr_range (unsigned long pfn, size_t count);
  */
 #define __ia64_mf_a()	ia64_mfa()
 
-/**
- * ___ia64_mmiowb - I/O write barrier
- *
- * Ensure ordering of I/O space writes.  This will make sure that writes
- * following the barrier will arrive after all previous writes.  For most
- * ia64 platforms, this is a simple 'mf.a' instruction.
- *
- * See Documentation/driver-api/device-io.rst for more information.
- */
-static inline void ___ia64_mmiowb(void)
-{
-	ia64_mfa();
-}
-
 static inline void*
 __ia64_mk_io_addr (unsigned long port)
 {
@@ -161,7 +147,6 @@ __ia64_mk_io_addr (unsigned long port)
 #define __ia64_writew	___ia64_writew
 #define __ia64_writel	___ia64_writel
 #define __ia64_writeq	___ia64_writeq
-#define __ia64_mmiowb	___ia64_mmiowb
 
 /*
  * For the in/out routines, we need to do "mf.a" _after_ doing the I/O access to ensure
@@ -296,7 +281,6 @@ __outsl (unsigned long port, const void *src, unsigned long count)
 #define __outb		platform_outb
 #define __outw		platform_outw
 #define __outl		platform_outl
-#define __mmiowb	platform_mmiowb
 
 #define inb(p)		__inb(p)
 #define inw(p)		__inw(p)
@@ -310,7 +294,6 @@ __outsl (unsigned long port, const void *src, unsigned long count)
 #define outsb(p,s,c)	__outsb(p,s,c)
 #define outsw(p,s,c)	__outsw(p,s,c)
 #define outsl(p,s,c)	__outsl(p,s,c)
-#define mmiowb()	__mmiowb()
 
 /*
  * The address passed to these functions are ioremap()ped already.
diff --git a/arch/ia64/include/asm/mmiowb.h b/arch/ia64/include/asm/mmiowb.h
new file mode 100644
index 000000000000..297b85ac84a0
--- /dev/null
+++ b/arch/ia64/include/asm/mmiowb.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_IA64_MMIOWB_H
+#define _ASM_IA64_MMIOWB_H
+
+#include <asm/machvec.h>
+
+/**
+ * ___ia64_mmiowb - I/O write barrier
+ *
+ * Ensure ordering of I/O space writes.  This will make sure that writes
+ * following the barrier will arrive after all previous writes.  For most
+ * ia64 platforms, this is a simple 'mf.a' instruction.
+ */
+static inline void ___ia64_mmiowb(void)
+{
+	ia64_mfa();
+}
+
+#define __ia64_mmiowb	___ia64_mmiowb
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
