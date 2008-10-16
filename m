From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 02/15] get_cycles() : x86 HAVE_GET_CYCLES
Date: Thu, 16 Oct 2008 19:27:31 -0400
Message-ID: <20081016234655.754205834@polymtl.ca>
References: <20081016232729.699004293@polymtl.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759224AbYJPX7P@vger.kernel.org>
Content-Disposition: inline; filename=get-cycles-x86-have-get-cycles.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steve
Cc: David Miller <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

This patch selects HAVE_GET_CYCLES and makes sure get_cycles_barrier() and
get_cycles_rate() are implemented.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: David Miller <davem@davemloft.net>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: linux-arch@vger.kernel.org
---
 arch/x86/Kconfig      |    1 +
 include/asm-x86/tsc.h |   12 ++++++++++++
 2 files changed, 13 insertions(+)

Index: linux-2.6-lttng/arch/x86/Kconfig
===================================================================
--- linux-2.6-lttng.orig/arch/x86/Kconfig	2008-10-16 13:07:04.000000000 -0400
+++ linux-2.6-lttng/arch/x86/Kconfig	2008-10-16 13:07:12.000000000 -0400
@@ -19,6 +19,7 @@ config X86_64
 config X86
 	def_bool y
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_GET_CYCLES
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_IOREMAP_PROT
Index: linux-2.6-lttng/include/asm-x86/tsc.h
===================================================================
--- linux-2.6-lttng.orig/include/asm-x86/tsc.h	2008-10-16 13:07:04.000000000 -0400
+++ linux-2.6-lttng/include/asm-x86/tsc.h	2008-10-16 13:07:24.000000000 -0400
@@ -50,6 +50,18 @@ extern void mark_tsc_unstable(char *reas
 extern int unsynchronized_tsc(void);
 int check_tsc_unstable(void);
 
+static inline cycles_t get_cycles_rate(void)
+{
+	if (check_tsc_unstable())
+		return 0;
+	return tsc_khz;
+}
+
+static inline void get_cycles_barrier(void)
+{
+	rdtsc_barrier();
+}
+
 /*
  * Boot-time check whether the TSCs are synchronized across
  * all CPUs/cores:

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
