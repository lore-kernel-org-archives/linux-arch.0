From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [patch 04/17] get_cycles() : powerpc64 HAVE_GET_CYCLES
Date: Wed, 26 Nov 2008 07:42:50 -0500
Message-ID: <20081126124634.937625732@polymtl.ca>
References: <20081126124246.800751190@polymtl.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.polymtl.ca ([132.207.4.11]:46295 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbYKZM6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Nov 2008 07:58:31 -0500
Content-Disposition: inline; filename=get-cycles-powerpc-have-get-cycles.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

This patch selects HAVE_GET_CYCLES and makes sure get_cycles_barrier() and
get_cycles_rate() are implemented.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: benh@kernel.crashing.org
CC: paulus@samba.org
CC: David Miller <davem@davemloft.net>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: linux-arch@vger.kernel.org
---
 arch/powerpc/Kconfig             |    1 +
 arch/powerpc/include/asm/timex.h |   11 +++++++++++
 2 files changed, 12 insertions(+)

Index: linux.trees.git/arch/powerpc/Kconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/Kconfig	2008-11-14 17:38:28.000000000 -0500
+++ linux.trees.git/arch/powerpc/Kconfig	2008-11-26 06:49:00.000000000 -0500
@@ -121,6 +121,7 @@ config PPC
 	select HAVE_DMA_ATTRS if PPC64
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
+	select HAVE_GET_CYCLES if PPC64
 
 config EARLY_PRINTK
 	bool
Index: linux.trees.git/arch/powerpc/include/asm/timex.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/timex.h	2008-11-12 18:15:48.000000000 -0500
+++ linux.trees.git/arch/powerpc/include/asm/timex.h	2008-11-26 06:49:00.000000000 -0500
@@ -7,6 +7,7 @@
  * PowerPC architecture timex specifications
  */
 
+#include <asm/time.h>
 #include <asm/cputable.h>
 #include <asm/reg.h>
 
@@ -46,5 +47,15 @@ static inline cycles_t get_cycles(void)
 #endif
 }
 
+static inline cycles_t get_cycles_rate(void)
+{
+	return tb_ticks_per_sec;
+}
+
+static inline void get_cycles_barrier(void)
+{
+	isync();
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TIMEX_H */

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
