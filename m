Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.polymtl.ca ([132.207.4.11]:48513 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbYKLXeQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Nov 2008 18:34:16 -0500
Message-Id: <20081112232258.879525496@polymtl.ca>
References: <20081112231551.473569400@polymtl.ca>
Date: Wed, 12 Nov 2008 18:15:55 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [patch 04/17] get_cycles() : powerpc64 HAVE_GET_CYCLES
Content-Disposition: inline; filename=get-cycles-powerpc-have-get-cycles.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org

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
--- linux.trees.git.orig/arch/powerpc/Kconfig	2008-11-07 00:34:11.000000000 -0500
+++ linux.trees.git/arch/powerpc/Kconfig	2008-11-12 18:00:10.000000000 -0500
@@ -121,6 +121,7 @@ config PPC
 	select HAVE_DMA_ATTRS if PPC64
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
+	select HAVE_GET_CYCLES if PPC64
 
 config EARLY_PRINTK
 	bool
Index: linux.trees.git/arch/powerpc/include/asm/timex.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/timex.h	2008-11-07 00:34:11.000000000 -0500
+++ linux.trees.git/arch/powerpc/include/asm/timex.h	2008-11-12 18:00:10.000000000 -0500
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
