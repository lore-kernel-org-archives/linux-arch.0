From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 4/8] powerpc/processor: Move cpu_relax() into
 asm/vdso/processor.h
Date: Tue, 28 Apr 2020 13:16:50 +0000 (UTC)
Message-ID: <d2751eb1f030d22607f63ddd4cd510e6d5a529c7.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:51161 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgD1NQx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:53 -0400
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org, linux-arch@vger.kernel.org

cpu_relax() need to be in asm/vdso/processor.h to be used by
the C VDSO generic library.

Move it there.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/processor.h      | 10 ++--------
 arch/powerpc/include/asm/vdso/processor.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/processor.h

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index bfa336fbcfeb..8390503c44a2 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -6,6 +6,8 @@
  * Copyright (C) 2001 PPC 64 Team, IBM Corp
  */
 
+#include <vdso/processor.h>
+
 #include <asm/reg.h>
 
 #ifdef CONFIG_VSX
@@ -63,14 +65,6 @@ extern int _chrp_type;
 
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
-/* Macros for adjusting thread priority (hardware multi-threading) */
-#define HMT_very_low()   asm volatile("or 31,31,31   # very low priority")
-#define HMT_low()	 asm volatile("or 1,1,1	     # low priority")
-#define HMT_medium_low() asm volatile("or 6,6,6      # medium low priority")
-#define HMT_medium()	 asm volatile("or 2,2,2	     # medium priority")
-#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
-#define HMT_high()	 asm volatile("or 3,3,3	     # high priority")
-
 #ifdef __KERNEL__
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..39b9beace9ca
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+/* Macros for adjusting thread priority (hardware multi-threading) */
+#define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
+#define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
+#define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
+#define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
+#define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
+#define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
+
+#ifdef CONFIG_PPC64
+#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+#else
+#define cpu_relax()	barrier()
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.25.0
