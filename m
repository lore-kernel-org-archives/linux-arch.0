Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbfCAOEe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:04:34 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 09/20] sh/mmiowb: Add unconditional mmiowb() to arch_spin_unlock()
Date: Fri,  1 Mar 2019 14:03:37 +0000
Message-ID: <20190301140348.25175-10-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140337.dN2Mz5eDlZMKV28grajBWHCpDPRZ_XWGTDnCii7C0Yw@z>

The mmiowb() macro is horribly difficult to use and drivers will continue
to work most of the time if they omit a call when it is required.

Rather than rely on driver authors getting this right, push mmiowb() into
arch_spin_unlock() for sh. If this is deemed to be a performance issue,
a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
the barrier in cases where no I/O writes were performed inside the
critical section.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/Kbuild          |  1 -
 arch/sh/include/asm/io.h            |  3 ---
 arch/sh/include/asm/mmiowb.h        | 12 ++++++++++++
 arch/sh/include/asm/spinlock-llsc.h |  2 ++
 4 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 arch/sh/include/asm/mmiowb.h

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index e3f6926c4b86..a6ef3fee5f85 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 4f7f235f15f8..c28e37a344ad 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -229,9 +229,6 @@ __BUILD_IOPORT_STRING(q, u64)
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-/* synco on SH-4A, otherwise a nop */
-#define mmiowb()		wmb()
-
 /* We really want to try and get these to memcpy etc */
 void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
 void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
diff --git a/arch/sh/include/asm/mmiowb.h b/arch/sh/include/asm/mmiowb.h
new file mode 100644
index 000000000000..535d59735f1d
--- /dev/null
+++ b/arch/sh/include/asm/mmiowb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_MMIOWB_H
+#define __ASM_SH_MMIOWB_H
+
+#include <asm/barrier.h>
+
+/* synco on SH-4A, otherwise a nop */
+#define mmiowb()			wmb()
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* __ASM_SH_MMIOWB_H */
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index 786ee0fde3b0..7fd929cd2e7a 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -47,6 +47,8 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
 
+	/* This could be optimised with ARCH_HAS_MMIOWB */
+	mmiowb();
 	__asm__ __volatile__ (
 		"mov		#1, %0 ! arch_spin_unlock	\n\t"
 		"mov.l		%0, @%1				\n\t"
-- 
2.11.0
