Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.polymtl.ca ([132.207.4.11]:54283 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbYJQAE4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Oct 2008 20:04:56 -0400
Message-ID: <20081016234656.055839676@polymtl.ca>
References: <20081016232729.699004293@polymtl.ca>
Date: Thu, 16 Oct 2008 19:27:33 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 04/15] get_cycles() : powerpc64 HAVE_GET_CYCLES
Content-Disposition: inline; filename=get-cycles-powerpc-have-get-cycles.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>
Cc: David Miller <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, benh@kernel.crashing.org, paulus@samba.org, Ingo Molnar <mingo@redhat.com>
Message-ID: <20081016232733.UvbzNIpmHYyY82pmzolCL-0_RGry7hEZ0_RfRcM9NXg@z>

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
 arch/powerpc/include/asm/timex.h |   13 +++++++++++++
 2 files changed, 14 insertions(+)

Index: linux-2.6-lttng/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/Kconfig	2008-10-16 12:25:48.000000000 -0400
+++ linux-2.6-lttng/arch/powerpc/Kconfig	2008-10-16 12:33:31.000000000 -0400
@@ -122,6 +122,7 @@ config PPC
 	select HAVE_DMA_ATTRS if PPC64
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
+	select HAVE_GET_CYCLES if PPC64
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6-lttng/arch/powerpc/include/asm/timex.h
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/include/asm/timex.h	2008-10-16 12:25:48.000000000 -0400
+++ linux-2.6-lttng/arch/powerpc/include/asm/timex.h	2008-10-16 12:33:58.000000000 -0400
@@ -46,5 +46,18 @@ static inline cycles_t get_cycles(void)
 #endif
 }
 
+static inline cycles_t get_cycles_rate(void)
+{
+	return CLOCK_TICK_RATE;
+}
+
+/*
+ * To check : assuming mtfb requires isync to synchronize instruction execution.
+ */
+static inline void get_cycles_barrier(void)
+{
+	isync();
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TIMEX_H */

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
