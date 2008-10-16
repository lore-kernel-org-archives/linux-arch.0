From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 09/15] LTTng mips export hpt frequency
Date: Thu, 16 Oct 2008 19:27:38 -0400
Message-ID: <20081016234656.889753679@polymtl.ca>
References: <20081016232729.699004293@polymtl.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757124AbYJPXzs@vger.kernel.org>
Content-Disposition: inline; filename=lttng-mips-export-hpt-frequency.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steve
Cc: David Miller <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

LTTng needs it from modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/kernel/time.c  |    1 +
 include/asm-mips/timex.h |    2 ++
 2 files changed, 3 insertions(+)

Index: linux-2.6-lttng/include/asm-mips/timex.h
===================================================================
--- linux-2.6-lttng.orig/include/asm-mips/timex.h	2008-10-16 18:16:37.000000000 -0400
+++ linux-2.6-lttng/include/asm-mips/timex.h	2008-10-16 18:16:44.000000000 -0400
@@ -63,6 +63,8 @@ static inline cycles_t get_cycles(void)
 }
 #endif
 
+extern unsigned int mips_hpt_frequency;
+
 #endif /* __KERNEL__ */
 
 #endif /*  _ASM_TIMEX_H */
Index: linux-2.6-lttng/arch/mips/kernel/time.c
===================================================================
--- linux-2.6-lttng.orig/arch/mips/kernel/time.c	2008-10-16 18:16:32.000000000 -0400
+++ linux-2.6-lttng/arch/mips/kernel/time.c	2008-10-16 18:16:44.000000000 -0400
@@ -70,6 +70,7 @@ EXPORT_SYMBOL(perf_irq);
  */
 
 unsigned int mips_hpt_frequency;
+EXPORT_SYMBOL(mips_hpt_frequency);
 
 void __init clocksource_set_clock(struct clocksource *cs, unsigned int clock)
 {

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
